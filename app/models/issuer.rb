class Issuer < User
  has_one_attached :image
  has_many :book_histories

  validates :fname, :lname, :balance, presence: { message: 'This field is required'}
  validates :fname, :lname, length: { minimum: 3, maximum: 20}
  validates :status, inclusion: { in: %w(active inactive)}
  validates :balance, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :fname, :lname, format: { with: /\A[a-zA-Z]+\z/, message: 'Only allows letters' }
end
