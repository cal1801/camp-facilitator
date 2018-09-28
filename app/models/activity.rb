class Activity < ApplicationRecord
  belongs_to :guest_group, optional: true
end
