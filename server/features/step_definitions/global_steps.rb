require 'pry'
# When(/^пользователь находится на главной странице$/) do

When(/^переходим на вторую страницу пагинации$/) do
  find(:xpath, '//*[@id="content_body"]/div[4]/ul/li[3]/a').click
end

When(/^кликаек на шаблоне "([^"]*)"$/) do |template_id|
  page.find_by_id(template_id).click
  sleep(1)
end

When(/^должен увидеть текст "([^"]*)"$/) do |arg1|
  page.assert_text(arg1)
  sleep(1)
end

When(/^кликаю кнопку 'Назад' "([^"]*)"$/) do |button_id|
  find_by_id(button_id).click
end

#template creation

When(/^кликаек на ссылку 'Создать шаблон'$/) do
  find(:xpath, "//*[@id='navbar']/ul[1]/li/a").click
  sleep(2)
end

When(/^затем кликаем на ссылку "([^"]*)"$/) do |new_template_link|
  find(:xpath, '//*[@id="navbar"]/ul[1]/li/ul/li[1]/a').click
  # find(new_template_link).click
  sleep(1)
  # click_link(new_template_link)
  # sleep(2)
end

When(/^выбираю язык "([^"]*)" из списка "([^"]*)"$/) do |value, select_box|
  # option = find_by_id(select_box).find("option[value = '#{value}']").select_option.text
  select('EN', from: 'sel1')
  sleep(2)
end

When(/^заполняю поля формы следующими значениями$/) do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  expectations = table.raw
  expectations.each do | field, value|
    fill_in field, with: value
  end
  sleep(1)
end

When(/^кликаю по вкладке "([^"]*)"$/) do |tabpanel|
puts tabpanel
  click_link tabpanel
end

When(/^ввожу данные "([^"]*)" в поле "([^"]*)"$/) do |value, field|
  fill_in field, with: value
  sleep(2)
end

When(/^затем кликаю кнопку "([^"]*)"$/) do |btn|
  click_button btn
end

When(/^вижу на странице текст "([^"]*)"$/) do |arg1|
  page.assert_text(arg1)
  sleep(1)
end

# /template_creation

# template_deletion

When(/^находит шаблон "([^"]*)"$/) do |template_id|
  find_by_id(template_id)
  sleep(1)
end

When(/^кликаек на иконку удалить "([^"]*)" рядом с шаблоном$/) do |delete_link|
  find_by_id(delete_link).click
end

When(/^видит модальное окно с вопросом "([^"]*)"$/) do |confirm_question|
  page.assert_text(confirm_question)
end

Допустим(/^подтверждает удаления и нажимает на кнопку 'Удалить' "([^"]*)"$/) do |delete_btn|
  find_by_id(delete_btn).click
end

When(/^остается на гланой странице и не видит больше шаблон "([^"]*)"$/) do |template_id|
  page.assert_no_text(template_id)
  sleep(2)
end








