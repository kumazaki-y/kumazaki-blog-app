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

    def new
        @article = Article.new #Articleモデルにnewを行い、中身が空のデータを新しく作る。既存の機能でrenderを実行しなくともnew.html.erbを探し表示させる。
    end

    def create
        @article = Article.new(article_params) #データが空の箱を作る。引数で箱にはtitleとcontentを入れるスペースがある。
        if @article.save #作成したデータを保存するメソッド。保存できたかを確認するためif文で保存できたらその投稿のページに遷移するようにする
            redirect_to article_path(@article), notice: '保存できたよ'#noticeと文字列はflashメッセージのキーとバリュー
            #↑指定したpathのページに遷移するメソッド。article_pathと引数で記事の該当ページへの遷移を指定。noticeで遷移時の文言を指定（HTMLにも要記載）
        else
            flash.now[:error] = '保存に失敗しました' #保存できなかった場合のflashメッセージをキーとバリューで指定。redirect時とは書き方が異なるが処理は同じ
            render :new#保存できなかった場合にnewを実行。
                        #これで表示されたnew.html.erb内の@articlesは本メソッド内で定義された変数であり、表示前の入力データが一時保存されて表示される。
        end
    end

    private #paramsのメソッドを作る際にはつけることになっている
    def article_params #ブラウザ側からサーバーに送られるデータ（パラメーター）のうち、何を保存するか選択するメソッドを作成する。
                        #_paramsの前は更新するモデル名に合わせるルール。今回はArticleモデルのデータを更新する
        params.require(:article).permit(:title, :content)
        #送られたデータはハッシュの形になっているので、その中のキーがarticleのデータだけ読み込み、さらにデータのtitleとcontentだけ保存を許可する処理
        #ブラウザ側から不正なデータを送られて保存してしまわないようにセキュリティ上かなり重要
    end

end