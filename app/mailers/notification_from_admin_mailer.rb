class NotificationFromAdminMailer < ApplicationMailer
    def notify(user, msg) 
      @msg = msg #haml用にインスタンス化。userはallをeachで取得するのでmsgだけでいい
      mail to: user.email, subject: 'お知らせ'
    end
  end