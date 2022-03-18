class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
  validates :title, presence: true, length: { minimum: 6, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 300 }

  scope :free, -> { where(premium: false) }
  scope :premium, -> { where(premium: true) }

  def to_s
    title
  end

  def self.search(query)
    return all.order('title ASC') if query.blank?

    where('LOWER(title) LIKE ?', "%#{query.downcase}%").order('title ASC')
  end
end
