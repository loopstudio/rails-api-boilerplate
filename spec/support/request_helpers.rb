module RequestHelpers
  def json_response(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def auth_headers(user)
    user.create_new_auth_token
  end
end
