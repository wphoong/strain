class StoresController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @stores = Store.all
  end

  def new
    check_for_store_creation
    @store = Store.new
  end

  def create
    check_for_store_creation
    current_user.stores.create(store_params)
    current_user.update(has_store: true)
    redirect_to stores_path
  end

  def show
    @stores = Store.find(params[:id])
  end

  def edit
    @store = Store.find(params[:id])
    return render_not_found if @store.blank?
    return render_not_found(:forbidden) if @store.user != current_user
  end

  def update
    @store = Store.find(params[:id])
    return render_not_found if @store.blank?
    return render_not_found(:forbidden) if @store.user != current_user
    @store.update_attributes(store_params)
    redirect_to store_path(@store) if @store.valid?
  end

  private

  def store_params
    params.require(:store).permit(:storename, :description, :location, :phonenumber)
  end

  def check_for_store_creation
    redirect_to root_path if current_user.has_store == true
    false
  end
end
