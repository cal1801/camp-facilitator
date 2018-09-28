class Account < ApplicationRecord
  has_one :user
  enum carrier: ["AT&T", "T-Mobile", "Verizon", "Sprint", "Virgin Mobile",
                 "Tracfone", "Metro PCS", "Boost Mobile", "Cricket",
                 "Republic Wireless", "Google Fi", "U.S. Cellular", "Ting",
                 "Consumer Cellular", "C-Spire", "Page Plus"]
                 
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
