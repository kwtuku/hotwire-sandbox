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
      expect(page).to have_current_path post_path(parent_post)
      expect(page).to have_content 'オラ'
      expect(page).to have_content 'ボンジョルノ'
    end
  end

  describe '作成' do
    let!(:parent_post) { create(:post, content: 'こんばんは') }

    context '入力内容が正しいとき' do
      it '作成できる' do
        visit root_path
        find("[data-testid='post-link-#{parent_post.id}']").click
        expect(page).to have_button '返信する'
        expect(page).to have_current_path post_path(parent_post)
        fill_in '内容', with: 'ボンソワール'
        click_button '返信する'
        expect(page).to have_content '投稿に返信しました'
        expect(page).to have_current_path post_path(parent_post)
        expect(page).to have_field '内容', with: ''
        expect(page).to have_content 'ボンソワール'
      end
    end

    context '入力内容が正しくないとき' do
      it '作成できない' do
        visit root_path
        find("[data-testid='post-link-#{parent_post.id}']").click
        expect(page).to have_button '返信する'
        expect(page).to have_current_path post_path(parent_post)
        click_button '返信する'
        expect(page).to have_content '入力してください'
        expect(page).to have_current_path post_path(parent_post)
      end
    end
  end
end
