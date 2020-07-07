class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  validate :is_clickbait?

  CLICKBAIT_PATTERNS = [
    "Won't Believe",
    "Secret",
    "Top 0",
    "Top 1",
    "Top 2",
    "Top 3",
    "Top 4",
    "Top 5",
    "Top 6",
    "Top 7",
    "Top 8",
    "Top 9",
    "Guess"
  ]

  def is_clickbait?
    idx = 0
    clickbait_exists = true
    while idx < CLICKBAIT_PATTERNS.size
      if title && !title.split.include?(CLICKBAIT_PATTERNS[idx])
        clickbait_exists = false
        break
      else
        idx = idx + 1
      end
    end
    
    if clickbait_exists == false
      errors.add(:title, "must be clickbait")
    end
  end
  
end