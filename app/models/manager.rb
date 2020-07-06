class Manager < User
  belongs_to :library

  has_one_attached :image

  validates :status, :email, presence: { message: 'This field is required'}
  validates :status, inclusion: { in: %w(active inactive)}

  private

    def issuer?
      false
    end
end
