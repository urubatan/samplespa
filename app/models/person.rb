class Person < ApplicationRecord
  has_rich_text :description

  validates :name, :email, :description, presence: true
end
