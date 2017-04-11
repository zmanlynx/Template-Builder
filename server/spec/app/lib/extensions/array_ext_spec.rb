describe Array do
  context 'добавляется метод to_line в стандартный класс Array' do
    it 'to_line' do
      expect(['A','B'].to_line).to eql('A, B')
    end
  end
end