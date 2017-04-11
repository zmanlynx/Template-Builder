class FileSystemAdapter
  TEMPLATES_DIR = File.join(ROOT_DIR, 'templates')

  def self.init
    %x(`mkdir -p #{TEMPLATES_DIR}`)
  end

  def self.all
    files = Dir.entries(TEMPLATES_DIR).select do |file|
      full_path = File.join(TEMPLATES_DIR, file)
      File.file?(full_path)
    end
    files.sort_by! { |filename| filename }.reverse
    template_entities = []
    files.each do |file|
      begin
        entity = Template.build_by_filename(file)
      rescue
        next
      end
      template_entities << entity
    end
    template_entities
  end

  def self.find(filename)
    if File.exists?(File.join(TEMPLATES_DIR, filename))
      Template.build_by_filename(filename)
    end
  rescue
    nil
  end

  def self.update(old_template_entity, new_template_entity)
    if File.exist?(template_file(old_template_entity.filename))
      if old_template_entity.filename == new_template_entity.filename
        new_template_entity.save
      else
        old_template_entity.delete
        new_template_entity.save
      end
      new_template_entity
    else
      raise ErrorFactory.create(FileNotFound, old_template_entity.filename)
    end
  end

  def self.save(template_entity)
    File.open(template_file(template_entity.filename), 'w') do |file|
      file.write(template_entity.content.serialize_to_json)
    end
    true
  end

  def self.delete(template_entity)
      !!File.delete(template_file(template_entity.filename))
  rescue
    false
  end

  def self.exist?(template_entity)
    File.exist?(template_file(template_entity.filename))
  end

  def self.read(template_entity)
    txt_content = File.read(template_file(template_entity.filename))
    hash_content = JSON.parse(txt_content)
    template_entity.build_content(hash_content)
  rescue
    raise ErrorFactory.create(FileNotFound, template_entity.filename)
  end

  private

  def self.template_file(filename)
    File.join(TEMPLATES_DIR, filename)
  end
end
