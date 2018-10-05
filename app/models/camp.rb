class Camp < ApplicationRecord
  has_many :users, dependent: :delete_all
  has_many :accounts, through: :users
  has_many :guest_groups, dependent: :delete_all
end
