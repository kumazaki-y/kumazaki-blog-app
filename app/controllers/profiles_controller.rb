class ProfilesController < ApplicationController
    before_action :authenticate_user! #ログインしていないと処理が実行されない。

    def show
        @profile = current_user.profile
    end
  
    def edit
        @profile = current_user.prepare_profile #簡略化したメソッドに置き換え。現在ログイン中ユーザーのプロフィールの有無で処理が変わる。
        # @profile = current_user.build_profile #ログイン中ユーザーのプロフィール作成。単数の時はこの書き方になる
    end

    def update
        @profile = current_user.prepare_profile #メソッドに置き換え
        @profile.assign_attributes(profile_params) #インスタンスに取得したparamsを与える
        # @profile = current_user.build_profile(profile_params)
        if @profile.save
        redirect_to profile_path, notice: 'プロフィール更新！'
        else
        flash.now[:error] = '更新できませんでした'
        render :edit
        end
    end

    private
    def profile_params
        params.require(:profile).permit(
        :nickname,
        :introduction,
        :gender,
        :birthday,
        :subscribed,
        :avatar
        )
    end
  end