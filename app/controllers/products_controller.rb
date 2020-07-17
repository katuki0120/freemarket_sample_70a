class ProductsController < ApplicationController
  def index
    
  end

  def new
    
  end

  def show
    @products = Product.order('created_at DESC').find(params[:id])
  end

  def destroy
    #@product.destroy
    #redirect_to  delete_products_path
  end
end
