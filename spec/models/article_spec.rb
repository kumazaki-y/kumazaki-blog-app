require 'rails_helper' #このファイルにテストしたい内容を書く

RSpec.describe Article, type: :model do
  let!(:user) { create(:user) } #factories/usersから読み込んだ形式でダミーデータを作成。createのuserシンボルもそこから取得
   #context外に設定することで、各contextに適用される
   #letは変数を定義している。「user=User.create」的な状態になる。rspecではこのように書くことになっている

  context 'タイトルと内容が入力されている場合' do #前提条件
    let!(:article) { build(:article, user: user) } #記事はユーザーと紐付け。「user:（前段でcreateされた）user」という見方

    it '記事を保存できる' do #前提があって結果がある。
      expect(article).to be_valid #「記事が有効であることを期待する」と読める。be_validのほか、さまざまなテスト機能がある。
      #ターミナルで「bundle exec rspec spec/models/article_spec.rb」でテスト実行可能
    end
  end

  context 'タイトルの文字が一文字の場合' do #保存できない場合もテストできる
    let!(:article) { build(:article, title: Faker::Lorem.characters(number: 1), user: user) }

    before do
      article.save #createは例外処理を発生させるのでbuildを使用し、別に保存コードを記述する。
    end

    it '記事を保存できない' do
      expect(article.errors.messages[:title][0]).to eq('は2文字以上で入力してください') #エラーメッセージが出るように設定
    end
  end

end
