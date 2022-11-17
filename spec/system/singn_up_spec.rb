require 'rails_helper'

RSpec.describe 'アカウント登録して有効化してログイン', type: :system do
  context '入力内容が有効なとき' do
    it 'フラッシュメッセージが表示される、メールが送信される、メールのリンクを開くとログインできるようになる' do
      visit root_path
      click_link 'アカウント登録'

      expect(page).to have_button 'アカウント登録'
      expect(page).to have_current_path new_user_registration_path

      fill_in '名前', with: 'アリス'
      fill_in 'ユーザー名', with: 'alice'
      fill_in 'Eメール', with: 'alice@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'
      click_button 'アカウント登録'

      expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
      expect(page).to have_current_path posts_path

      mail = ActionMailer::Base.deliveries.last
      expect(mail.from).to eq ['please-change-me-at-config-initializers-devise@example.com']
      expect(mail.to).to eq ['alice@example.com']
      expect(mail.subject).to eq 'メールアドレス確認メール'

      path = mail.body.encoded.slice(%r{/users/confirmation\?confirmation_token=[^"]+})
      visit path

      expect(page).to have_content 'メールアドレスが確認できました。'
      expect(page).to have_current_path new_user_session_path

      fill_in 'Eメール', with: 'alice@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'

      expect(page).to have_content 'ログインしました。'
      expect(page).to have_current_path posts_path
    end
  end

  context '入力内容が無効なとき' do
    it 'エラーメッセージが表示される' do
      visit root_path
      click_link 'アカウント登録'

      expect(page).to have_button 'アカウント登録'
      expect(page).to have_current_path new_user_registration_path

      click_button 'アカウント登録'

      expect(page).to have_content '4 件のエラーが発生したため ユーザー は保存されませんでした。'
      expect(page).to have_content 'Eメールを入力してください'
      expect(page).to have_content 'パスワードを入力してください'
      expect(page).to have_content '名前を入力してください'
      expect(page).to have_content 'ユーザー名を入力してください'
      expect(page).to have_current_path '/users'
    end
  end
end
