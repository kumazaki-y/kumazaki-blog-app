require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let!(:user) { create(:user) }
  let!(:articles) { create_list(:article, 3, user: user) } #listで複数同時に作成できる。今回は３個


  describe 'GET /articles' do #何についてのテストか
    it '200ステータスが返ってくる' do
      get articles_path #該当パスにリクエスト送るメソッド
      expect(response).to have_http_status(200) #記事がなくてもレスポンス返ってくるが、意味ないのでダミーデータを作成する
    end
  end

  describe 'POST /articles' do
    context 'ログインしている場合' do #POSTリクエストはログインしてないと実行できないため
      before do
        sign_in user #deviseのメソッド。ログインできる。
      end

      it '記事が保存される' do 
        article_params = attributes_for(:article) #POSTなのでparams渡す。attriburesメソッドで作れる
        post articles_path({article: article_params})
        expect(response).to have_http_status(302) #リダイレクトしているかもテストするので302
        expect(Article.last.title).to eq(article_params[:title]) #DBに保存されている最後の記事が送ったparamsと同じタイトルなら保存成功したと考えられる。
        expect(Article.last.content.body.to_plain_text).to eq(article_params[:content])
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        article_params = attributes_for(:article)
        post articles_path({article: article_params})
        expect(response).to redirect_to(new_user_session_path) #該当のpathにリダイレクトするかをテスト
      end
    end
  end
end
