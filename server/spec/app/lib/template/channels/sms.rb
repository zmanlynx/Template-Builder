describe SMS do
  it {expect(SMS).to be < Template}

  context 'отвечает на API' do
    let(:PHONE_NUMBER_KEY) {'phone_number'}


    it 'проверяет специфичные для канала ключи в параметрах, парсит содержимое возвращает результат' do
      result =  SMS.new({ "channel" => "sms", "type" => "otp", "language" => "ru", "attributes" => { "phone_number" => "996", "CODE" => "1111" } })

      subject.read

      expect(subject.response).to eql(<<~TEXT
      {
        "channel": "sms",
        "phone_number": "996",
        "message": "Код подтверждения - 1111. Никому не сообщайте этот код."
      }
      TEXT
                                  )
    end
  end
end