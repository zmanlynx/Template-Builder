class PageManager

  ITEMS_PER_PAGE = 20

  attr_reader :total_pages, :current_page

  def initialize(template_entities)
    @template_entities = template_entities
    @total_pages = @template_entities.size / ITEMS_PER_PAGE
    @total_pages += 1 if (@template_entities.size % ITEMS_PER_PAGE) > 0
  end

  def select_page(number_of_page)
    number_of_page = number_of_page.to_i
    number_of_page = 1 if number_of_page <= 0
    number_of_page = @total_pages if number_of_page > @total_pages
    @template_entities.unshift(nil)
    start = number_of_page * ITEMS_PER_PAGE - ITEMS_PER_PAGE + 1
    finish = ITEMS_PER_PAGE * number_of_page
    elements = @template_entities[start..finish]
    @template_entities.shift
    @current_page = number_of_page
    elements.each  { | template_entity | template_entity.read }
    elements
  end

  def self.sort(template_entities)
    template_entities.sort_by! { | entity | entity.channel }
  end

end
