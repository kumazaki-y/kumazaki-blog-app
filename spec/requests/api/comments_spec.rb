require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:comments) { create_list(:comment, 3, article: article) }

  describe 'GET /api/comments' do
    it '200 Status' do
      get api_comments_path(article_id: article.id) #コメントは記事に紐づいているので、記事のIDを渡さないといけない
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body) #responseを見やすい形でbody部分だけ取得する
      expect(body.length).to eq 3 #コメントが３つあることを期待する。eqはイコール
      expect(body[0]['content']).to eq comments.first.content #取得した最初の値は最初のコメントとイコールなはず
      expect(body[1]['content']).to eq comments.second.content
      expect(body[2]['content']).to eq comments.third.content
    end
  end
end

#apiのspecは実際のコントローラーの階層と一緒にするとわかりやすい。これはapi/comments_controllerのテストなので同様の階層構造にする