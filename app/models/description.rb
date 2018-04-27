class Description < ApplicationRecord
  belongs_to :category
  
  validates :category, uniqueness: true # restricts category to only one description
end
