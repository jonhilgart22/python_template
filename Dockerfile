# release-1. indicates this is a python3.6 release
FROM 193567999519.dkr.ecr.us-east-1.amazonaws.com/ml-fastapi-server:release-1.1.9.0


# Install python packages
COPY pyproject.toml poetry.lock ./
COPY lib ./lib
RUN set -x \
    && pip install --no-cache-dir --upgrade pip \
    && poetry export --without-hashes -f requirements.txt -o requirements.txt \
    && pip install --no-cache-dir -r requirements.txt \
    && rm requirements.txt

# Copy code
COPY ml_smoking_status ./ml_smoking_status

# Set predictor class
ENV PREDICTOR_CLASS="ml_smoking_status.modeling.lstm_crf.predictor.Predictor"

# Enable Prometheus metrics collection
ENV ENABLE_PROMETHEUS="true"
