# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe '#reset_password_email' do
    let(:user) { create(:user) }
    let(:mail) do 
      user.deliver_reset_password_instructions!
      UserMailer.reset_password_email(user)
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('パスワードリセットの手続き')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@grow-app.com'])
    end

    it 'renders the body in both text and html formats' do
      expect(mail.multipart?).to be_truthy
      expect(mail.parts.map(&:content_type)).to include(/text\/plain/)
      expect(mail.parts.map(&:content_type)).to include(/text\/html/)
    end

    it 'includes the reset password url in the text body' do
      expect(mail.text_part.body.to_s).to include(edit_password_reset_url(user.reset_password_token))
    end

    it 'includes the reset password url in the html body' do
      expect(mail.html_part.body.to_s).to include(edit_password_reset_url(user.reset_password_token))
    end
  end
end