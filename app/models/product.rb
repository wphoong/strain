class Product < ApplicationRecord
  belongs_to :store

  validates :strain, presence: true
  validates :description, presence: true
  validates :type, presence: true
  validates :effects, presence: true
end
