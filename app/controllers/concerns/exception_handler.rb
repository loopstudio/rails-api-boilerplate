module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render_standard_error
    rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
    rescue_from ActionView::Template::Error, with: :handle_template_error
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

    before_action :set_raven_context
  end

  def render_errors(error_messages, status)
    error_messages = [error_messages] unless error_messages.is_a?(Array)
    render json: { errors: error_messages }, status: status
  end

  def render_attributes_errors(error_messages)
    render json: { attributes_errors: error_messages }, status: :bad_request
  end

  def render_standard_error(exception)
    raise exception if Rails.env.test?

    logger.error(exception)

    render_errors(I18n.t('errors.server'), :internal_server_error)
  end

  def render_parameter_missing(exception)
    render_errors(I18n.t('errors.missing_param', param: exception.param.to_s), :bad_request)
  end

  def handle_template_error(exception)
    cause = exception.cause
    if cause.is_a?(ActiveRecord::RecordNotFound)
      render_record_not_found(cause)
    else
      render_standard_error(cause)
    end
  end

  def render_record_not_found(exception)
    render_errors(I18n.t('errors.record_not_found', exception.model), :not_found)
  end

  def handle_record_invalid(exception)
    errors = exception.record.errors.messages
    render_attributes_errors(errors)
  end

  def set_raven_context
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    return if current_user.nil?

    Raven.user_context(id: current_user.id, email: current_user.email)
  end
end
