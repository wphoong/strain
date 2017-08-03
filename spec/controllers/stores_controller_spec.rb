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
    it 'should return 400 error if not found' do
      get :show, params: { id: 'LUL' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'stores#edit' do
    it 'should require store creator to be logged in' do
      get :edit, params: { id: store.id }
      expect(response).to redirect_to new_user_session_path
    end
    it 'should only allow store creator to edit a store' do
      sign_in user
      get :edit, params: { id: store.id }
      expect(response).to have_http_status(:forbidden)
    end
    it 'should allow store creator to view edit form' do
      sign_in store.user
      get :edit, params: { id: store.id }
      expect(response).to have_http_status(:success)
    end
    it 'should return 400 error if not found' do
      sign_in store.user
      get :edit, params: { id: 'LUL' }
      expect(response).to have_http_status(:not_found)
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
    it 'should not allow unauthenticated user update a gram' do
      sign_in user
      put :update, params: { id: store.id }
      expect(response).to have_http_status(:forbidden)
    end
    it 'should return 400 error if not found' do
      sign_in user
      put :update, params: { id: 'haha' }
      expect(response).to have_http_status(:not_found)
    end
  end
  describe 'stores#destroy' do
    it 'should allow store creator to delete their store' do
      sign_in store.user
      delete :destroy, params: { id: store.id }
      store.user.update(has_store: false)
      expect(response).to redirect_to stores_path
      store1 = Store.find_by_id(store.id)
      expect(store1).to eq nil
      expect(store.user.has_store).to eq false
    end
    it 'should only allow store creator to destroy their store' do
      sign_in user
      delete :destroy, params: { id: store.id }
      expect(response).to have_http_status(:forbidden)
    end
    it 'should return 400 error if not found' do
      sign_in user
      delete :destroy, params: { id:'wtf' }
      expect(response).to have_http_status(:not_found)
    end
  end
end
