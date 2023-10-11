namespace :notification do #rake taskの設定。こういう書き方をする
    desc '利用者にメールを送付する' #どんな処理が行われるかの説明。ターミナルで見れる。
  
    task send_emails_from_admin: :environment do #「rails namespace:task」で実行可能（例　db:migrate)
      puts 'はじめての Rake task'
    end
  end