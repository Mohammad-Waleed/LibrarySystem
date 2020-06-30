class Manager < User
  belongs_to :library
  has_one_attached :image

  enum status:[:active , :inactive]

  validates :status ,:email,presence: {message:"This field is required"}
  validates :status, inclusion: {in: %w(active inactive)}
end
