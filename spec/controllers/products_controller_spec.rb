require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:store) { FactoryGirl.create(:store) }
  let(:product) { FactoryGirl.create(:product) }

  describe 'products#index' do
    it 'should allow viewers to see all products' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  describe 'products#new' do
    it 'should allow store user to view new products form' do
      sign_in store.user
      get :new, params: { store_id: store }
      expect(response).to have_http_status(:success)
    end
    it 'should require users to be logged in' do
      get :new, params: { store_id: store }
      expect(response).to redirect_to new_user_session_path
    end
    it 'should only allow store creator to view new product form' do
      sign_in user
      get :new, params: { store_id: store }
      expect(response).to have_http_status(:forbidden)
    end
  end
  describe 'products#create' do
    it 'should allow store creator to create a product' do
      sign_in store.user
      post :create, params: {
        store_id: store,
        product: {
          strain: 'KUSH',
          straintype: 'LUL',
          effects: 'DANK',
          description: 'NOM'
           }
         }
      expect(response).to redirect_to store_path(store.id)
      product.reload
      product1 = Product.first
      expect(product1.strain).to eq('KUSH')
    end
    it 'should require users to be logged in' do
      post :create, params: { store_id: store, product: { strain: 'lul' } }
      expect(response).to redirect_to new_user_session_path
    end
    it 'should only allow store creator to create a product' do
      sign_in user
      post :create, params: { store_id: store, product: { strain: 'lul' } }
      expect(response).to have_http_status(:forbidden)
    end
  end
  describe 'products#show' do
    it 'should load show page for a product' do
      get :show, params: { store_id: store.id, id: product.id }
      expect(response).to have_http_status(:success)
    end
    it 'should raise 400 error message when product is not found' do
      get :show, params: { store_id: store.id, id: 'KAPPA' }
      expect(response).to have_http_status(:not_found)
    end
  end
    describe 'products#edit' do
      it 'should allow store creator to edit his products' do
        sign_in store.user
        get :edit, params: { store_id: store.id, id: product.id }
        expect(response).to have_http_status(:success)
      end
      it 'should only allow store creator to edit his products' do
        sign_in user
        get :edit, params: { store_id: store.id, id: product.id }
        expect(response).to have_http_status(:forbidden)
      end
      it 'should show 400 error if not found' do
        sign_in store.user
        get :edit, params: { store_id: store.id, id: 'KAPPA123' }
        expect(response).to have_http_status(:not_found)
      end
      it 'should require users to be logged in' do
        get :edit, params: { store_id: store.id, id: product.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
    describe 'products#update' do
      it 'should allow store creator to update their products' do
        sign_in store.user
        patch :update, params: { store_id: store.id, id: product.id,
          product: {
            strain: 'Jebaited Sucka'
            }
          }
        expect(response).to redirect_to store_path(store.id)
        product.reload
        product1 = Product.find_by_id(product.id)
        expect(product1.strain).to eq('Jebaited Sucka')
      end
      it 'should only allow store creator to update his products' do
        sign_in user
        patch :update, params: { store_id: store.id, id: product.id }
        expect(response).to have_http_status(:forbidden)
      end
      it 'should show 400 error if not found' do
        sign_in store.user
        patch :update, params: { store_id: store.id, id: 'MonkaS' }
        expect(response).to have_http_status(:not_found)
      end
      it 'should require users to be logged in' do
        patch :update, params: { store_id: store.id, id: product.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
end
