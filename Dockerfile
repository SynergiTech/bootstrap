FROM ruby:2.5.5-slim-buster

# need gnupg for adding apt repo
RUN apt-get update \
    && apt-get install -y curl gnupg ruby-dev gcc g++ libffi-dev make git

# add nodesource
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -

# install node js for theme
RUN apt-get update \
    && apt-get install -y nodejs

WORKDIR /workdir

COPY . .

RUN gem install bundler && bundle install

RUN npm install && npm run dist

# dummy command to keep the container alive
CMD tail -f /dev/null
