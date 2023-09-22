Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index' # DAY8でhome#index→articles#indexに変更。呼び出すファイル名も変更必要
  # rootは”/”を意味する。特に指定がなければhomecontrollerのindexメソッドを実行。
  # また、html.erbでroot_pathメソッドを実行すると"/"ページへのURLが生成される

  # get '/' => 'home#index'
  # ↑ブラウザからサーバーへゲットリクエストが来た時にhomecontrollerのindexメソッドを実行。rootがあるのでコメントアウト
  #get '/about' => 'home#about' # 同上でaboutメソッドを実行

  resources :articles # , only: [:show, :new, :create, :edit, :update, :destroy]
  # ↑onlyで限定していたが、最終的にindex以外はすべて使っているのでonly不要。refactoring（コードの整理）作業によりコメントアウト
  # resourcesはURLを作成する機能。onlyを書くと、様々な機能のURLが作成されるがその中で指定したものだけを使用する意味になる
  # それぞれarticles_controllerの同名メソッドが実行される
  # newは新しい投稿を作成するためのフォームとしてrailsのCRUDに含まれている
  # updateを実行すると「localhost:3000/rails/info/routes」ページのarticle_pathにPUTとPATCHリクエストが追加される。
  # PUTとPATCHのURLは共にGETリクエストと同じだが、URLは同じでもリクエスト内容が異なるのでサーバー側での挙動も異なる。
  # GETは取得、PUTは更新（または作成）、PATCHは部分更新、DELETEは削除
  # destroyの追加でDELETEリクエストが追加される。
end
