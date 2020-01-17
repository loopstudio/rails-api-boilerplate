module RequestHelpers
  def json
    raise 'Response is nil. Are you sure you made a request?' unless response

    JSON.parse(response.body, symbolize_names: true)
  end

  def auth_headers
    @auth_headers ||= user.create_new_auth_token
  end
end
