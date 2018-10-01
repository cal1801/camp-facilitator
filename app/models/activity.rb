class Activity < ApplicationRecord
  #name, day, start, end, staff_needed
  validates :name, :day, :start, :end, :staff_needed, presence: true
  validate :day_in_guest_group?
  validate :start_before_end?

  belongs_to :guest_group, optional: true
  has_and_belongs_to_many :users

  def day_in_guest_group?
    group = self.guest_group
    unless (group.arrives..group.leaves).include?(day)
      errors.add(:day, "Day needs to be inbetween group's arriving and leaving date")
    end
  end

  def start_before_end?
    if self.end < self.start
      errors.add(:end, "Ending time must be after starting time")
    end
  end
end
