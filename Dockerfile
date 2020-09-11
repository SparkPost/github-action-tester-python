FROM python:3.8-slim

ARG UID=1003
ARG GID=1003

RUN python -m pip install --upgrade pip && \
    pip install pipenv pytest && \
    pip --version

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
