FROM python:3.13.5-alpine3.22

# Install curl and dependencies
RUN apt-get update && apt-get install -y curl gcc libffi-dev libssl-dev && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Add uv to PATH
ENV PATH="/root/.cargo/bin:$PATH"

WORKDIR /app

# Copy lockfiles
COPY pyproject.toml uv.lock ./

# Install dependencies using uv (locked, reproducible)
RUN uv pip install --system --no-deps --require-hashes

# Copy rest of the source code
COPY . .

EXPOSE 8000

# Match Claude's expected format
CMD ["uv", "--directory", ".", "run", "time_mcp_server.py"]
