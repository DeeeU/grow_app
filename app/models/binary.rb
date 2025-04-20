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
  has_one_attached :image

  validate :acceptable_image

  scope :search_title, ->(title) { where('title LIKE ?', "%#{title}%") }

  private

  def acceptable_image
    return unless image.attached?

    if image.blob.byte_size > 10.megabytes
      errors.add(:image, 'needs to be less than 10MB')
    end

    acceptable_image_types = ['image/jpeg', 'image/png', 'image/jpg']
    unless acceptable_image_types.include?(image.blob.content_type)
      errors.add(:image, 'needs to be a JPEG, JPG, or PNG')
    end
  end
end
