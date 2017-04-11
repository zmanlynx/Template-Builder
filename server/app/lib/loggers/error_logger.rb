class ErrorLogger
  extend LoggerMixin
  TAIL_NUMBER = 12
  LOG_FILE = File.join(LoggerMixin::LOGS_DIR, 'application-errors.log')

  def self.log(content)
    append_text =<<TEXT
Дата: #{Time.now.strftime("%d %h %Y")}
Время: #{Time.now.strftime("%H:%M:%S")}
Тип: Ошибка приложения
------------------------------------------------------------------------
Сообщение:
#{content}
------------------------------------------------------------------------

TEXT
  append(append_text)
  end
end
