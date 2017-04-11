class ErrorFactory
  def self.create(error_class, error_attributes, top_exception = nil)
    error_class.new(error_attributes, top_exception)
  end
end
