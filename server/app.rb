class TemplateBuilderServer < Rack::App
  LAYOUT_FILE = File.join(VIEWS_DIR, 'layout.html.erb')
  PUBLIC_DIR = '/app/public'

  include WebInterface
  apply_extensions :front_end
  serve_files_from PUBLIC_DIR
  layout LAYOUT_FILE

  post '/build' do
    message_builder = ApiResponder.new(request)
    message_builder.respond_to_json
  end

  get '/' do
    isolate_errors(:index_page)
  end

  post '/' do
    filter_page
  end

  get '/new/:id' do
    isolate_errors(:new_template_page)
  end

  post '/create' do
    isolate_errors(:create_action)
  end

  delete '/delete' do
    delete_action
  end

  get '/:id/show' do
    isolate_errors(:show_page)
  end

  get '/:id/edit' do
    isolate_errors(:edit_page)
  end

  post '/update' do
    isolate_errors(:update_action)
  end

  get '/:id/test' do
    isolate_errors(:test_page)
  end

  get '/logs' do
    logs_page
  end

  delete '/logs' do
    logs_clear_action
  end

end
