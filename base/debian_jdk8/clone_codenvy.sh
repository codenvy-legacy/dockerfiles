#!/bin/bash
# The script clones all repositories of an GitHub organization.
# the git clone cmd used for cloning each repository
# the parameter recursive is used to clone submodules, too.
GIT_CLONE_CMD="git clone "

# fetch repository list via github api
# grep fetches the json object key ssh_url, which contains the ssh url for the repository
# Instead of GITHUB_TOKEN insert or define Personal access tokens from this https://github.com/settings/applications page
if [ -z "${GITHUB_TOKEN}" ] || [ "${GITHUB_TOKEN+xxx}" = "xxx" ]; then
    REPOLIST=`curl  --silent 'https://api.github.com/orgs/codenvy/repos?type=all&per_page=100' -q | grep "\"clone_url\"" | awk -F': "' '{print $2}' | sed -e 's/",//g'`
else
    REPOLIST=`curl  -u ${GITHUB_TOKEN}:x-oauth-basic  --silent 'https://api.github.com/orgs/codenvy/repos?type=all&per_page=100' -q | grep "\"ssh_url\"" | awk -F': "' '{print $2}' | sed -e 's/",//g'`
fi

# loop over all repository urls and execute clone
cd ../../
for REPO in $REPOLIST; do
    ${GIT_CLONE_CMD}${REPO}
done
