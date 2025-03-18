class Place < ApplicationRecord
  has_many :entries, dependent: :destroy
end