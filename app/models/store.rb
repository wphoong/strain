class Store < ApplicationRecord
  belongs_to :user

  has_many :products, dependent: :destroy

  validates :storename, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :phonenumber, presence: true
end
