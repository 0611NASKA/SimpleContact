class Genre < ApplicationRecord
  has_many :inquiries, dependent: :destroy
end
