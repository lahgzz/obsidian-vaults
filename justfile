image := "test"

# ── local env ────────────────────────────────────────────────────────────────

# Build the Docker image
[group('local')]
build:
    docker build -f .local/Dockerfile -t {{image}} .

# Build and serve at http://localhost:8080
[group('local')]
serve: build
    docker run --rm -d -p 8080:8080 --name {{image}} {{image}}

# Open a shell terminal on running container
[group('local')]
shell:
    docker exec -it {{image}} sh

# Stop the running container
[group('local')]
stop:
    docker stop {{image}}

# Reset the running container
[group('local')]
reset:
    just stop
    just build
    just serve
    just logs

# Show logs from the running container
[group('local')]
logs:
    docker logs -f {{image}}

# Remove the Docker image
[group('local')]
clean:
    docker rmi {{image}}