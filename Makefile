APP_NAME = rest_api_app
VERSION ?= 1.0.0
REGISTRY = docker.io/vikashkumardev1996


# -----------------------------
# Build Docker Image
# -----------------------------
# Usage:
#   make build VERSION=1.2.0
build:
	docker build -t $(APP_NAME):$(VERSION) .


# -----------------------------
# Run the App in Docker
# -----------------------------
# Usage:
#   make run VERSION=1.2.0
# This will start the app on http://localhost:5000
run:
	docker run --rm -p 5000:5000 \
		-e APP_ENV=dev \
		-e LOG_LEVEL=DEBUG \
		$(APP_NAME):$(VERSION)


# -----------------------------
# Tag the Image (SemVer Tagging)
# -----------------------------
# Usage:
#   make tag VERSION=1.2.0
tag:
	docker tag $(APP_NAME):$(VERSION) $(REGISTRY)/$(APP_NAME):$(VERSION)
	docker tag $(APP_NAME):$(VERSION) $(REGISTRY)/$(APP_NAME):latest


# -----------------------------
# Push to Docker Hub
# -----------------------------
push:
	docker push $(REGISTRY)/$(APP_NAME):$(VERSION)
	docker push $(REGISTRY)/$(APP_NAME):latest


# -----------------------------
# Clean Local Images
# -----------------------------
clean:
	docker rmi $(APP_NAME):$(VERSION) || true
	docker rmi $(REGISTRY)/$(APP_NAME):$(VERSION) || true


# -----------------------------
# Help Menu
# -----------------------------
help:
	@echo "make build         - Build Docker image"
	@echo "make run           - Run app locally"
	@echo "make tag VERSION=x - Tag image using semver"
	@echo "make push          - Push to Docker Hub"
	@echo "make clean         - Remove local images"
