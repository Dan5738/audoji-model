# Use a PyTorch base image with CUDA and cuDNN
FROM pytorch/pytorch:1.8.1-cuda11.1-cudnn8-runtime

ENV DEBIAN_FRONTEND=noninteractive

# Install software properties common (for add-apt-repository) and ffmpeg
RUN apt-get update && apt-get install -y software-properties-common ffmpeg

# Add deadsnakes PPA for newer Python versions
RUN add-apt-repository ppa:deadsnakes/ppa

# Install Python 3.10 and pip
RUN apt-get update && apt-get install -y python3.10 python3-pip

# Update pip
RUN python3.10 -m pip install --upgrade pip

# Set work directory
WORKDIR /app

# Copy your application code
COPY . /app/

# Install Python dependencies from requirements.txt
RUN python3.10 -m pip install --no-cache-dir -r requirements.txt

# The command to run the application
ENTRYPOINT ["python3.10", "creator.py"]
