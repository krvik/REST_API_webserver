APP_NAME = rest_api_app
VERSION ?= 1.0.0
REGISTRY = docker.io/vikashkumardev1996
















#-------Config--------
DB_IMAGE        := postgres:15
DB_CONTAINER    := rest_api_db
DB_NAME         := students_db
DB_USER         := postgres
DB_PASSWORD     := postgres
DB_PORT         := 5432
DB_HOST         := $(DB_CONTAINER)
DB_VOLUME       := pgdata_rest
DB_NETWORK      := rest_net
















# SQL files (optional – only if you have them)
SCHEMA_SQL := db/schema.sql
DML_SQL    := db/dml.sql
















# Connection strings
DATABASE_URL := postgresql://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)
















# Helpers
.PHONY: up down build api-run api-stop db-start db-wait db-shell db-stop db-reset migrate hel
















# =========================
# 1) Build the API image
# =========================
build:
	@echo "==> Building API image $(APP_NAME):$(VERSION)"
	docker build -t $(APP_NAME):$(VERSION) .








# =========================
# 2) Start PostgreSQL DB
# =========================








db-start:
	@echo "==> Creating network (if missing): $(DB_NETWORK)"
	@docker network inspect $(DB_NETWORK) >/dev/null 2>&1 || docker network create $(DB_NETWORK)
	@echo "==> Creating volume (if missing): $(DB_VOLUME)"
	@docker volume inspect $(DB_VOLUME) >/dev/null 2>&1 || docker volume create $(DB_VOLUME)
	@echo "==> Starting Postgres container: $(DB_CONTAINER)"
	@docker ps --format '{{.Names}}' | grep -q '^$(DB_CONTAINER)$$' || \
	docker run -d --name $(DB_CONTAINER) \
		--network $(DB_NETWORK) \
      		-e POSTGRES_USER=$(DB_USER) \
      		-e POSTGRES_PASSWORD=[Credentials] \
      		-e POSTGRES_DB=$(DB_NAME) \
		-p $(DB_PORT):5432 \
      		-v $(DB_VOLUME):/var/lib/postgresql/data \
      		$(DB_IMAGE)
















# Wait for DB to be ready
db-wait:
	@echo "==> Waiting for Postgres to be ready..."
	@for i in $$(seq 1 30); do \



