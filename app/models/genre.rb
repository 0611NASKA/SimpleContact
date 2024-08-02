class Genre < ApplicationRecord
  has_many :inquiries, dependent: :destroy

  validates :name, presence: true
end
