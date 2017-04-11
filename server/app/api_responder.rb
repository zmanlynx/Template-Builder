class ApiResponder
  def initialize(request)
    @request = request
    @ip = request.env['REMOTE_ADDR']
  end

  def respond_to_json
    request_body = @request.body.read
    parsed_json = JSON.parse(request_body)
    content = Template.respond_to_json(parsed_json)
    RequestLogger.log(@ip, parsed_json, content)
    content
  rescue JSON::ParserError
    log_text = "Ожидается JSON формат. Получено: \n#{request_body}"
    RequestLogger.log(@ip, request_body, log_text, false)
    log_text
  rescue ApplicationError => e
    RequestLogger.log(@ip, parsed_json, e.message, false )
    e.message
  rescue StandardError => e
    ErrorLogger.log(e.message + "\n" + e.backtrace.first)
    'Внутренняя ошибка системы'
  end
end
