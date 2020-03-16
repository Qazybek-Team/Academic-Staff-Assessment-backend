FROM ruby:2.6

WORKDIR /app

RUN gem install bundler -v 2.1.4

ADD Gemfile /app/
ADD Gemfile.lock /app/

RUN bundler install

CMD bundler exec rackup -o 0.0.0.0 -p 1202

EXPOSE 1202

ADD . /app
