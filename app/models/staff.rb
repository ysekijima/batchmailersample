class Staff < ApplicationRecord

  has_many :posts, dependent: :destroy
  belongs_to :shop

end
