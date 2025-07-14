FROM python:3.13.5-alpine3.22

# Install uv (https://github.com/astral-sh/uv)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:$PATH"

WORKDIR /app

# Copy dependency files first for caching
COPY pyproject.toml uv.lock ./

# Install dependencies using uv
RUN uv pip install --system --no-deps --require-hashes

# Copy the rest of the source code
COPY . .

EXPOSE 8000

CMD ["uv", "--directory", ".", "run", "time_mcp_server.py"]
