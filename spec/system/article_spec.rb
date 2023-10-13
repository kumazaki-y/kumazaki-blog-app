
require 'rails_helper'

RSpec.describe 'Article', type: :system do #describは何に関するテストか、typeはこれがsystem specだと伝えるため
    let!(:user) { create(:user) }
    let!(:articles) { create_list(:article, 3, user: user) }

    it '記事一覧がひょうじされる' do
        visit root_path #該当パスのブラウザを開くメソッド

        articles.each do |article|
            expect(page).to have_css('.card_title', text: article.title) #articleをすべて取得して、該当クラスの要素にarticleのtitleが存在するかを確認するメソッド
        end
    end

    it '記事詳細を表示できる' do
        visit root_path

        article = articles.first #最初の記事を取得
        click_on article.title #titleをクリックするメソッド。aタグくらいにしか使用できない。

        expect(page).to have_css('.article_title', text: article.title) #titleとcontentが表示されていることを確認
        expect(page).to have_css('.article_content', text: article.content.to_plain_text)
    end
end