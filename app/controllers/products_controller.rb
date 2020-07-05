class ProductsController < ApplicationController
  
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      flash.now[:alert] = '入力されていない項目があります。'
      render :new
    end
  end

  def edit
  end

  def update
    else

  end

  private

  def product_params
    params.require(:product).permit(:name,:price,:dealing_status,:product_introduction,:category_id,:product_condition_id,:size_id,brand:[:brand],shipment:[:area,:charge_payment,:day],product_imgs:[:image])
  end
  
end
