class ApplicationError < StandardError
  attr_reader :message
end

class FileNotFound < ApplicationError
  def initialize(filename, e = nil)
    @message = 'Шаблон отсутствует:' + filename
  end
end

class WrongFilename < ApplicationError
  def initialize(filename, e = nil)
    @message = 'Неверное имя файла: ' + filename.to_s
  end
end

class FileAlreadyExists < ApplicationError
  def initialize(filename, e = nil)
    @message = 'Файл уже существует: ' + filename
  end
end

class ContentWrongFormat < ApplicationError
  def initialize(content, e = nil)
    @message = 'Структура контента повреждена: ' + content
  end
end

class API_ArgumentMissing < ApplicationError
  def initialize(arguments, e = nil)
    @message = 'Отсутствуют аргументы в поле attributes: ' + arguments.to_line
  end
end

class API_ArgumentEmpty < ApplicationError
  def initialize(arguments, e = nil)
    @message = 'Пустые значения для аргументов в поле attributes: ' + arguments.to_line
  end
end

class ArgumentMissing < ApplicationError
  def initialize(arguments, e = nil)
    @message = 'Отсутствуют аргументы в : ' + arguments.to_line
  end
end

class ArgumentEmpty < ApplicationError
  def initialize(arguments, e = nil)
    @message = 'Пустые значения для аргументов: ' + arguments.to_line
  end
end

class ChannelNotFound < ApplicationError
  def initialize(channel, e = nil)
    @message = 'Требуемый канал шаблонов отсутствует: ' + channel.to_s
  end
end

class ParserKeyNotFound < ApplicationError
  def initialize(key, e = nil)
    @message = 'Ошибка парсинга, отсутствует значние в поле attributes для: ' + key.to_s
  end
end

class ChannelBuildFileContentError < ApplicationError
  def initialize(parameters, e = nil)
    @message = 'Ошибка создания содержимого файла по следующим параметрам: ' + parameters.to_s
  end
end
