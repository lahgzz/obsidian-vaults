image := "on-obsidian-vaults"

# ── local env ────────────────────────────────────────────────────────────────

# Build the Docker image
[group('local')]
build:
    docker build -f .docker/Dockerfile -t {{image}} .

# Serve at http://localhost:8080
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

# Copy build artifacts from image without running container
[group('local')]
copy-artifacts: build
    docker create --name {{image}}-copy {{image}}
    docker cp {{image}}-copy:/quartz/package-lock.json .quartz/package-lock.json
    docker cp {{image}}-copy:/quartz/package.json .quartz/package.json
    docker cp {{image}}-copy:/quartz/quartz.lock.json .quartz/quartz.lock.json
    docker cp {{image}}-copy:/quartz/quartz.ts .quartz/quartz.ts
    docker rm {{image}}-copy

# Remove the Docker image
[group('local')]
clean:
    docker rmi {{image}}