class Admin::AdminsController < Admin::BaseController
  before_action :authenticate_admin!
  before_action :find_admin, except: [:index, :new, :create]
  before_action :is_superadmin

  def index
    @admins = Admin.order(:id).page params[:page]
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admin_admins_path, notice: t('admins.hint.admin_created')
    else
      render 'new'
    end
  end

  def edit; end

  def show; end

  def update
    if @admin.update(admin_params)
      redirect_to admin_admin_path, notice: t('admins.hint.admin_edited')
    else
      render 'edit'
    end
  end

  def destroy
    @admin.destroy
    redirect_to admin_admins_path, notice: t('admins.hint.admin_deleted')
  end

  private

  def admin_params
    params.require(:admin).permit(:email,
                                  :password,
                                  :role)
  end

  def find_admin
    @admin = Admin.find(params[:id])
  end
end
