class FollowsController < ApplicationController
    before_action :authenticate_user! #ログインしてないとフォローできないように設定。
  
    def create
      current_user.follow!(params[:account_id]) #ユーザーモデルのfollowメソッドを実行。
      redirect_to account_path(params[:account_id]) #フォロー処理後、フォローしたページにリダイレクトするように設定。
    end
  end