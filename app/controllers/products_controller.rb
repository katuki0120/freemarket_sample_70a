class ProductsController < ApplicationController
  before_action :set_product, only:[:show,:destroy,:edit,:update]
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
    @category = @product.category
    @size = @product.size.name
    @product_condition = @product.product_condition.name
    @delivery_fee = @product.delivery_fee.name
    @prefecture = @product.prefecture.name
    @delivery_days = @product.delivery_days.name
  end

  def destroy
    @product.destroy
  end
  
  def edit
    @images_length = @product.images.length
    grand_children_category = @product.category
    children_category = grand_children_category.parent

    @category_parent_array =[]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    @category_children_array = Category.where(ancestry: children_category.ancestry)
    @category_grand_children_array = Category.where(ancestry: grand_children_category.ancestry)

  end
 
  def update
    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def image_delete
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
  end
  private

  def product_params
    params.require(:product).permit( :name, :price, :brand, :product_introduction, :category_id, :product_condition_id, :size_id, :delivery_fee_id, :prefecture_id, :delivery_days_id, images: []).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
