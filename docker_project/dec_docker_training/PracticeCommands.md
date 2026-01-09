# Docker Essentials: Mastering Key Commands

This document contains a practice script with essential Docker commands to help you master key containerization concepts. The script covers fundamental operations such as managing images, containers, volumes, networking, and Docker Compose. It is designed for beginners looking to solidify their understanding of Docker.

---

### **Step 1: Verify Docker Installation**
**Command:**
```bash
docker --version
docker info
```
**Explanation:**
- The first command checks if Docker is installed.
- The second command provides system-wide information about Docker.

---

### **Step 2: Running a Basic Container**
**Command:**
```bash
docker run hello-world
```
**Explanation:**
- This pulls and runs the "hello-world" container to verify Docker is working.
- The output should display a message confirming successful installation.

---

**Command:**
```bash
docker run -d -p 8080:80 --name welcome docker/welcome-to-docker
```
**Explanation:**
- This pulls and runs the "welcome-to-docker" container in detached mode, binds it to port 8080 of the host and names the container "welcome".
- The output is an application running on `http://localhost:8080`.

---

### **Step 3: Running an Interactive Ubuntu Container**
**Command:**
```bash
docker run -it ubuntu bash
```
**Explanation:**
- This starts an Ubuntu container in interactive mode.
- Inside the container, run:
  ```bash
  ls
  pwd
  exit
  ```
- This helps understand containerized environments.

---

### **Step 4: Listing and Stopping Containers**
**Commands:**
```bash
docker ps
docker ps -a
docker stop <container_id>
docker rm <container_id>
```
**Explanation:**
- `docker ps` shows running containers.
- `docker ps -a` lists all containers.
- `docker stop` stops a running container.
- `docker rm` removes stopped containers.

---

### **Step 5: Building a Custom Docker Image**
**1. Create a new folder and navigate into it:**
```bash
mkdir myapp && cd myapp
```
**2. Create a Python script (`app.py`):**
```python
print("Hello from inside a container!")
```
**3. Create a Dockerfile to package this script into an image:**
```Dockerfile
FROM python:3.11.11-slim-bookworm
WORKDIR /test_app
COPY app.py ./
CMD ["python", "/app.py"]
```
**4. Build the Docker image:**
```bash
docker build -t my-python-app .
```
**5. Run the container from the image:**
```bash
docker run my-python-app
```
**Explanation:**
- This showcases how to containerize a simple Python script.

---

### **Step 6: Pushing an Image to Docker Hub**
**Commands:**
```bash
docker tag my-python-app <mydockerhubusername>/my-python-app:v1
docker login
docker push <mydockerhubusername>/my-python-app:v1
```
**Explanation:**
- This uploads the custom image to Docker Hub for sharing.

---

### **Step 7: Managing Docker Networks**
**Commands:**
```bash
docker network ls
docker network create my_custom_network
docker network inspect my_custom_network
docker network rm my_custom_network
```
**Explanation:**
- These commands show how to manage custom Docker networks for container communication.

**Attach Container to a network**
```bash
docker network create my_custom_network
docker run -it --network my_custom_volume ubuntu bash
```
**Explanation:**
- These commands create a user defined network `my_custom_volume`, runs an ubuntu container in interactive mode and attach the container to this network.
---

### **Step 8: Managing Docker Volumes**
**Commands:**
```bash
docker volume ls
docker volume create my_custom_volume
docker volume inspect my_custom_volume
docker volume rm my_custom_volume
docker volume prune
```
**Explanation:**
- These commands show how to manage custom Docker volumes for container's data persistence.
- `volume ls` shows running containers.
- `docker ps -a` lists all containers.
- `docker stop` stops a running container.
- `docker rm` removes stopped containers.

---

### **Step 9: Attach volume to a contianer**
**Commands:**
```bash
docker volume create my_custom_volume
docker run -it --volume my_custom_volume:/dec ubuntu bash
```
**Explanation:**
- These commands create a cutome volume `my_custom_volume`, runs an ubuntu container in interactive mode and attach the custom volume to the `/dec` path in the ubuntu container.

**Persist data in the container**
```bash
ls
cd dec
echo "Persisted data" > file.txt
cat file.txt
```
**Explanation:**
- `ls` list all files and folder in the current directory. You should see the `dec` directory.
- `cd dec` change directory to the `dec` folder.
- `echo "Persisted data" > file.txt` write text to a file.
- `cat file.txt` comfirm the text is written to the file by printing the content to the terminal.
- The file.txt will now persist beyond the lifecycle of the container. Try this by attaching the volume `my_custom_volume` to a new container.
---

### **Step 10: Docker Compose for Multi-Container Applications**
**1. Create a `compose.yml` file:**
```yaml
services:
  web:
    image: nginx
    ports:
      - "8080:80"
```
**2. Start the service:**
```bash
docker compose up -d
```
**3. Open browser at:** `http://localhost:8080`

**4. Stop the service:**
```bash
docker compose down
```
**Explanation:**
- This demonstrates how Docker Compose manages multi-container applications.

---

Well done! This practice script covers essential Docker concepts.