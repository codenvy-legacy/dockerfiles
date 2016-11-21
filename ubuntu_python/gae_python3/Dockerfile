# Copyright (c) 2012-2016 Codenvy, S.A.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# Contributors:
# Codenvy, S.A. - initial API and implementation

FROM codenvy/debian_jre

ENV GAE /home/user/google_appengine

RUN sudo apt-get update -y && \
    sudo apt-get install --no-install-recommends -y -q build-essential python3 python3-dev python-pip git python3-pip && \
    sudo pip3 install -U pip && \
    sudo pip3 install virtualenv
RUN wget -qO- "https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.40.zip" -O /tmp/gae-sdk.zip && \
    unzip -q /tmp/gae-sdk.zip -d /home/user && \
    rm /tmp/gae-sdk.zip

EXPOSE 8080 8000
WORKDIR /projects
CMD tailf /dev/null
