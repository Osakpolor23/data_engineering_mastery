FROM python:3.11-slim-bookworm
WORKDIR /app
EXPOSE 8501
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY . .
ENTRYPOINT ["streamlit", "run", "./app/data_process_db.py"]