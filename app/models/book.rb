class Book < ApplicationRecord
  belongs_to :library
  has_many_attached :images
  has_many :book_histories

  enum status:[:available,:unavailable]

  validates :title,:isbn,:author,:year,:genre,:no_of_copies,:status,:library_id ,presence:{message:"This field is required"}
  validates :isbn , length: { in: 10..13 }
  validates :year,  length: { is: 4 }
  validates :year,:isbn,:no_of_copies ,numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :isbn,uniqueness: {message:"ISBN must be unique"}
  validates :status, inclusion: {in: %w(available unavailable)}
end
