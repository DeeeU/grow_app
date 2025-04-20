# require 'rails_helper'

RSpec.describe BinaryController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:binary) { create(:binary) }

    it 'returns http success' do
      get :show, params: { id: binary.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'returns http success' do
      post :create, params: { binary: { name: 'Test Binary', data: 'Test Data' } }
      expect(response).to have_http_status(:redirect)
    end
  end
end
