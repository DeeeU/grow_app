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
class Binary < ApplicationRecord
  has_and_belongs_to_many :tags

  scope :search_title, ->(title) { where('title LIKE ?', "%#{title}%") }
end
