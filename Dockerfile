FROM ruby:2
RUN gem install bundler 
RUN gem install jekyll -v 3.9.0
WORKDIR /usr/local/app
COPY Gemfile Gemfile
RUN bundle
RUN bundle clean --force
CMD jekyll serve --host 0.0.0.0 --baseurl /test-base
 