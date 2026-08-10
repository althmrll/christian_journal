class Question < ApplicationRecord
  scope :unanswered, -> { where(answer: [ nil, "" ]) }
  scope :answered, -> { where.not(answer: [ nil, "" ]) }

  def answered?
    answer.present?
  end
end
