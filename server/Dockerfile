FROM ruby:2.3.3-alpine

ENV MSGBUILDER Server
ENV HOME /root
ENV SERVER_PATH $HOME/template_builder/server

RUN apk add --no-cache --virtual mc
RUN apk add --no-cache alpine-sdk git
RUN	mkdir -p $SERVER_PATH

COPY ./app       $SERVER_PATH/app
COPY ./tasks     $SERVER_PATH/tasks
COPY ./app.rb    $SERVER_PATH/app.rb
COPY ./config.rb $SERVER_PATH/config.rb
COPY ./config.ru $SERVER_PATH/config.ru
COPY ./Gemfile   $SERVER_PATH/Gemfile
COPY ./Rakefile  $SERVER_PATH/Rakefile
COPY ./run.sh    $SERVER_PATH/run.sh

RUN cd $SERVER_PATH \
    && gem install bundler \
    && bundle
RUN chmod +x $SERVER_PATH/run.sh

CMD cd $SERVER_PATH && rake seeds:generate && ./run.sh