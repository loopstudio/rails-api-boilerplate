module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :handle_standard_error
    rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
    rescue_from ActionView::Template::Error, with: :handle_template_error
    rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
    rescue_from Pagy::OverflowError, with: :render_page_overflow

    before_action :set_sentry_context
  end

  private

  def render_errors(error_messages, status)
    error_messages = Array(error_messages)

    render json: { errors: error_messages }, status: status
  end

  def render_attributes_errors(error_messages)
    render json: { attributes_errors: error_messages }, status: :unprocessable_entity
  end

  def render_parameter_missing(exception)
    render_errors(I18n.t('errors.missing_param', param: exception.param.to_s), :bad_request)
  end

  def render_record_not_found(exception)
    render_errors(I18n.t('errors.record_not_found', model: exception.model), :not_found)
  end

  def render_record_invalid(exception)
    errors = exception.record.errors.messages

    render_attributes_errors(errors)
  end

  def render_page_overflow
    render_errors(I18n.t('errors.page_overflow'), :unprocessable_entity)
  end

  def handle_standard_error(exception)
    raise exception if Rails.env.test?

    logger.error(exception)
    exception.backtrace.each { |line| logger.error(line) } if Rails.env.development?

    Sentry.capture_exception(exception)

    render_errors(I18n.t('errors.server'), :internal_server_error)
  end

  def handle_template_error(exception)
    cause = exception.cause

    if cause.is_a?(ActiveRecord::RecordNotFound)
      render_record_not_found(cause)
    else
      handle_standard_error(cause)
    end
  end

  def set_sentry_context
    Sentry.set_extras(params: params.to_unsafe_h, url: request.url)
    return if current_user.nil?

    Sentry.set_context('context', { id: current_user.id, email: current_user.email })
  end
end
