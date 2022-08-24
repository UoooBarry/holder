class ApplicationService
  class ParamError < StandardError; end

  def self.call(*args)
    new(*args).call
  end
end
