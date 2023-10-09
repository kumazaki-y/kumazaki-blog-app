class CommentsController < ApplicationController

  def index
    article = Article.find(params[:article_id])
    comments = article.comments
    render json: comments #記事のコメントのデータをjsに渡す。
  end


    def new
        article = Article.find(params[:article_id]) #article_idを引数にして記事情報を取得する
        @comment = article.comments.build #取得した記事に紐づくコメントを作成するメソッドをインスタンスへ
    end

    def create
        article = Article.find(params[:article_id]) #記事をarticle_idで検索して取得
        @comment = article.comments.build(comment_params) #コメント作成メソッドをインスタンスにしないとrender:newがエラーになる
        @comment.save! #保存できたかはjs側で判定してくれるので、処理が完了する前提として！をつけている。
        render json: @comment #jsに保存したコメントデータを送る。

        # if @comment.save
        #   redirect_to article_path(article), notice: 'コメントを追加'
        # else
        #   flash.now[:error] = '更新できませんでした'
        #   render :new
        # end　jsで処理するためコメントアウト

      end
    
      private
      def comment_params
        params.require(:comment).permit(:content) #contentしか保存できない設定
      end
end