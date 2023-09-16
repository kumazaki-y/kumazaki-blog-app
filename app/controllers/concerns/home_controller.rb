class HomeController < ApplicationController #APから継承
    def index #railsで定義されているメソッド。様々な処理を内包する。
        @article = Article.first #インスタンス変数。indexメソッドを実行して表示されるerb内で使用可能
        #Articleモデルのデータベースからデータを取得するメソッド
    end

    def about
        render "home/about" #homeフォルダのaboutファイルを表示する。indexメソッドには初期搭載されているため省略される。
    end
end