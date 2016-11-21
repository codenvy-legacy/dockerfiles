# Copyright (c) 2012-2016 Codenvy, S.A.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# Contributors:
# Codenvy, S.A. - initial API and implementation

FROM codenvy/php
ENV GAE /home/user/google_appengine

RUN sudo apt-get update && \
    sudo apt-get install --no-install-recommends -y -q build-essential python2.7 python2.7-dev python-pip && \
    sudo pip install -U pip && \
    sudo pip install virtualenv
RUN cd /home/user/ && wget -q https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.40.zip && \
    unzip -q google_appengine_1.9.40.zip && \
    rm google_appengine_1.9.40.zip 

EXPOSE 8080 8000
WORKDIR /projects
