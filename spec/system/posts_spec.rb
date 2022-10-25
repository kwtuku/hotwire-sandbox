require 'rails_helper'

RSpec.describe '投稿', type: :system do
  describe '一覧表示' do
    before do
      create(:post, content: 'こんにちは')
      create(:post, content: 'オラ')
      create_list(:post, 23)
      create(:post, content: 'こんばんは')
    end

    it '一覧が表示される、スクロールするとさらに投稿が表示される' do
      visit root_path

      expect(page).to have_content 'こんばんは'
      expect(page).to have_content 'オラ'
      expect(page).not_to have_content 'こんにちは'

      execute_script('window.scrollBy(0,10000)')

      expect(page).to have_content 'こんにちは'
    end
  end

  describe '詳細表示' do
    let!(:post) { create(:post, content: 'ボンジュール') }

    it '詳細が表示される' do
      visit root_path
      find("[data-testid='post-link-#{post.id}']").click

      expect(page).to have_content 'ボンジュール'
      expect(page).to have_current_path post_path(post)
    end
  end
end
