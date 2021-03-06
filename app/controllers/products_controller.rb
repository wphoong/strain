class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

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

  def show
    @store = Store.find_by_id(params[:store_id])
    @product = Product.find_by_id(params[:id])
    return render_not_found if @product.blank?
  end

  def edit
    @store = Store.find_by_id(params[:store_id])
    @product = Product.find_by_id(params[:id])
    return render_not_found if @product.blank?
    return render_not_found(:forbidden) if @store.user != current_user
  end

  def update
    @store = Store.find_by_id(params[:store_id])
    @product = Product.find_by_id(params[:id])
    return render_not_found if @product.blank?
    return render_not_found(:forbidden) if @store.user != current_user
    @product.update_attributes(product_params)
    redirect_to store_path(@store) if @store.valid?
  end

  def destroy
    @store = Store.find_by_id(params[:store_id])
    @product = Product.find_by_id(params[:id])
    return render_not_found if @product.blank?
    return render_not_found(:forbidden) if @store.user != current_user
    @store.destroy
    redirect_to store_path(@store) if @store.valid?
  end

  private

  def product_params
    params.require(:product).permit(:strain, :straintype, :effects, :description)
  end
end
