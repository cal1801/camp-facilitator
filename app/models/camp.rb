class Camp < ApplicationRecord
  has_one :user
  has_many :accounts, through: :user
end
