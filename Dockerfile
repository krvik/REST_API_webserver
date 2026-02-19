#Stage1: Build dependencies
#=====================================
FROM python:3.11-slim as builder

WORKDIR /app

COPY requirements.txt ./
RUN pip install -r requirements.txt


# stage 2: Final runtime image
#======================================
FROM python:3.11-slim as runner
WORKDIR /app


# Default ENV values (override at runtime) 
ENV APP_ENV=production \
    APP_PORT=5000 \
    LOG_LEVEL=INFO


# copy installed dependencies from builder image
COPY --from=builder /usr/local /usr/local

# copy application files
# to avoid this, explicitly copy each file as below. or create  .dockerignore file.
# COPY . .
COPY app.py ./
COPY extensions.py  ./
COPY Makefile  ./
COPY models.py ./
COPY routes.py  ./
COPY test_students_api.py   ./

EXPOSE 5000

CMD ["python", "app.py"]
