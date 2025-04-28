class UserMailer < ApplicationMailer
  default from: 'noreply@grow-app.com'

  def reset_password_email(user)
    @user = user
    @url = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email, subject: 'パスワードリセットの手続き')
  end
end
