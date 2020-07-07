class Issuer < User
  has_one_attached :image

  has_many :book_histories

  validates :fname, :lname, :balance, presence: { message: 'This field is required' }
  validates :fname, :lname, length: { minimum: 3, maximum: 20, message: 'Name should be in the range of 3-20 letters' }
  validates :status, inclusion: { in: %w(active inactive) }
  validates :balance, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :fname, :lname, format: { with: /\A[a-zA-Z]+\z/, message: 'Only allows letters' }

  after_update :send_welcome_mail, if: :approval_changed?

  private
    def send_welcome_mail
      IssuerMailer.welcome(self).deliver_now!
    end
end
