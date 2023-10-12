#ファイル名は複数形が慣例

FactoryBot.define do
    factory :user do #userのダミーデータを作成する。
      email { Faker::Internet.email } #ダミーデータの内容
      password { 'password' }
    end
  end