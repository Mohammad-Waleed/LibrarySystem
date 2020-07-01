class AdminsController < ApplicationController
  before_action :check_authorization

  def show
    @issuers_request=Issuer.unapproved
  end

  private

    def check_authorization
      authorize Admin
    end

end
