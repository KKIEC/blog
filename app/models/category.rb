class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories
  validates :name, presence: true,
                    uniqueness: true,
                    length: { minimum: 3, maximum: 25 }

  def self.search(query)
    return all.order('name ASC') if query.blank?

    where('LOWER(name) LIKE ?', "%#{query.downcase}%").order('name ASC')
  end
end
