class HomeController < ApplicationController #APから継承
    def index #railsで定義されているメソッド。様々な処理を内包する。
        @title = "デイトラ" #インスタンス変数。本メソッドを実行して表示されるerb内で使用可能
    end

    def about
        render "home/about" #homeフォルダのaboutファイルを表示する。indexメソッドには初期搭載されているため省略される。
    end
end