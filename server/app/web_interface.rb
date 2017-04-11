module WebInterface
  FILTER_KEY = 'filter_string'

  def index_page
    @channels = get_channels
    template_entities = PageManager.sort(Template.all)
    if template_entities.empty?
      return render(erb('nothing_to_show'))
    end
    @page_manager = PageManager.new(template_entities)
    page_entities = @page_manager.select_page(params['page'])
    @template_entities = page_entities
    render erb('index')
  end

  def filter_page
    filter_string = request.params[FILTER_KEY].to_s.strip
    template_entities = PageManager.sort(Template.all)
    @template_entities = Filter.filter(template_entities, filter_string)
    if @template_entities.empty?
      erb_read('nothing_to_show')
    else
      erb_read('filter')
    end
  end

  def new_template_page
    @channel_class = Template.get_channel(params['id'])
    @info_message = 'Создание шаблона: ' + @channel_class.name
    render erb('new')
  end

  def edit_page
    filename = params['id']
    @info_message = 'Режим редактирования'
    @template_entity = Template.find(filename)
    @template_entity.read
    render erb('edit')
  end

  def show_page
    filename = params['id']
    @info_message = 'Режим просмотра'
    @template_entity = Template.find(filename)
    @template_entity.read
    render erb('show')
  end

  def logs_page
    @info_message = 'Логи запросов/ошибок'
    @current_tab = params['current_tab']
    @current_tab ='requests' if @current_tab.to_s.strip.empty?
    @error_lines = params['errlines']
    @request_lines = params['reqlines']
    @error_lines ||= ErrorLogger::TAIL_NUMBER
    @request_lines   ||= RequestLogger::TAIL_NUMBER
    @error_content   = ErrorLogger.tail(@error_lines)
    @request_content = RequestLogger.tail(@request_lines)
    render erb('logs')
  end

  def test_page
    filename = params['id']
    @info_message = 'Режим тестирования'
    @template_entity = Template.find(filename)
    @template_entity.read
    render erb('test')
  end

  def create_action
    template_entity = Template.create(request.params)
    template_entity.save
    redirect_to "/#{template_entity.filename}/show"
  end

  def update_action
    old_template_entity = Template.find(request.params['old_filename'])
    new_template_entity = Template.create(request.params)
    Template.update(old_template_entity, new_template_entity)
    redirect_to "/#{new_template_entity.filename}/show"
  end

  def delete_action
    channel_entity = Template.find(request.params['id'])
    channel_entity.delete
    "Шаблон #{channel_entity.type + SEPARATOR + channel_entity.language} для канала: #{channel_entity.channel}\nУдалён"
  rescue
    'Ошибка удаления'
  end

  def logs_clear_action
    Object.const_get(request.params['logger_class']).clear
  end

  private

  def get_channels
    Template.subclasses.map { |channel_class| channel_class.name }.sort
  end

  def erb(erb_filename)
    File.join(VIEWS_DIR, erb_filename + '.html.erb')
  end

  def erb_read(erb_filename)
    ERB.new(File.read(erb(erb_filename))).result(binding)
  end

  def isolate_errors(method)
    send(method)
  rescue StandardError => e
    ErrorLogger.log(e.message + "\n" + e.backtrace.first)
    render erb('error')
  end

end
