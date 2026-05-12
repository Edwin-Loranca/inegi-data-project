FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 4000

CMD ["dagster", "code-server", "start", "-h", "0.0.0.0", "-p", "4000"]