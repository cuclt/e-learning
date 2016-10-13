class Answer < ApplicationRecord
  belongs_to :question, optional: true
  has_many :results
  has_many :lessons, through: :results
end
