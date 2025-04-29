require 'rails_helper'

RSpec.describe 'Binaries', type: :system do
  context 'Binary System Spec' do
    let!(:binary) { create(:binary) }
    let!(:user) { create(:user) }

    context '一覧画面' do
      it '一覧画面に要素が表示ができること' do
        visit binary_index_path

        expect(page).to have_content 'index'
        expect(page).to have_content binary.title
      end
    end

    context '編集画面' do
      let!(:edit_binary) { create(:binary, title: 'ネコ') }

      before do
        # ログイン処理
        visit login_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password123'
        click_button 'ログイン'
      end

      it '編集画面に遷移できること' do
        visit binary_path(edit_binary)

        expect(page).to have_content 'Edit'
        click_on 'Edit'
        expect(page).to have_content 'Edit Binary'
      end

      it '編集ができること' do
        visit binary_path(edit_binary)
        click_on 'Edit'

        fill_in 'Title', with: 'にゃーん'
        click_on 'Update Binary'
        expect(page).to have_content 'Details'
      end
    end

    context '削除機能' do
      before do
        # ログイン処理
        visit login_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password123'
        click_button 'ログイン'
      end

      it '日記が削除できない' do
        visit binary_path(binary)

        expect(page).not_to have_content 'Delete'
      end
    end
  end
end
