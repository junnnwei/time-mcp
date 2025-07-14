FROM python:3.13.5-alpine3.22

# Install dependencies needed for uv
RUN apk add --no-cache curl gcc musl-dev libffi-dev openssl-dev cargo

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    cp /root/.local/bin/uv /usr/local/bin/uv && \
    uv --version

WORKDIR /app

# Copy everything before running
COPY . .

EXPOSE 8000

# Run like Claude Desktop expects — handles lockfile automatically
CMD ["uv", "--directory", ".", "run", "time_mcp_server.py"]
