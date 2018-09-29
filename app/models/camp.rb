class Camp < ApplicationRecord
  has_many :users
  has_many :accounts, through: :users
  has_many :guest_groups
end
