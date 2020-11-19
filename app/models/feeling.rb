class Feeling < ApplicationRecord
  belongs_to :user, inverse_of: :feelings, optional: true

  enum persistent: {
    old: 0,
    current: 1
  }
end
