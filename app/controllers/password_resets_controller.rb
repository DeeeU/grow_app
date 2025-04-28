class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = User.find_by(email: params[:email])

    @user&.deliver_reset_password_instructions!

    # Always return success to prevent email enumeration attacks
    redirect_to login_path, success: 'パスワードリセットの手順をメールで送信しました'
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return unless @user.blank?

    not_authenticated
    nil
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: 'パスワードが正常に更新されました'
    else
      flash.now[:danger] = 'パスワードの更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  # AJAX endpoint for password reset dialog
  def reset_dialog
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to binary_index_path }
    end
  end
end
