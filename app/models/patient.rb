class Patient < ApplicationRecord
    has_many :sessions
    has_and_belongs_to_many :professionals
  end
