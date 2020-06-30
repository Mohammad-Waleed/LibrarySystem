class AdminsController<ApplicationController
  def show
    @issuers_request=Issuer.where(approval: :unapproved)
    authorize Admin
  end
end
