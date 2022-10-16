require 'rails_helper'

RSpec.describe '投稿', type: :system do
  describe '一覧表示' do
    before do
      create(:post, content: 'こんにちは')
      create(:post, content: 'オラ')
      create_list(:post, 23)
      create(:post, content: 'こんばんは')
    end

    it '一覧が表示される、スクロールするとさらに投稿が表示される' do
      visit root_path

      expect(page).to have_content 'こんばんは'
      expect(page).to have_content 'オラ'
      expect(page).not_to have_content 'こんにちは'

      execute_script('window.scrollBy(0,10000)')

      expect(page).to have_content 'こんにちは'
    end
  end

  describe '詳細表示' do
    let!(:post) { create(:post, content: 'ボンジュール') }

    it '詳細が表示される' do
      visit root_path
      find("[data-testid='post-link-#{post.id}']").click

      expect(page).to have_content 'ボンジュール'
      expect(page).to have_current_path post_path(post)
    end
  end

  describe '作成' do
    context '入力内容が有効なとき' do
      it 'フラッシュメッセージが表示される、フォームがリセットされる、作成した投稿が表示される' do
        visit root_path

        expect(page).to have_field '内容'
        expect(page).to have_current_path posts_path

        fill_in '内容', with: 'ニーハオ'
        click_button '投稿する'

        expect(page).to have_content '投稿を作成しました'
        expect(page).to have_field '内容', with: ''
        expect(page).to have_content 'ニーハオ'
        expect(page).to have_current_path posts_path
      end
    end

    context '入力内容が無効なとき' do
      it 'エラーメッセージが表示される' do
        visit root_path

        expect(page).to have_field '内容'
        expect(page).to have_current_path posts_path

        click_button '投稿する'

        expect(page).to have_content '入力してください'
        expect(page).to have_current_path posts_path
      end
    end
  end

  describe '更新' do
    let!(:post) { create(:post, content: 'ジャンボ') }

    context '入力内容が有効なとき' do
      it 'ドロップダウンのリンクをクリックするとフォームが表示される、フラッシュメッセージが表示される、更新した投稿が表示される' do
        visit root_path
        find("[data-testid='post-dropdown-#{post.id}']").click
        click_link '編集'

        within "[data-testid='post-edit-form-#{post.id}']" do
          expect(page).to have_field '内容', with: 'ジャンボ'
        end
        expect(page).to have_current_path posts_path

        within "[data-testid='post-edit-form-#{post.id}']" do
          fill_in '内容', with: 'アンニョンハセヨ'
        end
        click_button '更新する'

        expect(page).to have_content '投稿を更新しました'
        expect(page).to have_content 'アンニョンハセヨ'
        expect(page).to have_content '編集済み'
        expect(page).not_to have_content 'ジャンボ'
        expect(page).to have_current_path posts_path
      end
    end

    context '入力内容が無効なとき' do
      it 'ドロップダウンのリンクをクリックするとフォームが表示される、エラーメッセージが表示される' do
        visit root_path
        find("[data-testid='post-dropdown-#{post.id}']").click
        click_link '編集'

        within "[data-testid='post-edit-form-#{post.id}']" do
          expect(page).to have_field '内容', with: 'ジャンボ'
        end
        expect(page).to have_current_path posts_path

        within "[data-testid='post-edit-form-#{post.id}']" do
          fill_in '内容', with: ''
        end
        click_button '更新する'

        expect(page).to have_content '入力してください'
        expect(page).to have_current_path posts_path
      end
    end
  end

  describe '削除' do
    let!(:post) { create(:post, content: 'ナマステ') }

    it 'フラッシュメッセージが表示される、削除した投稿が表示されなくなる' do
      visit root_path
      find("[data-testid='post-dropdown-#{post.id}']").click
      accept_confirm { click_button '削除' }

      expect(page).to have_content '投稿を削除しました'
      expect(page).not_to have_content 'ナマステ'
      expect(page).to have_current_path posts_path
    end
  end
end
