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
end
