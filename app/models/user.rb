class User < ApplicationRecord
  has_secure_password

  has_many :feelings, inverse_of: :user, dependent: :destroy
  validates :first_name, :last_name, :email, :password_digest, presence: true

  def check_current_total
    feelings.current.count > 4
  end

  def get_feelings_order
    feelings.current.pluck(:id, :page_order)
  end
end
