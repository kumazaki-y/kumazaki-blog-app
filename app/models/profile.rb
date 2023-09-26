# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  birthday     :date
#  gender       :integer
#  introduction :text
#  nickname     :string
#  subscribed   :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
    enum gender: { male: 0, female: 1, other: 2 } #genderカラムを選択し指定したいハッシュを記述。この中からしか選べない。日本語化は別に行う。
    belongs_to :user
    has_one_attached :avatar #画像をアップロードできるようになるメソッドを定義。ターミナルで１回rails active_storage:install」を実行しておけば以降は画像UPの設定ができる。

  def age
    return '不明' unless birthday.present? #誕生日が無ければ不明を返す
    years = Time.zone.now.year - birthday.year #現在の年-誕生年
    days = Time.zone.now.yday - birthday.yday #現在の日-誕生日

    if days < 0
      "#{years - 1}歳"
    else
      "#{years}歳"
    end
  end
end
