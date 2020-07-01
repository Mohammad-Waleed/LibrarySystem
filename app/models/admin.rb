class Admin < User
  belongs_to :library

private

  def issuer?
    false
  end
end
