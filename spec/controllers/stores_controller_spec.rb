require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:store) { FactoryGirl.create(:store) }
  describe 'store#index' do
    it 'should load store index page' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'stores#new action' do
    it 'should require user to sign in' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
    it 'should show load form for new store' do
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'stores#create action' do
    it 'should require user to be log in' do
      post :create, params: { store: { storename: 'yolo'}}
      expect(response).to redirect_to new_user_session_path
    end
    it 'should create a new store' do
      sign_in user
      post :create, params: {
        store: {
          storename: 'lul',
          description: 'wtf',
          location: 'LA',
          phone: '123'
        }
      }
      expect(response).to redirect_to stores_path
      store = Store.last
      expect(store.storename).to eq('lul')
    end
  end

  describe 'store#show' do
    it 'should load store show page' do
      get :show, params: { id: store.id }
      expect(response).to have_http_status(:success)
    end
  end
end
