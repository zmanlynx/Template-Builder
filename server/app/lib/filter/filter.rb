class Filter

  HIGHLIGHT_CSS_CLASS = 'highlight'

  def self.filter(template_entities, match_string)
    template_entities.each  { | template_entity | template_entity.read }
    template_entities.select! do | template_entity |
      change_for_match(template_entity, match_string)
    end
    template_entities
  end

  private

  def self.change_for_match(template_entity, match_string)
    channel = replace_text(template_entity.channel, match_string)
    template_entity.channel = channel if channel
    type = replace_text(template_entity.type, match_string)
    template_entity.type = type if type
    language = replace_text(template_entity.language, match_string)
    template_entity.language = language if language
    description = replace_text(template_entity.description, match_string)
    template_entity.description = description if description
    channel || type || language || description ? true : false
  end

  def self.replace_text(text, match_string)
    text_result = ''
    scan_results = text.scan(/#{match_string}/i)
    return nil if scan_results.empty?
    scan_results.each do |match_found|
      text_result = text.gsub(match_found, highlight_text(match_found))
    end
    text_result
  end

  def self.highlight_text(text)
    "<span class=\"#{ HIGHLIGHT_CSS_CLASS }\">#{text}</span>"
  end

end
