# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns a new user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        { user: { email: 'test@example.com', password: 'password123', password_confirmation: 'password123' } }
      end

      it 'creates a new user' do
        expect do
          post :create, params: valid_attributes
        end.to change(User, :count).by(1)
      end

      it 'redirects to login path' do
        post :create, params: valid_attributes
        expect(response).to redirect_to(login_path)
      end

      it 'sets a success flash message' do
        post :create, params: valid_attributes
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        { user: { email: '', password: 'short', password_confirmation: 'different' } }
      end

      it 'does not create a new user' do
        expect do
          post :create, params: invalid_attributes
        end.not_to change(User, :count)
      end

      it 'returns unprocessable_entity status' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(422)
      end

      it 'renders the new template' do
        post :create, params: invalid_attributes
        expect(response).to render_template(:new)
      end

      it 'sets a danger flash message' do
        post :create, params: invalid_attributes
        expect(flash.now[:danger]).to be_present
      end
    end
  end
end
