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
class Tag < ApplicationRecord
  has_and_belongs_to_many :binaries

  validates :name, presence: true, uniqueness: true
  validates :color,
            format: { with: /\A#(?:[0-9a-fA-F]{3}|[0-9a-fA-F]{6})\z/, message: 'must be a valid hex color code' }

  # def self.find_or_create_from_params(tag_params)
  #   reutrn nil if tag_params.present? && tag_params[:name].present?

  #   find_or_create_by(tag_params[:name]) do |t|
  #     t.context = tag_params[:context]
  #     t.color = tag_params[:color] || '#FFFFFF'
  #   end
  # end
end
