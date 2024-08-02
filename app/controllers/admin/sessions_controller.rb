class Admin::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    admin_path
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  private

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end
