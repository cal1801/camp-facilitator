class GuestGroup < ApplicationRecord
  #name, description, arrives, leaves
  validates :name, :arrives, :leaves, presence: true
  validate :dates_correct?

  def dates_correct?
    if arrives < Date.today()
      errors.add(:arrives, 'Arriving date cannot be in the past')
    end
    if leaves < Date.today()
      errors.add(:leaves, 'Leaving date cannot be in the past')
    end
    if leaves < arrives
      errors.add(:leaves, 'Cannot select a leaving date that is before the arriving date')
    end
  end

  belongs_to :camp
  has_many :activities, dependent: :delete_all
  default_scope {where("leaves >= ?", DateTime.now)}
  accepts_nested_attributes_for :activities
end
