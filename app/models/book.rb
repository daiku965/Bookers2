class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search_for(model, keyword, method)
    if method == 'exact'
      Book.where(title: keyword)
    elsif method == 'forward'
      Book.where('title LIKE ?', keyword+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+keyword)
    else
      Book.where('title LIKE ?', '%'+keyword+'%')
    end
  end
end
