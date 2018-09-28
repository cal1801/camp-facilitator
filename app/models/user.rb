class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  enum role: [:user, :camp_admin, :master_admin]
  after_initialize :set_default_role, :if => :new_record?

  belongs_to :account
  belongs_to :camp

  def set_default_role
    self.role ||= :user
  end
end
