FROM python:3.8-slim

# both files are explicitly required!
COPY Pipfile Pipfile.lock ./

RUN pip install pipenv && \
  apt-get update && \
  apt-get install -y --no-install-recommends gcc python3-dev libssl-dev && \
  pipenv install --deploy --system

LABEL "com.github.actions.name"="github-action-tester"
LABEL "com.github.actions.description"="Run tests against pull requests"
LABEL "com.github.actions.icon"="eye"
LABEL "com.github.actions.color"="gray-dark"

LABEL version="1.0.0"
LABEL repository="http://github.com/SparkPost/github-action-tester"
LABEL homepage="http://github.com/SparkPost/github-action-tester"
LABEL maintainer="John Peacock <john.peacock@sparkpost.com>"

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
