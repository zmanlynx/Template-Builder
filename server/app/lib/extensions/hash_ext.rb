class Hash
  def serialize_to_json
    JSON.pretty_generate(self)
  end

  def raise_if_missing_keys(error_class, *keys)
    missing_keys = []
    keys.each do |key|
      missing_keys << key unless key?(key)
    end
    raise error_class.new(missing_keys) unless missing_keys.empty?
    nil
  end

  def raise_if_empty_keys(error_class, *keys)
    result = []
    keys.each do |key|
      result << key if self[key].to_s.empty?
    end
    raise error_class.new(result) unless result.empty?
    nil
  end

end
