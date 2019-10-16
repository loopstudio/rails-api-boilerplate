module ActAsApiRequest
  extend ActiveSupport::Concern

  included do
    before_action :skip_session_storage
    before_action :check_json_request
  end

  def check_json_request
    return if request_body.empty?
    return if request.content_type&.match?(/json/)

    render json: { error: I18n.t('errors.invalid_content_type') }, status: :bad_request
  end

  def skip_session_storage
    request.session_options[:skip] = true
  end

  private

  def request_body
    request.body.read
  end
end
