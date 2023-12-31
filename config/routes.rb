require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development? #sidekiq上のジョブ状況を見れるように設定
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development? #デベロップ環境で指定のURLにアクセスするとメールが見れるようになる設定

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index' # DAY8でhome#index→articles#indexに変更。呼び出すファイル名も変更必要
  # rootは”/”を意味する。特に指定がなければhomecontrollerのindexメソッドを実行。
  # また、html.erbでroot_pathメソッドを実行すると"/"ページへのURLが生成される

  # get '/' => 'home#index'
  # ↑ブラウザからサーバーへゲットリクエストが来た時にhomecontrollerのindexメソッドを実行。rootがあるのでコメントアウト
  #get '/about' => 'home#about' # 同上でaboutメソッドを実行

  resources :articles

  resources :accounts, only: [:show] do  #各ユーザーのプロフィールページに遷移できるように設定。userのURLはdeviseが使用しているので便宜的にaccountsとする。
    resources :follows, only: [:create] #フォロー機能を実装するために設定。
    resources :unfollows, only: [:create] #フォロー外す用。fllouwsにデストロイを追加する方法を採用しない理由として、railsのシンプルに設計したい思想を意識。
  end

  scope module: :apps do #controllerを「apps/〇〇〜」となるように変更。URLにappsを加える必要性がない。そういう時は利用者の混乱を避けるためにモジュールを使うという思想
    resources :favorites, only: [:index]
    resource :timeline, only: [:show]#タイムラインは一人一つなので単数

    resource :profile, only: [:show, :edit, :update]#プロフィールは一人一つなので単数で作成。URLもindexが作成されない。
  end

  namespace :api, defaults: {format: :json} do #apiに関するものだとわかるようにURLとコントローラーディレクトリを変更できる。formatはjsonを指定するとjsで動くようになる。
    scope '/articles/:article_id' do #URLだけを変更できる
      resources :comments, only: [:index, :create]
      resource :like, only: [:show, :create, :destroy]#destroyのしやすさ重視で単数。いいねは中間テーブルに新たなデータを作る作業なのでcreate。
    end
  end
end


 #入れ子にすることでarticles/comenntsのようなURLを作れる。
  # resourcesはURLを作成する機能。onlyを書くと、様々な機能のURLが作成されるがその中で指定したものだけを使用する意味になる
  # それぞれarticles_controllerの同名メソッドが実行される
  # newは新しい投稿を作成するためのフォームとしてrailsのCRUDに含まれている
  # updateを実行すると「localhost:3000/rails/info/routes」ページのarticle_pathにPUTとPATCHリクエストが追加される。
  # PUTとPATCHのURLは共にGETリクエストと同じだが、URLは同じでもリクエスト内容が異なるのでサーバー側での挙動も異なる。
  # GETは取得、PUTは更新（または作成）、PATCHは部分更新、DELETEは削除
  # destroyの追加でDELETEリクエストが追加される。