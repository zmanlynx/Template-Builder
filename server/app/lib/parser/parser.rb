class Parser

  MATCH_REGEX = /(\[\[([A-Za-zА-Яа-я0-9_\-:\s]+)\]\])/

  def self.scan(text, keys_and_values)
    text = text.dup
    match = text.scan(MATCH_REGEX)
    match.each do |array|
      replace_text = array.first
      match_key = array.last.strip
      unless keys_and_values.key?(match_key)
        raise ErrorFactory.create(ParserKeyNotFound, match_key)
      end
      text.gsub!(replace_text, keys_and_values[match_key])
    end
    text
  end

end
