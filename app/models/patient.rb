class Patient < ApplicationRecord
    has_many :sessions
    has_many :professionals, through: :sessions
  end
