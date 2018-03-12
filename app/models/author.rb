class Author < ApplicationRecord
  has_many :articles
  
  validates :username, :email, presence: true
    
  authenticates_with_sorcery!
  validates_confirmation_of :password, message: "should match confirmation", if: :password
end
