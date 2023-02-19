# Use the Python 3.10 slim image as the base image
FROM python:3.10-slim

# Set the working directory to /mill
WORKDIR /mill

# Copy the requirements file to the working directory
COPY requirements.txt .

# mvIMPACT_Acquire Version
ENV MVIMPACT_VERSION 2.48.0

# Install wget - TODO different image...
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y kmod 
RUN apt-get install -y expect

# Download vmGenTL_Acquire
RUN wget http://static.matrix-vision.com/mvIMPACT_Acquire/$MVIMPACT_VERSION/install_mvGenTL_Acquire.sh
RUN wget http://static.matrix-vision.com/mvIMPACT_Acquire/$MVIMPACT_VERSION/mvGenTL_Acquire-x86_64_ABI2-$MVIMPACT_VERSION.tgz

# Install vmGenTL_Acquire
# RUN cd /tmp/vimba
# RUN mkdir /opt/gentl
# RUN tar -xzf mvGenTL_Acquire-x86_64_ABI2-$MVIMPACT_VERSION.tgz --strip-components=1 -C /opt/gentl
RUN chmod +x install_mvGenTL_Acquire.sh
RUN ./install_mvGenTL_Acquire.sh

# Install the required python packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy repo files
COPY . .

# Expose port 8000 for the HTTP server
EXPOSE 8000

# Start the HTTP server
CMD ["python", "main.py"]
