FROM phusion/passenger-ruby23
MAINTAINER Jakub Kubacki "kubacki.jk@gmail.com"

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim libmysqlclient-dev libpq-dev libsqlite3-dev libev-dev
RUN mkdir /app
WORKDIR /app

# Set correct environment variables.
ENV RAILS_ENV production

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]
# Start Nginx and Passenger
EXPOSE 80
RUN rm -f /etc/service/nginx/down
# Configure Nginx
RUN rm /etc/nginx/sites-enabled/default
ADD nginx.conf /etc/nginx/sites-enabled/my-app.conf
#USER vagrant

# Install the app
ADD . /app
RUN gem install bundler
RUN bundle install
RUN RAILS_ENV=production bundle exec rake assets:precompile
# Clean up APT when done.
# RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
