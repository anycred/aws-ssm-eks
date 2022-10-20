# Container image that runs your code
FROM acmedeepcred/python3.10-aws_cli-kubectl:v1.0.0

RUN pip install --no-cache-dir poetry
ADD pyproject.toml poetry.lock /src/
RUN poetry export -f requirements.txt --output requirements.txt --without-hashes
RUN pip install --no-cache-dir -r requirements.txt

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
