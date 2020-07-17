class ApplicationController < ActionController::Base
  # Basic認証のbeforeアクション ifで本番環境かそうでないかの確認をしている
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters , if: :devise_controller?


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:email,:password,:password_confirmation,:family_name,:first_name,:family_name_kana,:first_name_kana,:birthday,:destination_family_name,:destination_first_name,:destination_family_name_kana,:destination_first_name_kana,:postal_code,:prefecture,:city,:address,:building_name,:phone_number])
  end

  private
  # Basic認証を確認するためのメソッド
  def production?
    Rails.env.production?
  end
  # Basic認証のメソッド
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

end
