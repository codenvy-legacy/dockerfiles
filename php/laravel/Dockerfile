FROM codenvy/php

RUN composer global require "laravel/installer" && \
    sudo sed -i '$ d' /home/user/.bashrc

ENV PATH /home/user/.composer/vendor/bin:$PATH

