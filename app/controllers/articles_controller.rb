class ArticlesController < ApplicationController # APから継承。DAY８の処理でhomecontrolle→articlescontrollerに変更（名称は基本的に複数形）。
  before_action :set_article, only: %i[show edit update]
  # 繰り返し使用するコードを自動で各メソッドの一番最初に定義するアクション。onlyで特定のメソッドだけに適用できる。
  # 繰り返したいコードはset_articleメソッド内に定義しておく。

  def index # railsで定義されているメソッド。様々な処理を内包する。
    @articles = Article.all # インスタンス変数。indexメソッドを実行して表示されるerb内で使用可能。.firstなら1個目、.allなら全てのデータを取得
    # Articleモデルのデータベースからデータを取得するメソッド
  end

  # def about DAY８の処理に不要なのでコメントアウト。ファイルも削除
  # render "home/about" #homeフォルダのaboutファイルを表示する。indexメソッドには初期搭載されているため省略される
  # DAY８追加コメント（indexのrenderではself/indexのような形になってる気がする。だからindexで呼び出すディレクトリ名も変える必要がある）
  # end

  def show # ↓before_actionを設定しているので不要。
    # @article = Article.find(params[:id]) #ArticleモデルDBから指定されたIDのデータを取得する。paramsはパラメータ的な意味。:idと記載するルール
  end

  def new
    @article = Article.new # Articleモデルにnewを行い、中身が空のデータを新しく作る。既存の機能でrenderを実行しなくともnew.html.erbを探し表示させる。
  end

  def create
    @article = Article.new(article_params) # データが空の箱を作る。引数で箱にはtitleとcontentを入れるスペースがある。
    if @article.save # 作成したデータを保存するメソッド。保存できたかを確認するためif文で保存できたらその投稿のページに遷移するようにする
      redirect_to article_path(@article), notice: '保存できたよ' # noticeと文字列はflashメッセージのキーとバリュー
    # ↑指定したpathのページに遷移するメソッド。article_pathと引数で記事の該当ページへの遷移を指定。noticeで遷移時の文言を指定（HTMLにも要記載）
    else
      flash.now[:error] = '保存に失敗しました' # 保存できなかった場合のflashメッセージをキーとバリューで指定。redirect時とは書き方が異なるが処理は同じ
      render :new # 保存できなかった場合にnewを実行。
      # これで表示されたnew.html.erb内の@articlesは本メソッド内で定義された変数であり、表示前の入力データが一時保存されて表示される。
    end
  end

  def edit # ↓before_actionを設定しているので不要。
    # @article = Article.find(params[:id]) #DBからparamsのIDに該当する情報を抜き出す。ID１なら１記事目の編集画面が出るようにedit.html.erbを作成
  end

  def update # ↓before_actionを設定しているので不要。
    # @article = Article.find(params[:id]) #リクエスト時のURLにidが記載されているため、サーバー側で該当IDを受け取ることができる。
    # 受け取ったそのIDがparamsに反映される。反映されたidに該当するデータを抜き出す
    if @article.update(article_params) # 値を更新するメソッド。article_paramでどの値を更新するか決める。今回はtitleとcontentが指定されている
      redirect_to article_path(@article), notice: '更新できました' # createメソッドと同内容で文字列だけ変更
    else
      flash.now[:error] = '更新に失敗しました'
      render :new
    end
  end

  def destroy # 本メソッド内のarticleはメソッド内だけで処理が完結しており、erbに記述する必要がないのでインスタンス変数にはしない。
    # インスタンス変数にしてしまうとrailsに慣れた人に「もしかしてerbに記載しているのかな？」と誤解させてしまう可能性が高いため。
    article = Article.find(params[:id]) # 削除したいデータを取得
    article.destroy! # データを削除するメソッド。！は無くても実行可。！あると処理が完了しなかった場合に例外が発生しエラーになる
    redirect_to root_path, notice: '削除に成功しました' # 削除したら記事一覧に戻り、通知を出す
  end

  private # paramsのメソッドを作る際にはつけることになっている

  def article_params # ブラウザ側からサーバーに送られるデータ（パラメーター）のうち、何を保存するか選択するメソッドを作成する。
    # _paramsの前は更新するモデル名に合わせるルール。今回はArticleモデルのデータを更新する
    params.require(:article).permit(:title, :content)
    # 送られたデータはハッシュの形になっているので、その中のキーがarticleのデータだけ読み込み、さらにデータのtitleとcontentだけ保存を許可する処理
    # ブラウザ側から不正なデータを送られて保存してしまわないようにセキュリティ上かなり重要
  end

  def set_article # before_actionで指定する繰り返し使いたいコードを内包したメソッド
    @article = Article.find(params[:id])
  end
end
