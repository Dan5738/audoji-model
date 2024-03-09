# Pull the NVIDIA base image with CUDA and cuDNN
FROM nvidia/cuda:11.3.0-cudnn8-runtime-ubuntu20.04

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install necessary system dependencies and Python 3.10
RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    python3.10 \
    python3.10-distutils \
    python3.10-venv \
    python3-pip && \
    python3.10 -m pip install --upgrade pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Update alternatives to prioritize Python 3.10
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1 && \
    update-alternatives --set python3 /usr/bin/python3.10

# Set work directory
WORKDIR /app

# Copy project
COPY . /app/

# Install Python dependencies including Whisper
RUN python3.10 -m pip install --no-cache-dir -r requirements.txt && \
    python3.10 -m pip install --no-cache-dir git+https://github.com/openai/whisper.git

# Set the entrypoint
ENTRYPOINT ["python3.10", "creator.py"]
