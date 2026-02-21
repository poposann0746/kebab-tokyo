class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop

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
end
