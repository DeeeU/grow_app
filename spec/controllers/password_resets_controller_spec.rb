# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let!(:user) { create(:user) }

    it 'sends reset password instructions' do
      expect_any_instance_of(User).to receive(:deliver_reset_password_instructions!)
      post :create, params: { email: user.email }
    end

    it 'redirects to login path' do
      post :create, params: { email: user.email }
      expect(response).to redirect_to(login_path)
    end

    it 'sets a success flash message' do
      post :create, params: { email: user.email }
      expect(flash[:success]).to be_present
    end

    context 'with non-existent email' do
      it 'still redirects to login path to prevent email enumeration' do
        post :create, params: { email: 'nonexistent@example.com' }
        expect(response).to redirect_to(login_path)
      end

      it 'still sets a success flash message to prevent email enumeration' do
        post :create, params: { email: 'nonexistent@example.com' }
        expect(flash[:success]).to be_present
      end
    end
  end

  describe 'GET #edit' do
    context 'with valid token' do
      let!(:user) { create(:user) }
      let!(:token) do
        user.deliver_reset_password_instructions!
        user.reset_password_token
      end

      it 'returns http success' do
        get :edit, params: { id: token }
        expect(response).to have_http_status(:success)
      end

      it 'assigns the user and token' do
        get :edit, params: { id: token }
        expect(assigns(:user)).to eq(user)
        expect(assigns(:token)).to eq(token)
      end
    end

    context 'with invalid token' do
      it 'redirects to login path' do
        get :edit, params: { id: 'invalid_token' }
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid token and password' do
      let!(:user) { create(:user) }
      let!(:token) do
        user.deliver_reset_password_instructions!
        user.reset_password_token
      end

      it 'updates the user password' do
        patch :update, params: { id: token, user: { password: 'newpassword123', password_confirmation: 'newpassword123' } }
        user.reload
        expect(user.valid_password?('newpassword123')).to be true
      end

      it 'redirects to login path' do
        patch :update, params: { id: token, user: { password: 'newpassword123', password_confirmation: 'newpassword123' } }
        expect(response).to redirect_to(login_path)
      end

      it 'sets a success flash message' do
        patch :update, params: { id: token, user: { password: 'newpassword123', password_confirmation: 'newpassword123' } }
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid token' do
      it 'redirects to login path' do
        patch :update, params: { id: 'invalid_token', user: { password: 'newpassword123', password_confirmation: 'newpassword123' } }
        expect(response).to redirect_to(login_path)
      end
    end

    context 'with invalid password' do
      let!(:user) { create(:user) }
      let!(:token) do
        user.deliver_reset_password_instructions!
        user.reset_password_token
      end

      it 'does not update the user password' do
        patch :update, params: { id: token, user: { password: 'short', password_confirmation: 'short' } }
        user.reload
        expect(user.valid_password?('short')).to be false
      end

      it 'returns unprocessable_entity status' do
        patch :update, params: { id: token, user: { password: 'short', password_confirmation: 'short' } }
        expect(response).to have_http_status(422) # unprocessable_entity as integer
      end

      it 'renders the edit template' do
        patch :update, params: { id: token, user: { password: 'short', password_confirmation: 'short' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET #reset_dialog' do
    it 'returns http success for turbo_stream format' do
      get :reset_dialog, format: :turbo_stream
      expect(response).to have_http_status(:success)
    end

    it 'redirects to root path for html format' do
      get :reset_dialog
      expect(response).to redirect_to(binary_index_path)
    end
  end
end
