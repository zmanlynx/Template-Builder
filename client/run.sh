#! /bin/sh
echo
if [ "$1" = "help" ]; then
  echo "  Использование: ./run.sh \"JSON\""
  echo "    JSON пример: \"{ 'channel':'sms', 'type':'otp', 'language':'ru', 'attributes':{ 'phone_number':'+996777555777', 'CODE':'1111' } }\""
  echo
  exit 1
fi

if [ "$1" = "example" ]; then
  echo "Запуск примера с аргументом:"
  echo "{ 'channel':'sms', 'type':'otp', 'language':'ru', 'attributes':{ 'phone_number':'+996777555777', 'CODE':'1111' } }"
  echo
  ruby ./app.rb "{ 'channel':'sms', 'type':'otp', 'language':'ru', 'attributes':{ 'phone_number':'+996777555777', 'CODE':'1111' } }"
  echo
  exit 1
fi

ruby ./app.rb "$1"
echo

