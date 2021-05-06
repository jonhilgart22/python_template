.PHONY: help install lint
.DEFAULT: help
PYTHON_VERSION=3.7.8

help:
	@echo "make install"
	@echo "       installs dependencies"
	@echo "make lint"
	@echo "       format with isort and black, lint with flake8 and mypy"
	@exit 0

install:
	hash pyenv || brew install pyenv
	pyenv install ${PYTHON_VERSION} -s
	pyenv local ${PYTHON_VERSION}
	hash poetry || curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
	poetry run pip install --upgrade pip
	poetry install --no-root

lint: install
	poetry run isort .
	poetry run black .
	poetry run flake8
	poetry run mypy .
