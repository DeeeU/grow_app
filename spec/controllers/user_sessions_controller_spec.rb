# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let!(:user) { create(:user, email: 'test@example.com', password: 'password123', password_confirmation: 'password123') }
    
    context 'with valid credentials' do
      it 'logs in the user' do
        post :create, params: { email: 'test@example.com', password: 'password123' }
        expect(session[:user_id]).not_to be_nil
      end

      it 'redirects to root path' do
        post :create, params: { email: 'test@example.com', password: 'password123' }
        expect(response).to redirect_to(root_path)
      end

      it 'sets a success flash message' do
        post :create, params: { email: 'test@example.com', password: 'password123' }
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'does not log in the user' do
        post :create, params: { email: 'test@example.com', password: 'wrongpassword' }
        expect(session[:user_id]).to be_nil
      end

      it 'returns unauthorized status' do
        post :create, params: { email: 'test@example.com', password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'renders the new template' do
        post :create, params: { email: 'test@example.com', password: 'wrongpassword' }
        expect(response).to render_template(:new)
      end

      it 'sets a danger flash message' do
        post :create, params: { email: 'test@example.com', password: 'wrongpassword' }
        expect(flash.now[:danger]).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      login_user create(:user)
    end

    it 'logs out the user' do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to root path' do
      delete :destroy
      expect(response).to redirect_to(root_path)
    end

    it 'sets a success flash message' do
      delete :destroy
      expect(flash[:success]).to be_present
    end
  end
end
