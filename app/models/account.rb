class Account < ApplicationRecord
  #first_name, last_name, phone_number, carrier
  validates :first_name, :last_name, presence: true
  validates :phone_number, length: { is: 14 }, :allow_blank => true
  validates_presence_of :carrier, :if => :phone_number?

  has_one :user
  enum carrier: ["AT&T", "T-Mobile", "Verizon", "Sprint", "Virgin Mobile",
                 "Tracfone", "Metro PCS", "Boost Mobile", "Cricket",
                 "Republic Wireless", "Google Fi", "U.S. Cellular", "Ting",
                 "Consumer Cellular", "C-Spire", "Page Plus"]

  def full_name
    "#{self.first_name} #{self.last_name[0]}."
  end
end
