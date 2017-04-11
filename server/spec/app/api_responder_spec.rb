describe ApiResponder do

  let(:content) { double }
  let(:request_body) { double(read: '{ "channel":"sms", "type":"otp", "language":"ru", "attributes": { "phone_number":"996", "CODE":"1111" } }') }
  let(:request_env) { { 'REMOTE_ADDR' => '192.168.0.1'} }
  let(:request) { double(body: request_body, env: request_env) }
  before do
    allow(Template).to receive(:respond_to_json).and_return(content)
  end
  subject do
    ApiResponder.new(request)
  end
  it 'вызывается метод respond_to_json у шаблона' do
    expect(subject.respond_to_json).to eql(content)
  end
end