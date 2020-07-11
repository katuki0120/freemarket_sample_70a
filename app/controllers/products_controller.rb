class ProductsController < ApplicationController
  before_action :category_parent_array, only: [:new, :create, :edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :show_all_instance, only: [:show, :edit, :destroy]
  
  def edit
    # ▼ ①ここで該当商品の子・孫カテゴリーを変数へ代入
    grandchild = @products.category
    child = grandchild.parent
    if @category_id == 46 or @category_id == 74 or @category_id == 134 or @category_id == 142 or @category_id == 147 or @category_id == 150 or @category_id == 158
      else
       # ② ▼ 親カテゴリーのnameとidを配列代入
       @parent_array = []
       @parent_array << @product.category.parent.parent.name
       @parent_array << @product.category.parent.parent.id
      end
     # ③ ▼ 子カテゴリーを全てインスタンス変数へ代入
     @category_children_array = Category.where(ancestry: child.ancestry)
     # ④ ▼ 子カテゴリーのnameとidを配列代入
     @child_array = []
     @child_array << child.name # ⑤で生成した変数を元にname・idを取得
     @child_array << child.id
     # ⑤ ▼ 孫カテゴリーを全てインスタンス変数へ代入
     @category_grandchildren_array = Category.where(ancestry: grandchild.ancestry) 
     # ⑥ ▼ 孫カテゴリーのnameとidを配列代入
     @grandchild_array = []
     @grandchild_array << grandchild.name # ⑤で生成した変数を元にname・idを取得
     @grandchild_array << grandchild.id
    end
  end
  
  def update
    # ①
    if item_params[:images_attributes].nil?
      flash.now[:alert] = '更新できませんでした 【画像を１枚以上入れてください】'
      render :edit
    else
    # ②
      exit_ids = []
      item_params[:images_attributes].each do |a,b|
        exit_ids << item_params[:images_attributes].dig(:"#{a}",:id).to_i
      end
      ids = Image.where(item_id: params[:id]).map{|image| image.id }
    # ③
      delete__db = ids - exit_ids
      Image.where(id:delete__db).destroy_all
    # ④
      @item.touch
      if @item.update(item_params)
        redirect_to  update_done_items_path
      else
        flash.now[:alert] = '更新できませんでした'
        render :edit
      end
    end
  end

#中略

  private
    def product_params
      params.require(:product).permit(:name, :price, :category, :brand, :product_condition, :size, :dealing_status, :shipment,:buyer_id, :, images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
    end
  
    def set_item
      @item = Item.find(params[:id])                                # ⑦ 該当の商品情報をインスタンス変数へ代入
    end
  
    def category_parent_array
      @category_parent_array = Category.where(ancestry: nil)        # ⑧ 親カテゴリーを全てインスタンス変数へ代入
    end
  
    def show_all_instance
      @user = User.find(@item.user_id)
      @images = Image.where(item_id: params[:id])                   # ⑨ 該当商品の画像をインスタンス変数へ代入
      @images_first = Image.where(item_id: params[:id]).first
      @category_id = @item.category_id                              # ⑩ 該当商品のレコードからカテゴリーidを取得し、インスタンス変数へ代入（この際に取得するidは孫カテゴリーidです。）
      @category_parent = Category.find(@category_id).parent.parent                    
      @category_child = Category.find(@category_id).parent
      @category_grandchild = Category.find(@category_id)
    end