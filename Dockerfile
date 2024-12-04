FROM python:3.14-rc-slim as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN useradd -m flaskuser
USER flaskuser

FROM python:3.14-rc-slim
WORKDIR /app
COPY --from=builder /usr/local/lib/python3.14/site-packages /usr/local/lib/python3.14/site-packages
COPY . .
CMD ["python", "app.py"]

HEALTHCHECK --interval=30s --timeout=30s --retries=3 CMD curl --fail http://localhost:5000/ || exit 1
