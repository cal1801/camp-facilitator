class Activity < ApplicationRecord
  #name, day, start, end, staff_needed
  validates :name, :day, :start, :end, :staff_needed, presence: true
  validate :day_in_guest_group?
  validate :start_before_end?

  belongs_to :guest_group, optional: true
  has_and_belongs_to_many :users
  before_destroy { users.clear }

  scope :upcoming, -> { where("day >= ?", Date.today())}
  scope :past, -> { where("day < ?", Date.today())}


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

  def self.time_diff(seconds_diff)
    #we are passing this in now
    #seconds_diff = (start_time - end_time).to_i.abs
  
    hours = seconds_diff / 3600
    seconds_diff -= hours * 3600
  
    minutes = seconds_diff / 60
    seconds_diff -= minutes * 60
  
    seconds = seconds_diff
  
    '%01d:%02d' % [hours, minutes]
    #"#{hours.to_s.rjust(2, '0')}:#{minutes.to_s.rjust(2, '0')}"
    # or, as hagello suggested in the comments:
    # '%02d:%02d:%02d' % [hours, minutes, seconds]
  end
end
