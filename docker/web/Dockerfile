FROM ruby:3.1

ENV LANG C.UTF-8
ENV APP_ROOT /app
ENV BUNDLE_JOBS 4
ENV BUNDLER_VERSION 2.3.26
# ENV BUNDLER_VERSION 2.2.25

RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

COPY Gemfile $APP_ROOT/Gemfile
COPY Gemfile.lock $APP_ROOT/Gemfile.lock

RUN gem install bundler -v $BUNDLER_VERSION
RUN bundle -v
RUN bundle install

COPY . $APP_ROOT

# Add a script to be executed every time the container starts.
COPY ./docker/web/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# EXPOSE 3000

# 起動の度にデフォルトでrails sする（entrypoint.shに持たせても良い）
CMD ["sh", "./docker/web/start-server.sh"]