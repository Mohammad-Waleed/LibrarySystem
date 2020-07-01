class User < ApplicationRecord
  has_one_attached :image
  before_create :check_type

  enum approval:[:unapproved,:approved]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,authentication_keys: [:email,:library_id]

validates :status,:fname,:lname,:balance, presence: {message:"This field is required"}  ,if: :issuer?
validates :status, inclusion: {in: %w(active inactive)}                                 ,if: :issuer?
validates :balance, numericality: {only_integer: true , greater_than_or_equal_to: 0}    ,if: :issuer?
validates :fname,:lname, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" },if: :issuer?

  def active_for_authentication?
    if self.type == "Issuer"
      super && self.approved? && self.active?
    elsif self.type == "Manager"
      super && self.active?
    else
      super
    end
  end

  def inactive_message
    if self.type == "Issuer" && self.unapproved?
      "Sorry, this account is not approved yet."
    else
      "Sorry, this account is Inactive."
    end
  end

private

  def issuer?
    true
  end

  def check_type
    if ! self.type
      self.type = "Issuer"
    end
  end
end
