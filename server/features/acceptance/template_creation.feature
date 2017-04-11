# language: ru

Функционал: Создания шаблоны для отправки сообщения по Email.
            

Сценарий: Успешного создания шаблона для канала - Email,
          с именем файла testemail.en.email 

  Допустим пользователь находится на главной странице
  И кликаек на ссылку 'Создать шаблон'
  И затем кликаем на ссылку "Email"
  И переходим на страницу создания шаблона '/new/Email'
  И выбираю язык "EN" из списка "sel1"
  И заполняю поля формы следующими значениями
    | template-type         | ATestEmail            |
    | template-description  | Test Description      |
    | subject               | Test Subject          |
    | template-text-body    | Test Text goes here   |
  И кликаю по вкладке "html-tablink"  
  И ввожу данные "Test HTML goes here" в поле "template-html-body"
  И затем кликаю кнопку "save-btn"
  И перехожу на страницу отображения шаблона "http://127.0.0.1:9393/atestemail.en.email/show"
  И вижу на странице текст "Test Subject"
