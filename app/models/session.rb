class Session < ApplicationRecord
  belongs_to :professional
  belongs_to :patient

  validates :patient_id, presence: true
  validates :date, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  scope :by_month, ->(month, year) {
  where("strftime('%m', date) = ? AND strftime('%Y', date) = ?", month.to_s.rjust(2, '0'), year.to_s)
}

end

