FROM python:3.6.8-slim-stretch

ARG UID=1003
ARG GID=1003

RUN pip install --upgrade \
  pip \
  setuptools \
  importlib-metadata \
  pipenv \
  pytest

RUN groupadd -g ${GID} ghrunner && \
    useradd -l -u ${UID} -g ghrunner -m ghrunner

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
