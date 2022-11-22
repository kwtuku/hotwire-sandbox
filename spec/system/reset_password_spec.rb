require 'rails_helper'

RSpec.describe 'パスワードの再設定', type: :system do
  before { create(:user, email: 'unknown@example.com', password: SecureRandom.hex) }

  context '入力内容が有効なとき' do
    it 'フラッシュメッセージが表示される、メールが送信される、メールのリンクからパスワードを再設定できる' do
      visit root_path
      click_link 'ログイン'

      expect(page).to have_button 'ログイン'
      expect(page).to have_current_path new_user_session_path

      click_link 'パスワードを忘れましたか？'

      expect(page).to have_button 'パスワードの再設定方法を送信する'
      expect(page).to have_current_path new_user_password_path

      fill_in 'Eメール', with: 'unknown@example.com'
      click_button 'パスワードの再設定方法を送信する'

      expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'
      expect(page).to have_current_path new_user_session_path

      mail = ActionMailer::Base.deliveries.last
      expect(mail.from).to eq ['please-change-me-at-config-initializers-devise@example.com']
      expect(mail.to).to eq ['unknown@example.com']
      expect(mail.subject).to eq 'パスワードの再設定について'

      path = mail.body.encoded.slice(%r{/users/password/edit\?reset_password_token=[^"]+})
      visit path

      expect(page).to have_button 'パスワードを変更する'

      fill_in '新しいパスワード', with: 'new-password'
      fill_in '確認用新しいパスワード', with: 'new-password'
      click_button 'パスワードを変更する'

      expect(page).to have_content 'パスワードが正しく変更されました。'
      expect(page).to have_current_path posts_path
    end
  end

  context '入力内容が無効なとき' do
    it 'エラーメッセージが表示される' do
      visit root_path
      click_link 'ログイン'

      expect(page).to have_button 'ログイン'
      expect(page).to have_current_path new_user_session_path

      click_link 'パスワードを忘れましたか？'

      expect(page).to have_button 'パスワードの再設定方法を送信する'
      expect(page).to have_current_path new_user_password_path

      click_button 'パスワードの再設定方法を送信する'

      expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。'
      expect(page).to have_content 'Eメールを入力してください'
      expect(page).to have_current_path '/users/password'
    end
  end
end
