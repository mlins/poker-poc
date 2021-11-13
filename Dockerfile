FROM ruby:3.0

WORKDIR /app
COPY . .
RUN bundle install

EXPOSE 4567

CMD ["ruby", "app.rb", "-o", "0.0.0.0"]
