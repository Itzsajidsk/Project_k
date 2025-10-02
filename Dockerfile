FROM python:3.11-slim

WORKDIR /app

# Copy requirements first to leverage layer caching
COPY requirements.txt ./
# Ensure packaging/build tools are recent to avoid build backend errors
RUN python -m pip install --upgrade pip setuptools wheel
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . .

EXPOSE 5000

CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
