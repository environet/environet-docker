## Data node upgrade guide

#### Prerequisites
- Access to the terminal where Docker Compose is running.

---

### Step 1: Stop Services
Stop the project services
```bash
./environet data down
```

### Step 2: Update the repository and build a new image
Pull the git repository changes, and start the database container. It will contain the updated Dockerfile and docker compose changes.

```bash
#Pull the latest changes from the repository
git pull

# Build the new image
docker-compose --env-file=.env -p environet -f docker/docker-compose.data.yml build data_php
```

### Step 3: Start services

```bash
./environet data up
```