# frozen_string_literal: true

module UserDecorator
    
    def display_name
        profile&.nickname || self.email.split('@').first #プロフィールがnilじゃなければニックネームが表示される。nilなら||後が実行
        #前が実行されなければユーザーのemailをsplitで指定した文字列の前後で配列にして分割し、firstで前を取得する。haml上では取得した値が表示される。
        #hamlの方ではユーザーが存在しているかif present?で確認し、存在している時だけ表示するように設定。
        #if文を書かないとnilに対してメソッドを実行するような形になりエラーが発生する。
        #↑ユーザーの存在有無による制限をDBディレクトリに記述したのでhamlからは削除した
      end

    def avatar_image
        if profile&.avatar&.attached?#attached?は画像がUPされているかを判断するメソッド。プロフィールがあり、画像があれば下記を実行。
          profile.avatar#プロフィールのアバターを表示
        else
          'default-avatar.png'
        end
    end
end