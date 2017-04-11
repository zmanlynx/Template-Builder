FROM ruby:2.3.3-alpine

ENV MSGBUILDER Client
ENV HOME /root
ENV CLIENT_PATH $HOME/template_builder/client

RUN apk add --no-cache --virtual mc
RUN apk add --no-cache alpine-sdk git
RUN	mkdir -p $CLIENT_PATH

COPY ./app       $CLIENT_PATH/app
COPY ./app.rb    $CLIENT_PATH/app.rb
COPY ./config.rb $CLIENT_PATH/config.rb
COPY ./Gemfile   $CLIENT_PATH/Gemfile
COPY ./run.sh    $CLIENT_PATH/run.sh

RUN cd $CLIENT_PATH \
    && gem install bundler \
    && bundle
RUN chmod +x $CLIENT_PATH/run.sh

CMD cd $CLIENT_PATH && ./run.sh help || sh
