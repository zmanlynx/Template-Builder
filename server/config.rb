APP_NAME     = 'Template Builder'
APP_VERSION  = '1.0'

AVAILABLE_LANGUAGES = %w(RU EN KZ)

ROOT_DIR      = File.expand_path(__dir__)
APP_DIR       = File.join(ROOT_DIR, 'app')
LIB_DIR       = File.join(APP_DIR, 'lib')
VIEWS_DIR     = File.join(APP_DIR, 'views')

require 'rack'
require 'rack/app'
require 'rack/app/front_end'
require 'json'

require_relative 'app/lib/extensions/class_ext'
require_relative 'app/lib/extensions/hash_ext'
require_relative 'app/lib/extensions/array_ext'

require_relative 'app/lib/errors/error_classes'
require_relative 'app/lib/errors/error_factory'

require_relative 'app/lib/loggers/logger_mixin'
require_relative 'app/lib/loggers/error_logger'
require_relative 'app/lib/loggers/request_logger'

require_relative 'app/lib/parser/parser'
require_relative 'app/lib/page-manager/page_manager'
Dir[File.join(LIB_DIR, 'template', 'adapters', '*.rb')].each do |file|
  require file
end
require_relative 'app/lib/template/template'
Dir[File.join(LIB_DIR, 'template', 'channels', '*.rb')].each do |file|
  require file
end
require_relative 'app/lib/filter/filter'

require_relative 'app/web_interface'
require_relative 'app/api_responder'
require_relative 'app'
