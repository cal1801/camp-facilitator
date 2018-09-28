class GuestGroup < ApplicationRecord
  belongs_to :camp
  has_many :activities, dependent: :delete_all
  default_scope {where("leaves >= ?", DateTime.now)}
  accepts_nested_attributes_for :activities
end
