class Building < ApplicationRecord
    #belongs_to : customer
    #has_one :address
   has_one :building_detail
   belongs_to :customer
   belongs_to :address
   has_many :batteries
    
end
