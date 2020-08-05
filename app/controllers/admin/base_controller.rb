class Admin::BaseController < ApplicationController
  include Pundit

  rescue_from Pundit::NotAuthorizedError,
              with: :redirect_to_index

  def redirect_to_index
    redirect_to admin_events_path, notice: t('events.notice.no_access')
  end

  def pundit_user
    current_admin
  end

  def is_authorized
    authorize Event
  end

  def is_superadmin
    authorize Admin
  end
end
