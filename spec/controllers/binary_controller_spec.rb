require 'rails_helper'

RSpec.describe BinaryController, type: :controller do
  # indexはログイン無しでアクセス可能
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  # ログインが必要なアクション
  describe 'when logged in' do
    let(:user) { create(:user) }
    
    before do
      login_user(user)
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
        post :create, params: { binary: { title: 'Test Binary', context: 'Test Data' } }
        expect(response).to have_http_status(:redirect)
      end
    end
  end
  
  # 未ログイン時はリダイレクト
  describe 'when not logged in' do
    describe 'GET #show' do
      let(:binary) { create(:binary) }

      it 'redirects to login page' do
        get :show, params: { id: binary.id }
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
