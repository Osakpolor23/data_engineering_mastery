FROM python:3.11-slim-bookworm
WORKDIR /app
EXPOSE 8502
COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY data_process.py ./
CMD ["streamlit", "run", "data_process_db.py"]