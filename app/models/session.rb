class Session < ApplicationRecord
  belongs_to :professional
  belongs_to :patient

  validates :patient_id, presence: true
  validates :date, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end

