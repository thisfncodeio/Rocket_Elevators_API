class Battery < ApplicationRecord
    has_many :columns
    belongs_to :building
    belongs_to :employee
end
