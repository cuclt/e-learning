class Lesson < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :results
  has_many :questions, through: :results
  has_many :answers, through: :results

  delegate :title, to: :category

  scope :uniq_by_category, ->{select "DISTINCT category_id"}

  validates :user, presence: true
  validates :category, presence: true

  before_create :lesson_results
  accepts_nested_attributes_for :results,
    reject_if: proc {|attributes| attributes[:answer_id].blank?},
    allow_destroy: true

  private
  def lesson_results
    if self.category.questions.count >= self.category.question_number
      self.category.questions.random.limit(category.question_number).each do |question|
        self.results.build question_id: question.id, user_id: user_id
      end
    else
      raise ActiveRecord::Rollback
    end
  end
end
