FROM python:3.8-buster

EXPOSE 5000

# Copy only requirements to cache them in docker layer
WORKDIR /usr/src/app
COPY poetry.lock pyproject.toml /usr/src/app/

RUN apt-get update && apt-get upgrade -y 

RUN apt-get install curl

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
ENV PATH = "${PATH}:/root/.poetry/bin"
ENV REQUEST_ORIGIN = *

# Project initialization:
RUN poetry config virtualenvs.create false \
  && poetry install --no-interaction --no-ansi

# Creating folders, and files for a project:
COPY . /usr/src/app

CMD ["python", "app.py"]

