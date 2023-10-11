class AccountsController < ApplicationController
    def show
      @user = User.find(params[:id])
      if @user == current_user
        redirect_to profile_path
      end #自分のアイコンをクリックした時は自分のプロフィールページに遷移するように設定。
    end
  end