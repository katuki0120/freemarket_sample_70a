class CreditcardController < ApplicationController
  
  before_action :set_card, only: [:new, :show, :destroy]
  before_action :set_payjpSecretKey, except: :new
  before_action :set_user

  require "payjp"

  def new
    redirect_to action: :show, id: current_user.id if @card.present?
    @creditcard = Creditcard.new 
    gon.payjpPublicKey = Rails.application.credentials[:payjp][:PAYJP_PUBLIC_KEY]
  end

  def create
    render action: :new if params['payjpToken'].blank?
    customer = Payjp::Customer.create(
      card: params['payjpToken']
    )
    @creditcard = Ccreditcard.new(
      card_id: customer.default_card,
      user_id: current_user.id,
      customer_id: customer.id
    )
    if @creditcard.save
      flash[:notice] = 'クレジットカードの登録が完了しました'
      redirect_to action: :show, id: current_user.id
    else
      flash[:alert] = 'クレジットカード登録に失敗しました'
      redirect_to action: :new
    end
  end

   def show
    redirect_to action: :new if @creditcard.blank?
    customer = Payjp::Customer.retrieve(@creditcard.customer_id)
    default_card_information = customer.cards.retrieve(@creditcard.card_id)
    @card_info = customer.cards.retrieve(@creditcard.card_id)
    @exp_month = default_card_information.exp_month.to_s
    @exp_year = default_card_information.exp_year.to_s.slice(2,3)
    customer_card = customer.cards.retrieve(@creditcard.card_id)
    @card_brand = customer_card.brand
    case @card_brand
    when "Visa"
      @creditcard_src = "icon_visa.png"
    when "JCB"
      @creditcard_src = "icon_jcb.png"
    when "MasterCard"
      @creditcard_src = "icon_mastercard.png"
    when "American Express"
      @creditcard_src = "icon_amex.png"
    when "Diners Club"
      @creditcard_src = "icon_diners.png"
    when "Discover"
      @creditcard_src = "icon_discover.png"
    end
  end

  def destroy
    customer = Payjp::Customer.retrieve(@creditcard.customer_id)
    @creditcard.destroy
    customer.delete
    flash[:notice] = 'クレジットカードが削除されました'
    redirect_to controller: :users, action: :show, id: current_user.id
  end

  private
  def set_card
    @creditcard = Creditcard.where(user_id: current_user.id).first
  end

  def set_payjpSecretKey
    Payjp.api_key = Rails.application.credentials[:payjp][:PAYJP_SECRET_KEY]
  end

  def set_cart
    @cart = current_cart
  end

  def set_user
    @user = current_user
  end
end