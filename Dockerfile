# Use the Python 3.10 slim image as the base image
FROM python:3.10-slim

# Set the working directory to /mill
WORKDIR /mill

# Copy the requirements file to the working directory
COPY requirements.txt .

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy repo files
COPY . .

# Expose port 8000 for the HTTP server
EXPOSE 8000

# Start the HTTP server
CMD ["python", "main.py"]
