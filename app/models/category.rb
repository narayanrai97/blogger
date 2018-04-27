class Category < ApplicationRecord
    has_many :articles
    has_one  :description # One Categoy must have only one Description
end
