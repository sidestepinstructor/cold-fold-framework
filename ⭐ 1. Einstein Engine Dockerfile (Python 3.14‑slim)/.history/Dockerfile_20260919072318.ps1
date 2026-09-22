# ─────────────────────────────────────────────
#   EINSTEIN ENGINE — DOCKERFILE (base image)
# ─────────────────────────────────────────────

ARG PYTHON_VERSION=3.14.7
FROM python:${PYTHON_VERSION}-slim AS base

# Prevent Python from writing .pyc files and enable unbuffered logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy requirements first (for caching)
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy engine source
COPY . .

# Default command (can be overridden by Compose)
CMD ["python", "Einstein.py"]
