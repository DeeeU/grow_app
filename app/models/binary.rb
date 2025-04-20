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

  def add_tag(tag_params)
    tag = Tag.find_or_create_from_params(tag_params)
    tags << tag unless tag.nil? || tags.include?(tag)
    tag
  end

  private

  def acceptable_image
    return unless image.attached?

    errors.add(:image, 'needs to be less than 10MB') if image.blob.byte_size > 10.megabytes

    acceptable_image_types = ['image/jpeg', 'image/png', 'image/jpg']
    return if acceptable_image_types.include?(image.blob.content_type)

    errors.add(:image, 'needs to be a JPEG, JPG, or PNG')
  end
end
