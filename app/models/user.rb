class User < ApplicationRecord
  has_secure_password

  has_many :feelings, inverse_of: :user, dependent: :destroy
  validates :first_name, :last_name, :email, :password_digest, presence: true

  def check_current_total
    feelings.current.count
  end

  def check_feelings_order
    feelings.current.pluck(:id, :page_order)
  end

  def can_update_today?
    feelings.last.created_at < Time.zone.yesterday.end_of_day
  end

  def complete_onboarding
    update(onboarding_complete: true)
  end
end
