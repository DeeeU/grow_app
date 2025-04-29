# == Schema Information
#
# Table name: users
#
#  id                                  :integer          not null, primary key
#  access_count_to_reset_password_page :integer          default(0)
#  crypted_password                    :string
#  email                               :string           not null
#  reset_password_email_sent_at        :datetime
#  reset_password_token                :string
#  reset_password_token_expires_at     :datetime
#  salt                                :string
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      create(:user, email: 'duplicate@example.com')
      user = build(:user, email: 'duplicate@example.com')
      expect(user).not_to be_valid
    end

    it 'is not valid with a short password' do
      user = build(:user, password: 'short', password_confirmation: 'short')
      expect(user).not_to be_valid
    end

    it 'is not valid when password and confirmation do not match' do
      user = build(:user, password: 'password123', password_confirmation: 'differentpass')
      expect(user).not_to be_valid
    end
  end

  describe 'sorcery' do
    it 'validates reset password token' do
      user = create(:user)
      user.deliver_reset_password_instructions!

      expect(user.reset_password_token).not_to be_nil
      expect(user.reset_password_token_expires_at).not_to be_nil
      expect(user.reset_password_email_sent_at).not_to be_nil

      # トークンを使って正しくユーザーを取得できるか確認
      found_user = User.load_from_reset_password_token(user.reset_password_token)
      expect(found_user).to eq(user)
    end
    
    it 'can change password' do
      user = create(:user)
      old_crypted_password = user.crypted_password
      
      # パスワード変更
      user.password = 'newpassword123'
      user.password_confirmation = 'newpassword123'
      user.save
      
      user.reload
      # 暗号化パスワードが変更されていることを確認
      expect(user.crypted_password).not_to eq(old_crypted_password)
    end
  end
end
