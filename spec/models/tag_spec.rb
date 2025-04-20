# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  color      :string           default("#FFFFFF"), not null
#  context    :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'バリデーション' do
    let(:tag) { create(:tag) }

    it '有効なタグ' do
      expect(tag).to be_valid
    end

    it '名前が空の場合は無効' do
      tag.name = nil
      expect(tag).not_to be_valid
    end

    it '色が不正な場合は無効' do
      tag.color = 'invalid_color'
      expect(tag).not_to be_valid
    end
  end
end
