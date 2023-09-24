# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #↓ここでarticlesやprofileを持たせていることで、コントローラーで.profileなどで呼び出すことができる
  has_many :articles, dependent: :destroy #ユーザーと記事を紐付けし、ユーザーが削除されたら記事も削除される。
                                          #ユーザーは記事を複数持つため複数形にする。railsはarticleテーブルのことだと理解し紐付けしてくれる。
  has_one :profile, dependent: :destroy #プロフィールは一人一つなので単数系
  has_many :likes, dependent: :destroy #ユーザーから見たら中間テーブルのいいねは複数対象なのでこの書き方で紐付け
  has_many :favorite_articles, through: :likes, source: :article #ユーザーと記事を中間テーブルを介して紐づける。
  #favorite_artclesテーブルは存在しないが、articlesにした場合の混同を避けるためこのように記述。sourceでテーブル名を記載。

  delegate :birthday, :age, :gender, to: :profile, allow_nil: true
  #これを書くことで下記のメソッドを定義するのと同様の効果がある。allow_nil:trueが&と同様のぼっち演算子の役割を持つ
  # def birthday
  #   profile&.birthday プロフィールがnilじゃない時だけメソッドを実行。こう書かないとnilにメソッドを実行しようとしてエラーになる。
  # end

  def has_written?(article) #複雑なコードはできるだけモデル等に定義しておき、views等ではメソッドで書くようにする
    articles.exists?(id: article.id) #exists?は、条件に合ったレコードが存在するかしないかを判定して値を返してくるメソッド。
  end

  def has_liked?(article)
    likes.exists?(article_id: article.id) #いいねが存在するかを判定。中間テーブルのarticle_idに値があるかで判断。
  end

  def display_name
    profile&.nickname || self.email.split('@').first #プロフィールがnilじゃなければニックネームが表示される。nilなら||後が実行
    #前が実行されなければユーザーのemailをsplitで指定した文字列の前後で配列にして分割し、firstで前を取得する。haml上では取得した値が表示される。
    #hamlの方ではユーザーが存在しているかif present?で確認し、存在している時だけ表示するように設定。
    #if文を書かないとnilに対してメソッドを実行するような形になりエラーが発生する。
    #↑ユーザーの存在有無による制限をDBディレクトリに記述したのでhamlからは削除した
  end

  def prepare_profile
    profile || build_profile #||はor。既にprofileがあればそれを表示、無ければ空の箱を作る。
  end


  def avatar_image
    if profile&.avatar&.attached?#attached?は画像がUPされているかを判断するメソッド。プロフィールがあり、画像があれば下記を実行。
      profile.avatar#プロフィールのアバターを表示
    else
      'default-avatar.png'
    end
  end

end
