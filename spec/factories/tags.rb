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
FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "test_tag#{n}" }
    color { "#FFFFFF" }
    sequence(:context) { |n| "context#{n}" }
  end
end
