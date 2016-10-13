class Category < ApplicationRecord
  has_many :lessons
  has_many :questions

  validates :title, presence: true, length: {maximum: 100},
    uniqueness: {case_sensitive: false}
  validates :question_number, presence: true, inclusion: 1..20

  scope :newest, -> {order created_at: :desc}
  scope :search_name, ->name do
    where "title LIKE ?", "%#{name}%" if name.present?
  end
end
