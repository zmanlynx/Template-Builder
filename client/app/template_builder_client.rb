class TemplateBuilderClient
  attr_reader :url

  def initialize( args )
    @json = args[0].to_s.gsub("'", '"')
    @url = "#{ SERVER_HOSTNAME }:#{ SERVER_PORT }/build"
  end

  def send_json
    uri = URI.parse(@url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.read_timeout = SERVER_TIMEOUT
    request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
    request.body = @json
    response = http.request(request)
    puts "Ответ от: #{ @url }:", response.body
    response.body
  rescue Errno::ECONNREFUSED => e
    puts "Ошибка: Сервер не отвечает - #{ @url }"
  rescue Net::ReadTimeout => e
    puts "Ошибка: Время ожидания #{ SERVER_TIMEOUT } секунды истекло"
  end

end