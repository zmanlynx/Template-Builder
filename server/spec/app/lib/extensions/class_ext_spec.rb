describe Class do
  context 'добавляется метод subclasses в стандартный класс Class' do
    class TestParent; end
    class TestChild1 < TestParent; end
    class TestChild2 < TestParent; end
    it 'subclasses' do
      expect(TestParent.subclasses).to eql([TestChild1, TestChild2])
    end
  end
end