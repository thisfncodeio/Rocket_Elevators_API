class Customer < ApplicationRecord
    belongs_to :user
    belongs_to :addresses
    has_many :buildings
    
end
