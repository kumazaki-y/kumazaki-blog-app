#ファイル名は複数形が慣例

FactoryBot.define do
    factory :user do #userのダミーデータを作成する。
      email { Faker::Internet.email } #ダミーデータの内容
      password { 'password' }

      trait :with_profile do #userの作成と同時に紐づくプロフィールを作成するメソッドを定義
        after :build do |user| #userが作られた後に
          build(:profile, user: user) #profileを作成。userの値も取得できる。
        end
      end
    end
  end