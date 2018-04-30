class Category < ApplicationRecord
    has_many :articles
    has_one  :description # One Categoy can have only one Description
end

# category = Category.new(name: "Used Car")
# category.build_description(text: "You will easily find used cars here.")
# category.description