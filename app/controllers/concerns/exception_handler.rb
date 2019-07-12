module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError do |e|
      raise e if Rails.env.test?

      logger.error(e)

      render_errors(I18n.t('errors.server'), :internal_server_error)
    end

    rescue_from ActionController::ParameterMissing do |e|
      render_errors(I18n.t('errors.missing_param', param: e.param.to_s), :bad_request)
    end

    rescue_from(ActiveRecord::RecordNotFound) { render_errors(I18n.t('errors.record_not_found'), :not_found) }

    rescue_from ActiveRecord::RecordInvalid do |e|
      errors = e.record.errors.full_messages
      render_errors(errors, :unprocessable_entity)
    end

    rescue_from Pundit::NotAuthorizedError do
      render_errors(I18n.t('errors.authorization.unauthorized'), :unauthorized)
    end

    rescue_from(InvalidCredentialsError) { |e| render_errors([e.message], :unauthorized) }

    rescue_from(InvalidTokenError) { |e| render_errors([e.message], :unauthorized) }
  end

  private

  def render_errors(error_messages, status)
    render json: { errors: error_messages }, status: status
  end
end
