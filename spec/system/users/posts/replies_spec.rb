require 'rails_helper'

RSpec.describe '返信', type: :system do
  let(:user) { create(:user) }

  context 'ログインしていないとき' do
    let(:parent_post) { create(:post) }

    it 'ログインページが表示される' do
      visit new_post_post_path(parent_post)

      expect(page).to have_content 'ログインもしくはアカウント登録してください。'
      expect(page).to have_current_path new_user_session_path
    end
  end

  describe '作成' do
    let!(:parent_post) { create(:post, content: 'こんばんは') }

    context '入力内容が有効なとき' do
      it 'フラッシュメッセージが表示される、フォームがリセットされる、作成した返信が表示される' do
        sign_in user
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
        sign_in user
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
