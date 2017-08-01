require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:store) { FactoryGirl.create(:store) }
  describe 'stores#index' do
    it 'should load store index page' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'stores#new action' do
    it 'should require users to be logged in' do
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
      post :create, params: { store: { storename: 'yolo'} }
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
      store.reload
      store = Store.last
      expect(store.storename).to eq('lul')
    end
  end

  describe 'stores#show' do
    it 'should load store show page' do
      get :show, params: { id: store.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'stores#edit' do
    it 'should require users to be logged in' do
      get :edit, params: { id: store.id }
      expect(response).to redirect_to new_user_session_path
    end
    it 'should not allow unauthenticated user edit a gram' do
      sign_in user
      get :edit, params: { id: store.id }
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'stores#update' do
    it 'should update the information of a store' do
      sign_in store.user
      put :update, params: { id: store.id, store: { storename: 'HAHHA' } }
      expect(response).to redirect_to store_path(store.id)
      store.reload
      expect(store.storename).to eq 'HAHHA'
    end
  end
end
