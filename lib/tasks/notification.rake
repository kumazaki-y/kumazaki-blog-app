namespace :notification do #rake taskの設定。ターミナル上で「rails namespace:task」で実行可能（例　db:migrate)
    desc '利用者にメールを送付する' #どんな処理が行われるかの説明。ターミナルで見れる。

    task :send_emails_from_admin, ['msg'] => :environment do |task, args| #argsには引数の情報が入る。受け取りたい引数名がmsg。
        msg = args['msg'] #引数に入力された値をハッシュのように取れる。
        if msg.present? #引数が入力されていれば
            NotificationFromAdminJob.perform_later(msg) #その値を取得し非同期処理で送信
        else
            puts '送信できませんでした。メッセージを入力してくてださい。ex. rails notification:send_emails_from_admin\[こんにちは\]'
        end #できなかった場合に表示するエラー文を設定。これがあると失敗した時に助かる
    end
end