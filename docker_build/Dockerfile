# Use a base image with the necessary OS and dependencies
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y bowtie cutadapt

# Copy your custom Bash script into the container
COPY source.sh /usr/local/bin/source.sh

# Set execute permissions on the script
RUN chmod +x /usr/local/bin/source.sh

# Set the working directory
WORKDIR /usr/local/bin

# Define the entry point for the container
ENTRYPOINT ["source.sh"]
