class PurchaseController < ApplicationController
  require 'payjp'

  def index
    #@products = Products.find(params[:product_id])
    @post_address =  current_user.city + current_user.address
    @post_name = current_user.destination_family_name + current_user.destination_first_name
    card = CreditCard.where(user_id: current_user.id).first

    if card.blank?

      redirect_to controller: "creditcard", action: "new"
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)

      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
      customer_card = customer.cards.retrieve(card.card_id)
      @card_brand = customer_card.brand
      case @card_brand
      when "Visa"
        @card_src = "logo_visa.gif"
      when "JCB"
        @card_src = "jcb-logomark-img-01.gif"
      when "MasterCard"
        @card_src = "mc_vrt_opt_pos_46_2x.png"
      when "American Express"
        @card_src = "amex-logomark-img-04.gif"
      when "Diners Club"
        @card_src = "diners-logomark-img-01.gif"
      when "Discover"
        @card_src = "discover-logomark-img-08.gifg"
      end
    end
  end

  def done
  end


  def pay
    #@products = Products.find(params[:id])
    card = CreditCard.find_by(user_id: current_user.id)
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    Payjp::Charge.create(
    amount: 13500, #@products.price
    customer: card.customer_id, 
    currency: 'jpy',
    )
    redirect_to  done_purchase_index_path 
  end
  
  # private

  # def products_params
  #   params.require(:product).permit(
  #     :name,
  #     :price,
  #   ).merge(user_id: current_user.id)
  # end
end