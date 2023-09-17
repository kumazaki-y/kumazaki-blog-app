class ArticlesController < ApplicationController #APから継承。DAY８の処理でhomecontrolle→articlescontrollerに変更（名称は基本的に複数形）。
    def index #railsで定義されているメソッド。様々な処理を内包する。
        @articles = Article.all #インスタンス変数。indexメソッドを実行して表示されるerb内で使用可能。.firstなら1個目、.allなら全てのデータを取得
        #Articleモデルのデータベースからデータを取得するメソッド
    end

    # def about DAY８の処理に不要なのでコメントアウト。ファイルも削除
        # render "home/about" #homeフォルダのaboutファイルを表示する。indexメソッドには初期搭載されているため省略される
        # DAY８追加コメント（indexのrenderではself/indexのような形になってる気がする。だからindexで呼び出すディレクトリ名も変える必要がある）
    # end

    def show
        @article = Article.find(params[:id]) #ArticleモデルDBから指定されたIDのデータを取得する。paramsはパラメータ的な意味。:idと記載するルール
    end
end