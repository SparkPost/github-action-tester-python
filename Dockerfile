FROM python:3.8-slim

ARG UID=1000
ARG GID=1000

RUN pip install pipenv pytest

RUN userdel -f ghrunner &&\
    if getent group ghrunner ; then groupdel ghrunner; fi &&\
    groupadd -g ${GID} ghrunner &&\
    useradd -l -u ${UID} -g ghrunner ghrunner

LABEL "com.github.actions.name"="github-action-tester-python"
LABEL "com.github.actions.description"="Run tests against pull requests"
LABEL "com.github.actions.icon"="eye"
LABEL "com.github.actions.color"="gray-dark"

LABEL version="1.0.0"
LABEL repository="http://github.com/SparkPost/github-action-tester-python"
LABEL homepage="http://github.com/SparkPost/github-action-tester-python"
LABEL maintainer="John Peacock <john.peacock@sparkpost.com>"

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh

USER ghrunner

ENTRYPOINT ["/entrypoint.sh"]
