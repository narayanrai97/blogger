class Event < ApplicationRecord
     validates :name, uniqueness: true
end
