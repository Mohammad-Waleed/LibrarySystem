class ManagersController<ApplicationController
  before_action :find_manager,only:[:show,:edit,:update,:destroy,:change_status]

  def index
    @managers = authorize Manager.where(library_id: current_user.library_id).order("created_at ASC")
  end

  def show
    @book=authorize Book.last
    @book_request=BookHistory.where(start_date:nil)
  end

  def new
    @manager=Manager.new
    authorize @manager
  end

  def create
    fields=manager_params
    fields[:library_id]=current_user.library_id
    @manager=authorize Manager.new(fields)
    if @manager.save
      redirect_to admin_path(current_user.id)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    authorize @manager
    manager_params[:library_id]=current_user.library_id
    if @manager.update(manager_params)
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    authorize @manager
    @manager.destroy
    redirect_to managers_path
  end

  def change_status
    authorize @manager
    if  @manager.active?
      @manager.update(status:'inactive')
    else
      @manager.update(status:'active')
    end
    redirect_to managers_path
  end

private

  def manager_params
    params.require(:manager).permit(:email,:status,:image,:password,:password_confirmation,:library_id)
  end

  def find_manager
    @manager=Manager.find(params[:id])
  end
end
