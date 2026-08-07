class Prayer < ApplicationRecord
  scope :answered, -> { where(answered: true) }
  scope :unanswered, -> { where(answered: [ false, nil ]) }
end
