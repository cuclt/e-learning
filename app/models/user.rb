class User < ApplicationRecord
  has_many :lessons
  has_many :results
  has_secure_password
  before_save :downcase_email
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  scope :newest, -> {order created_at: :desc}
  scope :search_condition, ->condition do
    where "name LIKE ? OR email LIKE ?", "%#{condition}%",
      "%#{condition}%" if condition.present?
  end

  def is_user? user
    self == user
  end

  private
  def downcase_email
    self.email = email.downcase
  end
end
