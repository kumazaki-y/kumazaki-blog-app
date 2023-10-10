class LikesController < ApplicationController
    before_action :authenticate_user! #ログインしてないと実行できない
  

    def show
      article = Article.find(params[:article_id])
      like_status = current_user.has_liked?(article)#いいねがあるかを判定。
      render json: { hasLiked: like_status } #hamlを表示する必要ないので情報だけを返すように設定。JSなので欲しいハッシュはキャメルケースで記述。
    end

    def create
      article = Article.find(params[:article_id]) #記事の情報を取得
      article.likes.create!(user_id: current_user.id) #記事に紐づくいいねを作成。記事のidは上で取得しているのでユーザーidを取得。
      render json: { status: 'ok' } #更新できたかをjsで取得する処理
    end

    def destroy
      article = Article.find(params[:article_id]) 
      like = article.likes.find_by!(user_id: current_user.id) #記事といいねが紐づいている中から、ログイン中ユーザーのIDのデータを取得
      like.destroy! #処理が止まったら困るので！つける
      render json: { status: 'ok' }
    end

  end