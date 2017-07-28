class StoresController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @stores = Store.all
  end

  def new
    @store = Store.new
  end

  def create
    current_user.stores.create(store_params)
    redirect_to stores_path
  end

  def show
    @stores = Store.find(params[:id])
  end

  private

  def store_params
    params.require(:store).permit(:storename, :description, :location, :phone)
  end
end
