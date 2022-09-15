require 'rails_helper'

RSpec.describe '投稿', type: :system do
  describe '一覧表示' do
    before do
      create(:post, content: 'こんにちは')
      create(:post, content: 'オラ')
    end

    it '一覧が表示される' do
      visit root_path
      expect(page).to have_content 'こんにちは'
      expect(page).to have_content 'オラ'
    end
  end

  describe '詳細表示' do
    let!(:post) { create(:post, content: 'ボンジュール') }

    it '詳細が表示される' do
      visit root_path
      click_link 'Show'
      expect(page).to have_content 'ボンジュール'
      expect(page).to have_current_path post_path(post)
    end
  end

  describe '作成' do
    it '作成できる' do
      visit root_path
      click_link 'New Post'
      expect(page).to have_content 'New post'
      expect(page).to have_current_path new_post_path
      fill_in 'Content', with: 'ニーハオ'
      click_button 'Save'
      expect(page).to have_content 'Post was successfully created.'
      expect(page).to have_current_path post_path(Post.last)
      expect(page).to have_content 'ニーハオ'
    end
  end

  describe '更新' do
    let!(:post) { create(:post, content: 'ジャンボ') }

    it '更新できる' do
      visit root_path
      expect(page).to have_content 'ジャンボ'
      click_link 'Edit'
      expect(page).to have_content 'Editing post'
      expect(page).to have_current_path edit_post_path(post)
      fill_in 'Content', with: 'アンニョンハセヨ'
      click_button 'Save'
      expect(page).to have_content 'Post was successfully updated.'
      expect(page).to have_current_path post_path(post)
      expect(page).not_to have_content 'ジャンボ'
      expect(page).to have_content 'アンニョンハセヨ'
    end
  end

  describe '削除' do
    before do
      create(:post, content: 'ナマステ')
    end

    it '削除できる' do
      visit root_path
      expect(page).to have_content 'ナマステ'
      accept_confirm { click_button 'Destroy' }
      expect(page).to have_content 'Post was successfully destroyed.'
      expect(page).to have_current_path posts_path
      expect(page).not_to have_content 'ナマステ'
    end
  end
end
