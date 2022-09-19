require 'rails_helper'

RSpec.describe '投稿', type: :system do
  describe '一覧表示' do
    before do
      create(:post, content: 'こんにちは')
      create(:post, content: 'オラ')
    end

    it '一覧が表示される' do
      visit root_path
      expect(page).to have_content 'こんにちは'
      expect(page).to have_content 'オラ'
    end
  end

  describe '詳細表示' do
    let!(:post) { create(:post, content: 'ボンジュール') }

    it '詳細が表示される' do
      visit root_path
      click_link '詳細'
      expect(page).to have_content 'ボンジュール'
      expect(page).to have_current_path post_path(post)
    end
  end

  describe '作成' do
    context '入力内容が正しいとき' do
      it '作成できる' do
        visit root_path
        click_link '投稿を作成'
        expect(page).to have_content '投稿を作成'
        expect(page).to have_current_path new_post_path
        fill_in '内容', with: 'ニーハオ'
        click_button '登録する'
        expect(page).to have_content '投稿を作成しました'
        expect(page).to have_current_path post_path(Post.last)
        expect(page).to have_content 'ニーハオ'
      end
    end

    context '入力内容が正しくないとき' do
      it '作成できない' do
        visit root_path
        click_link '投稿を作成'
        expect(page).to have_content '投稿を作成'
        expect(page).to have_current_path new_post_path
        click_button '登録する'
        expect(page).to have_content '正しく入力されていない項目があります'
        expect(page).to have_current_path new_post_path
        expect(page).to have_content '内容を入力してください'
      end
    end
  end

  describe '更新' do
    let!(:post) { create(:post, content: 'ジャンボ') }

    context '入力内容が正しいとき' do
      it '更新できる' do
        visit root_path
        expect(page).to have_content 'ジャンボ'
        click_link '編集'
        expect(page).to have_content '投稿を編集'
        expect(page).to have_current_path edit_post_path(post)
        fill_in '内容', with: 'アンニョンハセヨ'
        click_button '更新する'
        expect(page).to have_content '投稿を更新しました'
        expect(page).to have_current_path post_path(post)
        expect(page).not_to have_content 'ジャンボ'
        expect(page).to have_content 'アンニョンハセヨ'
      end
    end

    context '入力内容が正しくないとき' do
      it '更新できない' do
        visit root_path
        expect(page).to have_content 'ジャンボ'
        click_link '編集'
        expect(page).to have_content '投稿を編集'
        expect(page).to have_current_path edit_post_path(post)
        fill_in '内容', with: ''
        click_button '更新する'
        expect(page).to have_content '正しく入力されていない項目があります'
        expect(page).to have_current_path edit_post_path(post)
        expect(page).to have_content '内容を入力してください'
      end
    end
  end

  describe '削除' do
    before do
      create(:post, content: 'ナマステ')
    end

    it '削除できる' do
      visit root_path
      expect(page).to have_content 'ナマステ'
      accept_confirm { click_button '削除' }
      expect(page).to have_content '投稿を削除しました'
      expect(page).to have_current_path posts_path
      expect(page).not_to have_content 'ナマステ'
    end
  end
end
