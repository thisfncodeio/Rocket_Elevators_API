class Address < ApplicationRecord
    belongs_to :customers
    has_one :building

end
