DeviseTokenAuth.setup do |config|
  config.change_headers_on_each_request = false

  config.remove_tokens_after_password_reset = true

  config.token_lifespan = 5.weeks

  # TODO: decide if we will require current password when updating
  # By default sending current password is not needed for the password update.
  # Uncomment to enforce current_password param to be checked before all
  # attribute updates. Set it to :password if you want it to be checked only if
  # password is updated.
  # config.check_current_password_before_update = :attributes
end
