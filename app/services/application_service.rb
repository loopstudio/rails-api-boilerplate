class ApplicationService
  class << self
    def call(*args, &block)
      service = new(*args, &block)
      service.call
      service
    end
  end

  attr_reader :result

  def call; end

  def success?
    errors.empty?
  end

  def errors
    @errors ||= []
  end
end
