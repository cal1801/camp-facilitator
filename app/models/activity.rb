class Activity < ApplicationRecord
  belongs_to :guest_group, optional: true
  has_and_belongs_to_many :users
end
