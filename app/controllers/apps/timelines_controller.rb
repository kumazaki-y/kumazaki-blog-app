class Apps::TimelinesController < Apps::ApplicationController

    def show
        user_ids = current_user.followings.pluck(:id) #pluckで指定した値だけを取得できる。今回はログイン中ユーザーがフォローしているユーザーのIDを取得
        @articles = Article.where(user_id: user_ids) #Articleモデルから、pluckで取得したuser_idの記事だけを取得する。
    end
  end