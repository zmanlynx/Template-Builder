describe Template do

  context 'инициализация' do
    subject do
      params = {
          Template::CHANNEL_KEY => 'sms',
          Template::TYPE_KEY => 'otp',
          Template::LANGUAGE_KEY => 'ru'
      }
      Template.new(params)
    end

    it 'возвращает объект SMS' do
      result = Template.build_by_filename('otp.ru.sms')
      expect(result).to be_an_instance_of(SMS)
    end

    context 'проверка значений полей' do
      [
          [:channel, 'SMS'],
          [:type, 'OTP'],
          [:language, 'RU'],
          [:filename, 'OTP.RU.SMS'],
          [:content, {Template::DESCRIPTION_KEY => '', Template::FORMATS_KEY => {}}],
          [:description, '']
      ].each do |field, value|

        it "поле #{field} должно иметь значение #{value}" do
          result = Template.build_by_filename('otp.ru.sms')
          expect(result.send(field)).to eql(value)
        end

      end
    end

  end

  context 'match_arguments принимает параметры формата TYPE.LANGUAGE.CHANNEL ' do
    it 'выкинет WrongFilename при несоответствию формату' do
      expect{ Template.match_arguments('otp.ru.') }.to raise_error(WrongFilename)
    end

    it 'возвращает результат' do
      result = Template.match_arguments('otp.ru.sms')
      expect(result).to eql({ Template::CHANNEL_KEY => 'sms',
                              Template::LANGUAGE_KEY => 'ru',
                              Template::TYPE_KEY => 'otp'})
    end
  end

  context 'get_channel возвращает класс канала' do
    class TestChannel < Template; end

    before do
      allow(Template).to receive(:subclasses).and_return([TestChannel])
    end

    it 'вернёт SMS' do
      expect(Template.get_channel('testchannel')).to eql(TestChannel)
    end

    it 'возникнет исключение ChannelNotFound если заданный канал отсутствует' do
      expect{Template.get_channel('undefinedchannel')}.to raise_error(ChannelNotFound)
    end
  end

  context 'respond_to_json возвращает JSON после парсинга для шаблона' do
    #it 'принимает Hash '
  end

  context 'create возвращает созданный объект шаблона' do
    #it 'вернёт объект '
  end

  context 'методы инстанса TestChannel наследуемые от Template' do

    class TestChannel < Template
      ADDITIONAL_FIELDS = %w(myfield)
      DATA_FORMATS = %w(text html)
    end
    subject do
      instance_params = {
          Template::CHANNEL_KEY => 'testchannel',
          Template::TYPE_KEY => 'type',
          Template::LANGUAGE_KEY => 'language'
      }
      TestChannel.new(instance_params)
    end
    let(:content_params) do
      {
          Template::DESCRIPTION_KEY => 'описание',
          'myfield' => 'testisok',
          Template::FORMATS_KEY => {
              'text' => 'TEXT TEMPLATE [[name]]',
              'html' => 'HTML CONTENT [[content]]'
          }
      }
    end
    let(:default_content) do
      { Template::DESCRIPTION_KEY => '', Template::FORMATS_KEY => {} }
    end
    it '#build_content изменяет content и description инстанса шаблона' do
      expect(subject.description).to eql('')
      expect(subject.content).to eql(default_content)

      subject.build_content(content_params)

      expect(subject.description).to eql('описание')
      expect(subject.content).to eql(content_params)
    end


  end
  #
  # context 'create возвращает инстанс класса канала' do
  #   class Whatsapp < Template; end
  # end





end