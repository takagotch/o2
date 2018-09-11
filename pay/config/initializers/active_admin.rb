ActiveAdmin.setup do |config|
  config.site_title = ""

  config.authentication_method = "authenticate_admin_user!"

  config.logout_link_path = :destroy_admin_user_session_path
  
  config.batch_actions = true

  config.localize_format = :long

  # config.include_default_association_filters = true
  #
end

