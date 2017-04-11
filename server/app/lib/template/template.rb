require_relative 'adapters/file_system'
class Template
  ADAPTER = FileSystemAdapter
  ADAPTER.init

  CHANNEL_KEY  = 'channel'
  LANGUAGE_KEY = 'language'
  TYPE_KEY     = 'type'
  SEPARATOR    = '.'
  DESCRIPTION_KEY = 'description'
  ATTRIBUTES_KEY = 'attributes'
  MESSAGE_KEY    = 'message'
  FORMATS_KEY    = 'formats'
  ADDITIONAL_FIELDS = []
  DATA_FORMATS = []

  attr_accessor :channel, :type, :language, :description
  attr_reader :content, :filename, :attributes, :parsed_content

  def initialize(template_params)
    template_params.raise_if_missing_keys(API_ArgumentMissing, CHANNEL_KEY, TYPE_KEY, LANGUAGE_KEY)
    template_params.raise_if_empty_keys(API_ArgumentEmpty, CHANNEL_KEY, TYPE_KEY, LANGUAGE_KEY)
    @channel    = template_params[CHANNEL_KEY].strip.upcase
    @type       = template_params[TYPE_KEY].strip.upcase
    @language   = template_params[LANGUAGE_KEY].strip.upcase
    @content    = {DESCRIPTION_KEY => '', FORMATS_KEY => {}}
    @description = @content[DESCRIPTION_KEY]
    @attributes = template_params[ATTRIBUTES_KEY].is_a?(Hash) ? template_params[ATTRIBUTES_KEY] : {}
    @filename   = @type + SEPARATOR + @language + SEPARATOR + @channel
  end

  def self.all
    ADAPTER.all
  end

  def self.find(filename)
    ADAPTER.find(filename.to_s.upcase)
  end

  def self.update(old_template_entity, new_template_entity)
    ADAPTER.update(old_template_entity, new_template_entity)
  end

  def save
    ADAPTER.save(self)
  end

  def exist?
    ADAPTER.exist?(self)
  end

  def delete
    ADAPTER.delete(self)
  end

  def read
    ADAPTER.read(self)
  end

  def self.respond_to_json(request_params)
    channel_class = get_channel(request_params[CHANNEL_KEY])
    template_entity = channel_class.new(request_params)
    template_entity.read
    template_entity.response
  end

  def self.create(template_params)
    channel_class = get_channel(template_params[CHANNEL_KEY])
    template_entity = channel_class.new(template_params)
    template_entity.build_content(template_params)
    template_entity
  end

  def build_content(template_params)
    new_content = {DESCRIPTION_KEY => template_params[DESCRIPTION_KEY].to_s, FORMATS_KEY => {} }
    current_class::ADDITIONAL_FIELDS.each do |field|
      new_content[field] = template_params[field].to_s
    end
    current_class::DATA_FORMATS.each do |data_format|
      new_content[FORMATS_KEY][data_format] = template_params[FORMATS_KEY][data_format].to_s
    end
    @description = new_content[DESCRIPTION_KEY]
    @content = new_content
  end

  def parse
    @parsed_content = content.dup
    parse_additional_fields
    parse_data_formats
    @parsed_content
  end

  def parse_additional_fields
    current_class::ADDITIONAL_FIELDS.each do |key|
      @parsed_content[key] = Parser.scan(content[key], attributes)
    end
  end

  def parse_data_formats
    current_class::DATA_FORMATS.each do |data_format|
      unless @content[FORMATS_KEY].key?(data_format)
        raise ErrorFactory.create(ContentWrongFormat, data_format)
      end
      @parsed_content[FORMATS_KEY][data_format] = Parser.scan(content[FORMATS_KEY][data_format], attributes)
    end
  end

  def self.build_by_filename(filename)
    arguments = match_arguments(filename)
    channel_class = get_channel(arguments[CHANNEL_KEY])
    channel_class.new(arguments)
  end

  def self.match_arguments(filename)
    match_data = filename.match(/^(\w+)\.(\w+)\.(\w+)$/)
    raise ErrorFactory.create(WrongFilename, filename) if match_data.nil?
    {
        CHANNEL_KEY   => match_data[3],
        LANGUAGE_KEY  => match_data[2],
        TYPE_KEY      => match_data[1]
    }
  end

  def self.get_channel(class_name)
    channel_classes = Template.subclasses
    index = channel_classes.find_index do |subclass|
      subclass.name.match(/^#{class_name}$/i)
    end
    raise ErrorFactory.create(ChannelNotFound, class_name) if index.nil?
    channel_classes[index]
  end

  private

  def current_class
    self.class
  end
end
