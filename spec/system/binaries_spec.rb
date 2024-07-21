require 'rails_helper'

RSpec.describe "Binaries", type: :system do

  context 'Binary System Spec' do
    let!(:binary) {create(:binary)}

    context '一覧画面' do

      it '一覧画面に要素が表示ができること' do
        visit binary_index_path

        expect(page).to have_content 'index'
        expect(page).to have_content binary.title
      end
    end

    context '削除機能' do

      it '日記が削除できること' do
        visit binary_path(binary)

        expect(page).to have_content 'Delete'
        click_on 'Delete'
        expect(page).to have_content 'index'
        expect(page).to_not have_content binary.title
      end
    end
  end
end
