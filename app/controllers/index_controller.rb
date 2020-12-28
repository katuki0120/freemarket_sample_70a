class IndexController < ApplicationController

  def index 
    @products = Product.limit(5).order(id: :desc)
  end
  

end
