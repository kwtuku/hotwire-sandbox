require 'rails_helper'

RSpec.describe 'アカウント確認メール再送', type: :system do
  before { create(:user, email: 'resend@example.com', confirmed_at: nil) }

  context '入力内容が有効なとき' do
    it 'フラッシュメッセージが表示される、メールが送信される' do
      visit new_user_session_path
      click_link 'アカウント確認のメールを受け取っていませんか？'

      expect(page).to have_button 'アカウント確認メール再送'
      expect(page).to have_current_path new_user_confirmation_path

      fill_in 'Eメール', with: 'resend@example.com'
      click_button 'アカウント確認メール再送'

      expect(page).to have_content 'アカウントの有効化について数分以内にメールでご連絡します。'
      expect(page).to have_current_path new_user_session_path

      mail = ActionMailer::Base.deliveries.last
      expect(mail.from).to eq ['please-change-me-at-config-initializers-devise@example.com']
      expect(mail.to).to eq ['resend@example.com']
      expect(mail.subject).to eq 'メールアドレス確認メール'
    end
  end

  context '入力内容が無効なとき' do
    it 'エラーメッセージが表示される' do
      visit new_user_session_path
      click_link 'アカウント確認のメールを受け取っていませんか？'

      expect(page).to have_button 'アカウント確認メール再送'
      expect(page).to have_current_path new_user_confirmation_path

      click_button 'アカウント確認メール再送'

      expect(page).to have_content 'エラーが発生したため ユーザー は保存されませんでした。'
      expect(page).to have_content 'Eメールを入力してください'
      expect(page).to have_current_path '/users/confirmation'
    end
  end
end
