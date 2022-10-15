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

  describe '作成' do
    let!(:parent_post) { create(:post, content: 'こんばんは') }

    context '入力内容が有効なとき' do
      it 'フラッシュメッセージが表示される、フォームがリセットされる、作成したものが表示される' do
        visit root_path
        find("[data-testid='post-link-#{parent_post.id}']").click

        expect(page).to have_field '内容'
        expect(page).to have_current_path post_path(parent_post)

        fill_in '内容', with: 'ボンソワール'
        click_button '返信する'

        expect(page).to have_content '投稿に返信しました'
        expect(page).to have_field '内容', with: ''
        expect(page).to have_content 'ボンソワール'
        expect(page).to have_current_path post_path(parent_post)
      end
    end

    context '入力内容が無効なとき' do
      it 'エラーメッセージが表示される' do
        visit root_path
        find("[data-testid='post-link-#{parent_post.id}']").click

        expect(page).to have_field '内容'
        expect(page).to have_current_path post_path(parent_post)

        click_button '返信する'

        expect(page).to have_content '入力してください'
        expect(page).to have_current_path post_path(parent_post)
      end
    end
  end
end
