require 'rails_helper'

RSpec.describe '返信', type: :system do
  describe '一覧表示' do
    let!(:parent_post) { create(:post, content: 'こんにちは') }

    before do
      create(:post, content: 'オラ', parent: parent_post)
      create(:post, content: 'ボンジョルノ', parent: parent_post)
    end

    it '一覧が表示される' do
      visit root_path
      find("[data-testid='post-link-#{parent_post.id}']").click

      expect(page).to have_content 'こんにちは'
      expect(page).to have_content 'オラ'
      expect(page).to have_content 'ボンジョルノ'
      expect(page).to have_current_path post_path(parent_post)
    end
  end
end
