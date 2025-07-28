FROM golang:1.24.5

WORKDIR /app

# Install the tools
RUN go install github.com/cbergoon/sqldatadump@latest && \
  go install github.com/cbergoon/sqldataload@latest

# Add your script
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Create a mountable volume for data
VOLUME ["/data"]

# Default command
ENTRYPOINT ["/app/run.sh"]
