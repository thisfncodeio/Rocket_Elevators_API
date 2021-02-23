class Customer < ApplicationRecord
    belongs_to :user
    has_many :addresses
    has_many :buildings
    
end
