module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render_standard_error
    rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  end

  def render_errors(error_messages, status)
    error_messages = [error_messages] unless error_messages.is_a?(Array)
    render json: { errors: error_messages }, status: status
  end

  def render_standard_error(exception)
    raise exception if Rails.env.test?

    logger.error(exception)

    render_errors(I18n.t('errors.server'), :internal_server_error)
  end

  def render_parameter_missing(exception)
    render_errors(I18n.t('errors.missing_param', param: exception.param.to_s), :bad_request)
  end

  def render_record_not_found
    render_errors(I18n.t('errors.record_not_found'), :not_found)
  end

  def render_record_invalid(exception)
    errors = exception.record.errors.full_messages
    render_errors(errors, :unprocessable_entity)
  end
end
