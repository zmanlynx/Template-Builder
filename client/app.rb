require_relative 'config'

app = TemplateBuilderClient.new( ARGV )
app.send_json