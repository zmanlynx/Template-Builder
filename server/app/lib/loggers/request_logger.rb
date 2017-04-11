class RequestLogger
  extend LoggerMixin
  TAIL_NUMBER = 25
  LOG_FILE = File.join(LoggerMixin::LOGS_DIR, 'request.log')

  def self.log(request_ip, request_parameters, response_text, status = true)
    append_text =<<TEXT
Дата: #{Time.now.strftime("%d %h %Y")}
Время: #{Time.now.strftime("%H:%M:%S")}
----------------------------------------------------------
  IP адрес запроса: #{request_ip}
  Тело запроса: #{request_parameters}
  Отправлен ответ:
**********************************************************
#{response_text}
**********************************************************
----------------------------------------------------------
Статус запроса: #{status ? "Успех" : "Отклонен" }


TEXT
    append(append_text)
  end
end
