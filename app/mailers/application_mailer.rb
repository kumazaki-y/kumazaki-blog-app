class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com' #指定したアドレスからメールを送信するように設定。
  layout 'mailer' #メールのレイアウトはviewsのmailerファイルを使用。
end
