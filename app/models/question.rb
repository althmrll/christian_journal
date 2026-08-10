class Question < ApplicationRecord
  scope :answered, -> { where(answered: true) }
  scope :unanswered, -> { where(answered: [ false, nil ]) }

  def answered?
    answer.present?
  end
end
