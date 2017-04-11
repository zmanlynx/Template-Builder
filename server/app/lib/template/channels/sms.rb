class SMS < Template
  DATA_FORMATS = %w(text)

  PHONE_NUMBER_KEY = 'phone_number'

  def response
    attributes.raise_if_missing_keys(API_ArgumentMissing, PHONE_NUMBER_KEY)
    attributes.raise_if_empty_keys(API_ArgumentEmpty, PHONE_NUMBER_KEY)
    parse
    {
        CHANNEL_KEY      => channel.downcase,
        PHONE_NUMBER_KEY => attributes[PHONE_NUMBER_KEY],
        MESSAGE_KEY      => parsed_content[FORMATS_KEY][DATA_FORMATS[0]]
    }.serialize_to_json
  end
end
