class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception, unless: -> { request.format.json? }
end
