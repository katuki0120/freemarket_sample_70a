class ProductsController < ApplicationController

  def new
    @product = Product.new
    @category_parent_array =["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grand_children
    @category_grand_children = Category.find("#{params[:child_id]}").children
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to "/mypages"
    else
      @category_parent_array =["---"]
      Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
      end
      redirect_to action: :new
    end
  end

  def show
    @products = Product.order('created_at DESC').find(params[:id])
    @categorys = @products.category
    @size = @products.size.name
    @product_condition = @products.product_condition.name
    @delivery_fee = @products.delivery_fee.name
    @prefecture = @products.prefecture.name
    @delivery_days = @products.delivery_days.name
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    
  end

  private

  def product_params
    params.require(:product).permit( :name, :price, :brand, :product_introduction, :category_id, :product_condition_id, :size_id, :delivery_fee_id, :prefecture_id, :delivery_days_id, images: []).merge(user_id: current_user.id)
  end

end
