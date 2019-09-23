class GuestGroup < ApplicationRecord
  #name, description, arrives, leaves
  validates :name, :arrives, :leaves, presence: true
  validate :dates_correct?
  
  #default_scope {where("leaves >= ?", Date.today())}

  belongs_to :camp
  has_many :activities, dependent: :delete_all
  accepts_nested_attributes_for :activities, allow_destroy: true

  scope :upcoming, -> { where("leaves >= ?", Date.today())}
  scope :past, -> { where("leaves < ?", Date.today())}

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
end
