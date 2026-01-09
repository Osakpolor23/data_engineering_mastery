# Docker Practice Projects: Streamlit + PostgreSQL

This repository contains a Docker project that containerize Python applications and orchestrate multi-container setups with Docker Compose. The project make use of **Streamlit** app for the frontend which allows users to upload a CSV file and the first five rowsof the dataset, as well as the summary statistics of numerical columns are displayed. The application is also integrateed with a **PostgreSQL** db in order for the data to be persisted when the container stops running. The container is published to the dockerhub repository for easy access and use.

---
### Dockerization Steps(Project 1 - single container)
The following were the steps taken in containerization this application:

1. **Dockerfile**
The Dockerfile was created to meet the following requirements and to meet the best caching principle:

   - A Lightweight Python base image was used - 3.11-slim-bookworm
   - Installs dependencies from `requirements.txt`.
   - Copies application code into the image.
   - Exposes port `8501`.
   - Entrypoint runs 
     ```bash
     streamlit run ./app/data_process.py
     ```

2. **Build and Run**
    The following commands were run to build the docker image and run the container
   ```bash
   docker build -t streamlit_app .
   docker run -p 8080:8501 --name streamlit_app <image_name/imageid e.g streamlit_app>
   ```
    
4. **Verify**
    To verify that the container is runnning as expected, these verifications were carried out.
    Open http://localhost:8080.

    Upload student.csv to confirm functionality.

5. **Publish to DockerHub**
These pushed the containers to DockerHub for easy access and use: 
```bash
    docker login
    docker tag streamlit_app osakpolorogieriakhi/streamlit-app:v1
    docker push osakpolorogieriakhi/streamlit-app:v1
```

### Dockerization Steps(Project 2 - multiple containers)
The following were the steps taken in containerization this application:

1. **Dockerfile**
The Dockerfile was created to meet the following requirements and to meet the best caching principle:

   - A Lightweight Python base image was used - 3.11-slim-bookworm
   - Installs dependencies from `requirements.txt`.
   - Copies application code into the image.
   - Exposes port `8501`.
   - Entrypoint runs 
     ```bash
     streamlit run ./app/data_process_db.py
     ```
2. **Writing a Compose file for the multiple container services - app and postgres db**
    As seen on the repository, a compose file was written to cater for the application and postgres database, as well as the volume on which the data is persisted. An environment file(.env) was created to store the postgres credentials.

3. **Build and Run**
    The following commands were run to build the docker image and run the container
   ```bash
   docker compose up --build
   docker compose up
   ```
    
4. **Verify**
    To verify that the container is runnning as expected, these verifications were carried out.
    Open http://localhost:8501.
    Upload student.csv to confirm functionality.
    
    To check for the data on the progress db, the following command was run to execute into it:

    ```bash
    docker exec -it <database name> psql -U postgres
    \dt -- to show table names
    select * from <table name>
    ```


5. **Publish to DockerHub**
These pushed the containers to DockerHub for easy access and use: 
```bash
    docker login
    docker tag dec_docker_training-app osakpolorogieriakhi/streamlit-app:v1
    docker push osakpolorogieriakhi/streamlit-app:v1
```

Feel free to contribute to this repository. Regards.



