class Email < Template
  DATA_FORMATS = %w(text html)
  ADDITIONAL_FIELDS = %w(subject)

  SUBJECT_KEY = 'subject'
  BODY_KEY    = 'body'

  EMAIL_KEY   = 'email'

  def response
    attributes.raise_if_missing_keys(API_ArgumentMissing, EMAIL_KEY)
    attributes.raise_if_empty_keys(API_ArgumentEmpty, EMAIL_KEY)
    parse
    {
        CHANNEL_KEY      => channel.downcase,
        EMAIL_KEY        => attributes[EMAIL_KEY],
        MESSAGE_KEY      => {
            SUBJECT_KEY => parsed_content[ADDITIONAL_FIELDS.first],
            BODY_KEY    => parsed_content[FORMATS_KEY]
        }
    }.serialize_to_json
  end
end
