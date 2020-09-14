FROM python@sha256:d2cbcf4d205ca2210e46915f79f486dffe710d2b1deedbe4f7c017e2f9d9b6a8

ARG UID=1003
ARG GID=1003

RUN pip install pipenv pytest

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
