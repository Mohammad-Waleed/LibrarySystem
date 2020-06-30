class LibrariesController < ApplicationController

  def index
    @libraries=  Library.all.order(:id)
    authorize @libraries
  end

  def edit
    @library=  Library.find(params[:id])
    authorize @library
  end

  def update
    authorize Library
    if  Library.update(params[:id],parameters)
      redirect_to current_user
    else
      render 'edit'
    end
  end

private

  def find_library
    @library = authorize Library.find(params[:id])
  end

  def parameters
    params.require(:library).permit(:fine)
  end
end
