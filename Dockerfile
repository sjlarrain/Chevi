# Base image
FROM ruby:3.1

# Set environment variables
ENV RAILS_ENV=production
ENV RACK_ENV=production

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --without development test

# Copy app files
COPY . ./

# Precompile assets
RUN bundle exec rake assets:precompile

# Database setup (can be done in an entrypoint script)
RUN bundle exec rake db:migrate

# Expose port
EXPOSE 3000

# Start the server
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
