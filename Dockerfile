FROM ruby:2.5.3

ARG RAILS_ENV=development
WORKDIR /app

# 50 MB stack needed in sync worker thread
ENV RUBY_THREAD_VM_STACK_SIZE=50000000

RUN wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.00.27.tar.gz && \
  tar -xzf freetds-1.00.27.tar.gz && \
  cd freetds-1.00.27 && \
  ./configure --prefix=/usr/local --with-tdsver=7.3 && \
  make && \
  make install

ENV RAILS_ENV ${RAILS_ENV}

COPY Gemfile Gemfile.lock ./
RUN bundle check || bundle install

COPY . /app
EXPOSE 3000
