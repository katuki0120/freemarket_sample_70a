class Comment < ApplicationRecord

  belong_to :user
  belong_to :product

end