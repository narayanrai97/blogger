class Comment < ApplicationRecord
  belongs_to :article
  
  validates :commenter, presence: true
  validates :content,   presence: true
end
