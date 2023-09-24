class LikesController < ApplicationController
    before_action :authenticate_user! #ログインしてないと実行できない
  
    def create
      article = Article.find(params[:article_id]) #記事の情報を取得
      article.likes.create!(user_id: current_user.id) #記事に紐づくいいねを作成。記事のidは上で取得しているのでユーザーidを取得。
      redirect_to article_path(article) #いいねした現在の記事に戻ってくる処理
    end

    def destroy
      article = Article.find(params[:article_id]) 
      like = article.likes.find_by!(user_id: current_user.id) #記事といいねが紐づいている中から、ログイン中ユーザーのIDのデータを取得
      like.destroy! #処理が止まったら困るので！つける
      redirect_to article_path(article)
    end

  end