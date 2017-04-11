describe Filter do

  let(:template1) { double(:channel => 'SMS', :type=>'OTP', :language=>'RU', :description=>'Проверка', :description= => nil) }
  let(:template2) { double(:channel => 'Email', :type=>'WELCOME', :language=>'RU', :description=>'Приветствие', :description= => nil) }

  before do
    allow(template1).to receive(:read).and_return(template1.description)
    allow(template2).to receive(:read).and_return(template2.description)
  end
  it 'фильтрует шалоны класса Template по заданной строке фильтра' do
    result = Filter.filter([template1, template2], 'вер')
    expect(result).to eql([template1])
  end

  it 'заменяет описание шаблона на <span class="highlight">найденная строка<span>' do
    Filter.filter([template1, template2], 'вер')
    expect(template1).to have_received(:description=).with('Про<span class="highlight">вер</span>ка')
  end
end