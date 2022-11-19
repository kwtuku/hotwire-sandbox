require 'rails_helper'

RSpec.describe 'ユーザー', type: :system do
  describe 'アカウント更新' do
    let(:user) { create(:user, name: '更新前の名前', username: 'old', email: 'old@example.com', password: 'old-password') }

    context '入力内容が有効なとき' do
      it 'フラッシュメッセージが表示される' do
        sign_in user
        visit root_path
        find("[data-testid='edit-user-link']").click

        expect(page).to have_button '更新'
        expect(page).to have_current_path edit_user_registration_path

        fill_in '名前', with: '新しい名前'
        fill_in 'ユーザー名', with: 'new'
        fill_in 'Eメール', with: 'new@example.com'
        fill_in 'パスワード（空欄のままなら変更しません）', with: 'new-password'
        fill_in 'パスワード（確認用）', with: 'new-password'
        fill_in '現在のパスワード', with: 'old-password'
        click_button '更新'

        expect(page).to have_content 'アカウント情報を変更しました。変更されたメールアドレスの本人確認のため、本人確認用メールより確認処理をおこなってください。'
        expect(page).to have_current_path posts_path
      end
    end

    context '入力内容が無効なとき' do
      it 'エラーメッセージが表示される' do
        sign_in user
        visit root_path
        find("[data-testid='edit-user-link']").click

        expect(page).to have_button '更新'
        expect(page).to have_current_path edit_user_registration_path

        click_button '更新'

        expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。'
        expect(page).to have_content '現在のパスワードを入力してください'
        expect(page).to have_current_path '/users'
      end
    end
  end

  describe 'アカウント削除' do
    let(:user) { create(:user) }

    it 'フラッシュメッセージが表示される' do
      sign_in user
      visit root_path
      find("[data-testid='edit-user-link']").click

      expect(page).to have_button '更新'
      expect(page).to have_current_path edit_user_registration_path

      click_button 'アカウント削除'

      expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
      expect(page).to have_current_path posts_path
    end
  end
end
