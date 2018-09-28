class Camp < ApplicationRecord
  has_one :user
  has_many :accounts, through: :user
  has_many :guest_groups
end
