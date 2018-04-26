class Tag < ApplicationRecord
    
    has_many :taggings, dependent: :destroy
    
    has_many :articles, through: :taggings # May be belongs_to :article too
    
    validates :name, presence: true, allow_nil: true
    
    def to_s
        name
    end
end
