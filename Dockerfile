FROM ruby:3.1.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /rails-forum
WORKDIR /rails-forum
COPY Gemfile /rails-forum/Gemfile
COPY Gemfile.lock /rails-forum/Gemfile.lock
RUN bundle install
COPY . /rails-forum

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/entrypoint.sh
COPY entrypoint.sh /usr/bin/test-entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh && chmod +x /usr/bin/test-entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
