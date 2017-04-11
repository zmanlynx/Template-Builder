namespace :seeds do

  desc 'Сгенерировать базовые шаблоны'
  task :generate do
    puts 'Генерация базовых шаблонов:'
    templates = JSON.parse(File.read(File.join(__dir__, 'seeds.json')))
    templates.each_pair do |key, value |
      channel_entity = Template.build_by_filename(key)
      if channel_entity
        channel_entity.build_content(value)
        channel_entity.save
        puts '  создан файл: ' + key
      else
        puts ' не могу создать файл:', key, value, "\n"
      end
    end
  end

  desc 'Удаляет базовые шаблоны'
  task :clear do
    templates = JSON.parse(File.read(File.join(__dir__, 'seeds.json')))
    templates.each_key do |key|
      channel_entity = Template.build_by_filename(key)
      if channel_entity && channel_entity.exist?
        channel_entity.delete
      else
        puts ' неудалось удалить файл:' + key
      end
    end
  end

end
