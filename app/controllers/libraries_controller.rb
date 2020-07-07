class LibrariesController < ApplicationController
  before_action :check_authorization
  before_action :set_library, only: [:edit, :update]

  def index
    @libraries = Library.all.order(:id)
  end

  def edit
    @library = Library.find(params[:id])
  end

  def update
    if  @library.update(parameters)
      redirect_to current_user
    else
      render 'edit'
    end
  end

  private

    def set_library
      @library = Library.find_by(id: params[:id])
    end

    def parameters
      params.require(:library).permit(:fine)
    end

    def check_authorization
      authorize Library
    end
end
