FROM codenvy/ubuntu_jre
ENV RAILS_VERSION 4.2.6
ENV RUBY_MAJOR 2.3
ENV RUBY_VERSION 2.3.0
ENV RUBY_DOWNLOAD_SHA256 ba5ba60e5f1aa21b4ef8e9bf35b9ddb57286cb546aac4b5a28c71f459467e507
ENV RUBYGEMS_VERSION 2.6.2

USER root
# skip installing gem documentation
RUN mkdir -p /usr/local/etc \
    && echo 'install: --no-document' >> /usr/local/etc/gemrc \
    && echo 'update: --no-document' >> /usr/local/etc/gemrc
USER user

# some of ruby's build scripts are written in ruby
# we purge this later to make sure our final image uses what we just built
RUN set -ex \
    && buildDeps=' \
	bison \
	libgdbm-dev \
	ruby \
    ' \
    && sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends make gcc zlib1g-dev autoconf build-essential libssl-dev libsqlite3-dev $buildDeps \
    && sudo rm -rf /var/lib/apt/lists/* \
    && sudo curl -fSL -o ruby.tar.gz "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" \
    && echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.gz" | sha256sum -c - \
    && sudo mkdir -p /usr/src/ruby \
    && sudo tar -xzf ruby.tar.gz -C /usr/src/ruby --strip-components=1 \
    && sudo rm ruby.tar.gz 

USER root
RUN cd /usr/src/ruby \
    && { sudo echo '#define ENABLE_PATH_CHECK 0'; echo; cat file.c; } > file.c.new && mv file.c.new file.c \
    && autoconf \
    && ./configure --disable-install-doc 
USER user

RUN cd /usr/src/ruby \
    && sudo make -j"$(nproc)" \
    && sudo make install \
    && sudo apt-get purge -y --auto-remove $buildDeps \
    && sudo gem update --system $RUBYGEMS_VERSION \
    && sudo rm -r /usr/src/ruby


ENV BUNDLER_VERSION 1.11.2

RUN sudo gem install bundler --version "$BUNDLER_VERSION"

# install things globally, for great justice
# and don't create ".bundle" in all our apps
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
    BUNDLE_BIN="$GEM_HOME/bin" \
    BUNDLE_SILENCE_ROOT_WARNING=1 \
    BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH
RUN sudo mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \
    && sudo chmod 777 "$GEM_HOME" "$BUNDLE_BIN"

RUN sudo apt-get update && sudo apt-get install -y nodejs --no-install-recommends && sudo rm -rf /var/lib/apt/lists/*

# see http://guides.rubyonrails.org/command_line.html#rails-dbconsole
RUN sudo apt-get update && sudo apt-get install -y mysql-client postgresql-client sqlite3 --no-install-recommends && sudo rm -rf /var/lib/apt/lists/*

RUN sudo gem install rails --version "$RAILS_VERSION"

EXPOSE 3000

CMD tailf /dev/null
WORKDIR /projects
