# Этап, на котором выполняются подготовительные действия
FROM python:3.11.2 as builder
LABEL authors="Builder"

WORKDIR /installer

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc

RUN python -m venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

COPY service/requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

# Финальный этап
FROM python:3.11.2
LABEL authors="Developer"

COPY --from=builder /opt/venv /opt/venv
COPY compatibility ./opt/

WORKDIR /service

ENV PATH="/opt/venv/bin:$PATH"

COPY service .
COPY service/entrypoint.sh entrypoint.sh

EXPOSE 8000
ENTRYPOINT ["sh", "-c", "/service/entrypoint.sh"]