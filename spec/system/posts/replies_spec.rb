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
      expect(page).to have_content 'こんにちは'
      click_link '2'
      expect(page).to have_content 'オラ'
      expect(page).to have_content 'ボンジョルノ'
      expect(page).to have_current_path post_posts_path(parent_post)
    end
  end

  describe '作成' do
    let!(:parent_post) { create(:post, content: 'こんばんは') }

    context '入力内容が正しいとき' do
      it '作成できる' do
        visit root_path
        expect(page).to have_content 'こんばんは'
        find("[data-testid='reply-new-link-#{parent_post.id}']").click
        expect(page).to have_content '投稿に返信'
        expect(page).to have_current_path new_post_post_path(parent_post)
        fill_in '内容', with: 'ボンソワール'
        click_button '登録する'
        expect(page).to have_content '投稿に返信しました'
        expect(page).to have_current_path post_posts_path(parent_post)
        expect(page).to have_content 'ボンソワール'
      end
    end

    context '入力内容が正しくないとき' do
      it '作成できない' do
        visit root_path
        expect(page).to have_content 'こんばんは'
        find("[data-testid='reply-new-link-#{parent_post.id}']").click
        expect(page).to have_content '投稿に返信'
        expect(page).to have_current_path new_post_post_path(parent_post)
        click_button '登録する'
        expect(page).to have_content '入力してください'
        expect(page).to have_current_path new_post_post_path(parent_post)
      end
    end
  end
end