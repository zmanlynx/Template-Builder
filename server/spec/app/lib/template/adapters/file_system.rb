describe FileSystemAdapter do

  context 'создание папки шаблонов' do
    it 'init создаёт папку для файлов-шаблонов' do
      FileSystemAdapter.init
      expect(Dir.exist?(FileSystemAdapter::TEMPLATES_DIR)).to eql(true)
    end
  end

  context 'обработка файлов-шаблонов' do
    let(:template_instance) { double }
    let(:template_filenames) { ['otp.en.sms', 'debetmoney.ru.email', 'info.en.sms'] }

    before do
      allow(File).to receive(:file?).and_return(true)
      allow(Dir).to receive(:entries).and_return(template_filenames)
      allow(Template).to receive(:build_by_filename).and_return(template_instance)
    end

    it 'создаёт объект Template для каждого файла-шаблона' do
      FileSystemAdapter.all
      expect(Template).to have_received(:build_by_filename).with('otp.en.sms')
      expect(Template).to have_received(:build_by_filename).with('debetmoney.ru.sms')
      expect(Template).to have_received(:build_by_filename).with('info.en.sms')
    end

    it 'возвращает массив из объектов Template' do
      result = FileSystemAdapter.all
      expect(result).to eql([template_instance, template_instance, template_instance])
    end
  end

  context 'чтение данных из файла-шаблона' do
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
    allow(File).to receive(:read).and_return(<<~JSON
{
 "description":"описание",
 "myfield":"одно из специфичных полей"
 "formats":{
   "text":"TEXT CONTENT[[CODE]]"
   }
}
JSON )
    it 'read принимает инстанс канала в качестве аргумента и изменяет контент' do
      FileSystemAdapter.read(subject)
      expect(subject.description).to eql('описание')
      expect(subject.content['myfield']).to eql('одно из специфичных полей')
    end
  end


end