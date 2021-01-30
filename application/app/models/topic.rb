class Topic < ApplicationRecord

    validates :name, uniqueness: true
end
