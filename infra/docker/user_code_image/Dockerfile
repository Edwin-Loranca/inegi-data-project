FROM python:3.11-slim

WORKDIR /opt/dagster/app

COPY user_code/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY user_code/dagster_user_code/ ./dagster_user_code/

EXPOSE 4000