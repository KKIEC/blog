class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles, dependent: :destroy
  validates :username, presence: true,
                        uniqueness: { case_sensitive: false },
                        length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
  has_secure_password

  def to_s
    email
  end

  after_create do
    customer = Stripe::Customer.create(email: self.email)
  end

  def self.search(query)
    return all.order('username ASC') if query.blank?

    where('LOWER(username) LIKE ?', "%#{query.downcase}%").order('username ASC')
  end
end
