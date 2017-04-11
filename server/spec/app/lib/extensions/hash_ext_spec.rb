describe Hash do
  context 'в стандартный класс Hash' do
    context 'добавляется метод serialize_to_json' do
      it 'возвращает JSON' do
        expect({'A'=>'B'}.serialize_to_json).to eql("{\n  \"A\": \"B\"\n}")
      end
    end

    context 'добавляется метод raise_if_missing_keys' do
      let(:expected_keys) {['KEY1', 'KEY2']}
      it 'возникает исключение при остутствии заданных ключей' do
        expect do
          {'KEY1'=>''}.raise_if_missing_keys(StandardError, expected_keys)
        end.to raise_error(StandardError)
      end
    end

    context 'добавляется метод raise_if_empty_keys' do
      let(:expected_keys) {['KEY1', 'KEY2']}
      it 'возникает исключение при остутствии заданных ключей' do
        expect do
          {'KEY1'=>'', 'KEY2'=>''}.raise_if_empty_keys(StandardError, expected_keys)
        end.to raise_error(StandardError)
      end
    end

  end
end