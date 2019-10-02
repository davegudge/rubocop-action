FROM ruby:2.6-alpine

RUN apk add --update build-base git qt5-qtwebkit-dev postgresql-dev cracklib-dev cracklib-words

## Install capybara-webkit defining the qmake path
## https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit#alpine-linux-34
RUN QMAKE=/usr/lib/qt5/bin/qmake gem install capybara-webkit

## Create Cracklib Dictionary
RUN mkdir -p /usr/local/lib && \
    cd /usr/local/lib && \
    wget https://github.com/cracklib/cracklib/releases/download/v2.9.7/cracklib-words-2.9.7.gz && \
    create-cracklib-dict -o pw_dict cracklib-words-2.9.7.gz

COPY lib /action/lib
RUN gem install bundler
ENTRYPOINT ["/action/lib/entrypoint.sh"]
