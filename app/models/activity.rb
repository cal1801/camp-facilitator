class Activity < ApplicationRecord
  #name, day, start, end, staff_needed
  validates :name, :day, :start, :end, :staff_needed, presence: true
  #validate :day_in_guest_group?
  #validate :start_before_end?

  enum activity_type: [:hourly, :all_day, :multi_day]

  belongs_to :guest_group, optional: true
  has_and_belongs_to_many :users

  before_validation :modify_dates_bsaed_of_activity_type
  before_destroy { users.clear }

  #scope :order_by_start, -> { order(day: :asc, start: :desc) }
  scope :upcoming, -> { where("day >= ?", Date.today())}
  scope :past, -> { where("day < ?", Date.today())}

  def day_and_time_span
    output = ''
    output += "#{self.day.strftime("%a, %b %e")} "
    if self.activity_type != 'all_day'
      output += "#{self.start.in_time_zone('Eastern Time (US & Canada)').strftime("%l:%M")} - "
      if self.day != self.try(:end_date) && !self.end_date.nil?
        output += "#{self.end_date.strftime("%a, %b, %e")} "
      end
      output += "#{self.end.in_time_zone('Eastern Time (US & Canada)').strftime("%l:%M %P")}"
    else
      output += "- All Day"
    end
    return output
  end

  def self.order_by_start(activities)
    activities.sort_by{|a| [a.day, a.start.to_s(:time)]}
  end

  def day_in_guest_group?
    group = self.guest_group
    if day < group.arrives.to_date || day > group.leaves.to_date #(group.arrives..group.leaves).include?(day)
      errors.add(:day, "needs to be inbetween group's arriving and leaving date")
    end
  end

  def start_before_end?
    #gotta test depending on what the type is
    case self.activity_type
      when 'hourly'
        if self.end < self.start
          errors.add(:end, "Ending time must be after starting time")
        end
      when 'multi_day'
        binding.pry
        if self.day > self.end_date
          errors.add(:end, "Ending date must be after starting date")
        elsif self.day == self.end_date
          if self.end < self.start
            errors.add(:end, "Ending time must be after starting time")
          end
        end
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

  def self.update_for_new_columns
    Time.zone = 'Eastern Time (US & Canada)'
    Activity.all.each do |activity|
      activity.start = Time.zone.local(activity.day.year, activity.day.month, activity.day.day, activity.start.hour, activity.start.min, activity.start.sec)
      if activity.name == 'Host Group'
        activity.end = Time.zone.local(activity.day.year, activity.day.month, activity.day.day, activity.start.hour+2, activity.start.min, activity.start.sec)
      else
        activity.end = Time.zone.local(activity.day.year, activity.day.month, activity.day.day, activity.end.hour, activity.end.min, activity.end.sec)
      end
      activity.end_date = activity.day
      activity.activity_type = 'hourly'
      activity.save!
    end
  end

  def modify_dates_bsaed_of_activity_type
    #if user has selected "all_day" or "hourly" for the activity_type
    #then we need to modify the end_date value to reflect the same
    #date for the "day" value (which is the start_date really)
    if %w(all_day hourly).include?(self.activity_type)
      self.end_date = self.day
    end

    if self.activity_type == 'all_day'
      self.start = Time.zone.local(2000,1,1,00,00,00)
      self.end = Time.zone.local(2000,1,1,23,59,59)
    end
  end
end
