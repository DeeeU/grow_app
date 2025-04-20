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

  # def self.find_or_create_from_params(tag_params)
  #   reutrn nil if tag_params.present? && tag_params[:name].present?

  #   find_or_create_by(tag_params[:name]) do |t|
  #     t.context = tag_params[:context]
  #     t.color = tag_params[:color] || '#FFFFFF'
  #   end
  # end
end
