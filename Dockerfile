FROM ruby:2.7.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /inventory_manager
WORKDIR /inventory_manager
ADD Gemfile /inventory_manager/Gemfile
ADD Gemfile.lock /inventory_manager/Gemfile.lock
RUN bundle install
ADD . /inventory_manager


# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]