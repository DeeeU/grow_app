require 'rails_helper'

RSpec.describe Binary, type: :model do
  describe 'scopes' do
    describe '.search_title' do
      context 'タイトルが検索された時' do
        let!(:true_binary){create(:binary, title: 'true_binary')}
        let!(:false_binary) { create(:binary, title: 'false_binary') }

        it '検索された文字列を含むタイトルの日記が返ってくる' do
          expect(Binary.search_title('true').count).to eq(1)
          expect(Binary.search_title('true')).to include(true_binary)
        end
      end
    end
  end
end
