require 'rails_helper'

RSpec.describe 'いいね', type: :system do
  let(:user) { create(:user) }
  let!(:post) { create(:post) }

  context 'ログインしていないとき' do
    it 'アイコンが表示される' do
      visit root_path

      expect(page).to have_selector "[data-testid=post-like-icon-#{post.id}]"
      expect(page).to have_selector "[data-testid=post-likes-count-#{post.id}]", text: '0'
    end
  end

  describe '作成、削除' do
    context '投稿の一覧ページの場合' do
      it 'ボタンが切り替わる、いいね数が表示される' do
        sign_in user
        visit root_path
        find("[data-testid='post-like-button-#{post.id}']").click

        expect(page).to have_selector "[data-testid=post-unlike-button-#{post.id}]"
        expect(page).to have_selector "[data-testid=post-likes-count-#{post.id}]", text: '1'

        find("[data-testid='post-unlike-button-#{post.id}']").click

        expect(page).to have_selector "[data-testid=post-like-button-#{post.id}]"
        expect(page).to have_selector "[data-testid=post-likes-count-#{post.id}]", text: '0'
      end
    end

    context '投稿の詳細ページの場合' do
      it 'ボタンが切り替わる、いいね数が表示される' do
        sign_in user
        visit root_path
        find("[data-testid='post-link-#{post.id}']").click

        expect(page).to have_content '投稿'

        find("[data-testid='post-like-button-#{post.id}']").click

        expect(page).to have_selector "[data-testid=post-unlike-button-#{post.id}]"
        expect(page).to have_content '1 件のいいね'

        find("[data-testid='post-unlike-button-#{post.id}']").click

        expect(page).to have_selector "[data-testid=post-like-button-#{post.id}]"
        expect(page).to have_content :all, '0 件のいいね'
      end
    end
  end
end
