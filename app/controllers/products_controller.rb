class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    if !current_user.present?
      redirect_to new_user_session_path
    else
      @store = Store.find_by_id(params[:store_id])
      return render_not_found(:forbidden) if @store.user != current_user
      @product = Product.new
    end
  end

  def create
    @store = Store.find_by_id(params[:store_id])
    return render_not_found(:forbidden) if @store.user != current_user
    @store.products.create(product_params.merge(user: @store.user))
    redirect_to store_path(@store)
  end

  private

  def product_params
    params.require(:product).permit(:strain, :straintype, :effects, :description)
  end
end
