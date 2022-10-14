require 'rails_helper'

RSpec.describe '祖先の投稿', type: :system do
  describe '一覧表示' do
    let!(:grand_parent_post) { create(:post, content: 'しりとり') }
    let!(:parent_post) { create(:post, content: 'りんご', parent: grand_parent_post) }
    let!(:post) { create(:post, content: 'ごりら', parent: parent_post) }

    it '一覧が表示される' do
      visit root_path
      find("[data-testid='post-link-#{grand_parent_post.id}']").click
      expect(page).to have_content 'しりとり'
      expect(page).to have_current_path post_path(grand_parent_post)

      find("[data-testid='post-link-#{parent_post.id}']").click
      expect(page).to have_content 'りんご'
      expect(page).to have_current_path post_path(parent_post)
      expect(page).to have_content 'しりとり'

      find("[data-testid='post-link-#{post.id}']").click
      expect(page).to have_content 'ごりら'
      expect(page).to have_current_path post_path(post)
      expect(page).to have_content 'しりとり'
      expect(page).to have_content 'りんご'
    end
  end
end
