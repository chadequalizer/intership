class AdminPolicy
  attr_reader :admin, :admin_user

  def initialize(admin, admin_user)
    @admin = admin
    @admin_user = admin_user
  end

  def destroy?
    is_superadmin?
  end

  def index?
    is_superadmin?
  end

  def new?
    is_superadmin?
  end

  def create?
    is_superadmin?
  end

  def edit?
    is_superadmin?
  end

  def show?
    is_superadmin?
  end

  def update?
    is_superadmin?
  end

  private

  def is_superadmin?
    admin.superadmin?
  end
end
