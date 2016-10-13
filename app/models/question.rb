class Question < ApplicationRecord
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :results
  validates :name, presence: true
  has_many :lessons, through: :results

  scope :random, ->{order "RANDOM()"}
  scope :newest, -> {order created_at: :desc}
  scope :search_by_condition, ->category_id do
    joins(:category).where "categories.id = ?", category_id if category_id.present?
  end

  validates :name, presence: true, length: {maximum: 50}

  accepts_nested_attributes_for :answers,
    allow_destroy: true
end
