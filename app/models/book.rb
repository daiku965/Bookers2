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

  scope :created_today, -> { where(created_at: Time.zone.now.all_day).count }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day).count }
  scope :created_this_week, -> { where(created_at: Time.zone.now.all_week).count }
  scope :created_last_week, -> { where(created_at: Time.zone.now.prev_week.all_week).count }

  def self.post_ratio(created_current, created_past)
    if created_past == 0
      0
    else
      created_current / created_past * 100
    end
  end
end
