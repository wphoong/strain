class Product < ApplicationRecord
  belongs_to :store
  belongs_to :user

  validates :strain, presence: true
  validates :description, presence: true
  validates :straintype, presence: true
  validates :effects, presence: true
end
