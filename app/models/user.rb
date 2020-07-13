class User < ApplicationRecord
  before_create :check_type

  has_one_attached :image

  enum approval: [:unapproved, :approved]
  enum type: [:Admin, :Manager, :Issuer]
  enum status: [:active, :inactive]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:email, :library_id]

  validates :fname, :lname, :balance, :email, presence: { message: 'This field is required' }, if: :issuer?
  validates :balance, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :issuer?
  validates :fname, :lname, format: { with: /\A[a-zA-Z]+\z/, message: 'Only allows letters' }, if: :issuer?

  def active_for_authentication?
    super && self.Issuer? ? self.approved? && self.active? : self.Manager? ?  self.active? : true
  end

  def inactive_message
    self.Issuer? && self.unapproved? ? message_inactive('unapproved') : message_inactive('inactive')
  end

  private

    def issuer?
      true
    end

    def message_inactive(msg)
      "Sorry, this account is #{msg}"
    end

    def check_type
      self.type = 'Issuer' if self.type == nil
    end
end
