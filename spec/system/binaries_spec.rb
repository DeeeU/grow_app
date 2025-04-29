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
        # ヘルパーメソッドを使用してログイン
        login(user)
      end

      it '編集画面に遷移できること' do
        visit binary_path(edit_binary)

        # 詳細ページからの遷移を確認
        expect(page).to have_content 'Binary Details'
        expect(page).to have_content edit_binary.title
        
        # 編集リンクをクリックして編集画面に遷移
        click_on 'Edit'
        expect(page).to have_content 'Edit Binary'
        expect(page).to have_button 'Update Binary'
      end

      it '編集ができること' do
        visit binary_path(edit_binary)
        click_on 'Edit'

        fill_in 'Title', with: 'にゃーん'
        # デフォルトのRailsの更新ボタンのテキスト
        click_on 'Update Binary'
        # 詳細ページに正しく遷移するか確認
        expect(page).to have_content 'Binary Details'
        expect(page).to have_content 'にゃーん'
      end
    end

    context '削除機能' do
      before do
        # ヘルパーメソッドを使用してログイン
        login(user)
      end

      it '日記が削除できない' do
        visit binary_path(binary)

        expect(page).not_to have_content 'Delete'
      end
    end
  end
end
