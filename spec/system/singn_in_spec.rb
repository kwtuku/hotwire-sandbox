require 'rails_helper'

RSpec.describe 'ログイン', type: :system do
  describe '無効なログイン' do
    context '入力内容が無効なとき' do
      it 'フラッシュメッセージが表示される' do
        visit root_path
        click_link 'ログイン'

        expect(page).to have_button 'ログイン'
        expect(page).to have_current_path new_user_session_path

        click_button 'ログイン'

        expect(page).to have_content 'Eメールまたはパスワードが違います。'
        expect(page).to have_current_path new_user_session_path
      end
    end

    context 'アカウントが有効化されていないとき' do
      before { create(:user, email: 'unconfirmed@example.com', password: 'unconfirmed', confirmed_at: nil) }

      it 'フラッシュメッセージが表示される' do
        visit root_path
        click_link 'ログイン'

        expect(page).to have_button 'ログイン'
        expect(page).to have_current_path new_user_session_path

        fill_in 'Eメール', with: 'unconfirmed@example.com'
        fill_in 'パスワード', with: 'unconfirmed'
        click_button 'ログイン'

        expect(page).to have_content 'メールアドレスの本人確認が必要です。'
        expect(page).to have_current_path new_user_session_path
      end
    end
  end

  describe 'ログアウト' do
    let(:user) { create(:user) }

    it 'フラッシュメッセージが表示される' do
      sign_in user
      visit root_path
      find("[data-testid='user-dropdown']").click
      click_button 'ログアウト'

      expect(page).to have_content 'ログアウトしました。'
      expect(page).to have_current_path posts_path
    end
  end
end
