FROM ruby:2.7.0-alpine

RUN apk --no-cache add \
      build-base \
 && rm -rf /var/cache/apk/*

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs $(nproc) \
 && rm -rf $GEM_HOME/cache/*.gem \
 && mkdir -p $GEM_HOME/gems \
 && find $GEM_HOME/gems -name "*.c" -delete \
 && find $GEM_HOME/gems -name "*.o" -delete

COPY . ./

ENV PATH "/usr/src/app/bin:${PATH}"

CMD ['cats']
