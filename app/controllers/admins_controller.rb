class AdminsController < ApplicationController
  before_action :check_authorization

  def show
    @issuers_request = Issuer.unapproved.where(library_id: current_user.library_id)
  end

  private

    def check_authorization
      authorize Admin
    end
end
