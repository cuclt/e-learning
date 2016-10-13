class Result < ApplicationRecord
  belongs_to :lesson
  belongs_to :question
  belongs_to :answer
  belongs_to :user

  scope :correct_anwsers, -> do
    joins(:answer).where("answers.is_correct = ?", true)
  end

  scope :search_by_condition, ->category_id do
    joins("INNER JOIN lessons ON results.lesson_id = lessons.id")
      .where "lessons.category_id = ?", category_id if category_id.present?
  end
end
