Rails.application.routes.draw do #
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index' #DAY8でhome#index→articles#indexに変更。呼び出すファイル名も変更必要
  #rootは”/”を意味する。特に指定がなければhomecontrollerのindexメソッドを実行。
  #また、html.erbでroot_pathメソッドを実行すると"/"ページへのURLが生成される

  #get '/' => 'home#index'
  #↑ブラウザからサーバーへゲットリクエストが来た時にhomecontrollerのindexメソッドを実行。rootがあるのでコメントアウト
   get '/about' => 'home#about' #同上でaboutメソッドを実行

  resources :articles, only: [:show, :new, :create]
  #resourcesはURLを作成する機能。onlyを書くと、様々な機能のURLが作成されるがその中で指定したものだけを使用する意味になる
  #それぞれarticles_controllerの同名メソッドが実行され、
  #newは新しい投稿を作成するためのフォームとしてrailsのCRUDに含まれている
end

