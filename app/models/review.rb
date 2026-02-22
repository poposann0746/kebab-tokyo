class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  has_many_attached :images

  enum :category, {
    kebab_sand: 0,
    kebab_wrap: 1,
    kebab_rice: 2,
    other: 3
  }, prefix: true

  enum :meat_type, {
    beef: 0,
    chicken: 1,
    mix: 2,
    other: 3
  }, prefix: true

  enum :sauce_type, {
    mild: 0,
    medium: 1,
    hot: 2,
    very_hot: 3,
    yogurt: 4,
    garlic_yogurt: 5,
    teriyaki: 6,
    other: 7
  }, prefix: true

  validates :overall_score, presence: true
  validates :overall_score, inclusion: { in: 1..10 }

  validate :validate_images

  private

  def validate_images
    return unless images.attached?

    if images.count > 3
      errors.add(:images, "は最大3枚までです")
    end

    images.each do |image|
      unless image.content_type.in?(%w[image/jpeg image/png image/webp])
        errors.add(:images, "はJPEG、PNG、WebP形式のみ対応しています")
      end

      if image.blob.byte_size > 5.megabytes
        errors.add(:images, "は1枚あたり5MB以下にしてください")
      end
    end
  end
end
