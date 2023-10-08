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

  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy #中間テーブルと自分を紐付け
  has_many :followings, through: :following_relationships, source: :following #中間テーブルを介して自分以外のユーザーと紐付け。sourceでどのカラムと紐づけるか指定。
  #following_relationshipsは自分がフォローしている、の意味で命名（どのモデルか判断できないのでクラス名を指定する必要がある）。
  #「自分がフォロワーになっている＝自分がフォローしているユーザー」なので外部キーはfollower_idとする。

  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  #逆に自分のフォロワーになっているユーザーの情報と紐付け。今回は「自分以外のユーザーから見たら」という視点で紐付けする。
  #「自分をフォローしている＝自分のフォロワーのユーザー」なので外部キーはfollowingとする。followerの値は自分。

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

  def follow!(user)
    user_id = get_user_id(user)
    following_relationships.create!(following_id: user_id)#followerIDは自分の外部キーなので、followingを取得することでフォロー関係が成立する。
  end

  def unfollow!(user) #例外処理が組み込まれてますよと表現するためにメソッド名にも！をつけている
    user_id = get_user_id(user)
    relation = following_relationships.find_by!(following_id: user_id)#ユーザーが存在しないとフォローできないので、これらのメソッドには！をつける
    relation.destroy! #先にfind_byで削除したい値を見つけてからデストロイする。
  end

  def has_followed?(user) #フォローしているか確認するメソッドを設定。
    following_relationships.exists?(following_id: user.id)
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

  private #プライベートメソッドはこのファイル内でしか使用できない。
  def get_user_id(user)
    if user.is_a?(User)#userはUserクラスのインスタンスかを確認。
      user.id
    else
      user #Userクラスのインスタンスでなかった場合に、userの情報（ID）をそのまま渡すように設定。つまり、別のコントローラーでuseridを渡す設定ができていない時でもidを渡せるようになる。
    end #たとえばuserIDが’２’という文字列だったとしても、そのまま渡してIDを取得できる。
  end

end
