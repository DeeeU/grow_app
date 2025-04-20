# == Schema Information
#
# Table name: binaries
#
#  id         :integer          not null, primary key
#  context    :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Binary, type: :model do
  describe 'validations' do
    context 'image' do
      it 'is valid with a valid image' do
        binary = Binary.new(title: 'Test Title', context: 'Test Context')
        binary.image.attach(io: File.open(Rails.root.join('spec/fixtures/test_image.jpg')), filename: 'test_image.jpg',
                            content_type: 'image/jpeg')
        expect(binary).to be_valid
      end

      it 'is invalid with an unsupported image type' do
        binary = Binary.new(title: 'Test Title', context: 'Test Context')
        binary.image.attach(io: File.open(Rails.root.join('spec/fixtures/test_image.txt')), filename: 'test_image.txt',
                            content_type: 'text/plain')
        expect(binary).not_to be_valid
      end

      it 'is invalid with an oversized image' do
        binary = Binary.new(title: 'Test Title', context: 'Test Context')
        binary.image.attach(io: StringIO.new('a' * 11.megabytes), filename: 'test_image.jpg',
                            content_type: 'image/jpeg')
        expect(binary).not_to be_valid
      end
      it 'is valid without an image' do
        binary = Binary.new(title: 'Test Title', context: 'Test Context')
        expect(binary).to be_valid
      end
    end
  end

  describe 'scopes' do
    describe '.search_title' do
      context 'タイトルが検索された時' do
        let!(:true_binary) { create(:binary, title: 'true_binary') }
        let!(:false_binary) { create(:binary, title: 'false_binary') }

        it '検索された文字列を含むタイトルの日記が返ってくる' do
          expect(Binary.search_title('true').count).to eq(1)
          expect(Binary.search_title('true')).to include(true_binary)
        end
      end
    end
  end
end
