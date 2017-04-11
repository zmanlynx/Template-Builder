describe Parser do

  subject { Parser }

  context 'парсинг' do
    it 'scan ищет [[ name ]] и заменяет его значением из хэша' do
      text = 'Hello [[ name ]]'
      value = {'name'=>'John'}
      expect(subject.scan(text, value )).to eql('Hello John')
    end

    it 'scan выбрасывает ParserKeyNotFound если отсутствуют значения' do
      expect { subject.scan('Hello [[ name ]]', {}) }.to raise_error(ParserKeyNotFound)
    end
  end

end