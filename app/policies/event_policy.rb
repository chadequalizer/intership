class EventPolicy
  attr_reader :admin, :event

  def initialize(admin, event)
    @admin = admin
    @event = event
  end

  def destroy?
    admin.superadmin?
  end

  def index?
    is_authorized?
  end

  def pending?
    is_authorized?
  end

  def create?
    is_authorized?
  end

  def edit?
    is_authorized?
  end

  def show?
    is_authorized?
  end

  def update?
    is_authorized?
  end

  def approve?
    is_authorized?
  end

  def decline?
    is_authorized?
  end

  private

  def is_authorized?
    admin.superadmin? || admin.moderator?
  end
end
