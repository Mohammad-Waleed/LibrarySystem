class ManagersController<ApplicationController
  before_action :check_authorization
  before_action :set_manager, only: [ :show, :edit, :update, :destroy, :change_status]

  def index
    @managers = Manager.where(library_id: current_user.library_id).order('created_at ASC')
  end

  def show
    @book_request = BookHistory.where(start_date: nil)
  end

  def new
    @manager = Manager.new
  end

  def create
    @manager = Manager.new(manager_params)
    if @manager.save
      redirect_to admin_path(current_user.id)
    else
      render 'new'
    end
  end

  def update
    if @manager.update(manager_params)
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    if !@manager.destroy
      flash[:alert] = 'Could not delete the book!'
    end
    redirect_to managers_path
  end

  def change_status
    @manager.active?? @manager.inactive! : @manager.active!
    redirect_to managers_path
  end

private

  def manager_params
    params.require(:manager).permit( :email, :status, :image, :password, :password_confirmation, :library_id).tap do |hash|
      hash[:library_id] = current_user.library_id
    end
  end

  def set_manager
    @manager = Manager.find_by(id: params[:id])
  end

  def check_authorization
      authorize Manager
  end
end
