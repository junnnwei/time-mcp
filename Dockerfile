# Use an official Python image
FROM python:3.11-slim

# Set working directory inside the container
WORKDIR /app

# Copy only requirements first for caching
COPY pyproject.toml poetry.lock* requirements.txt* ./

# Install dependencies (choose one: pip or poetry)
RUN pip install --upgrade pip && \
    if [ -f requirements.txt ]; then pip install -r requirements.txt; fi && \
    if [ -f pyproject.toml ]; then pip install poetry && poetry install --no-dev; fi

# Copy the full application
COPY . .

# Expose port if needed (default for uvicorn)
EXPOSE 8000

# Run the server (adjust host/port as needed)
CMD ["uvicorn", "time_mcp_server:app", "--host", "0.0.0.0", "--port", "8000"]
