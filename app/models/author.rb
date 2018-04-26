class Author < ApplicationRecord
  has_many :articles
  
  validates :username, :email, presence: true
    
  authenticates_with_sorcery!
  validates_confirmation_of :password, message: "should match confirmation", if: :password

  #does the author have any articles?
  
  scope :no_articles, -> { left_outer_joins(:articles).where(articles: { id: nil }) }
end
