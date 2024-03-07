# Pull the base image
FROM python:3.10

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install necessary system dependencies
RUN apt-get update -y && \
    # Install ffmpeg
    apt-get update && apt-get install -y ffmpeg

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app

# Copy project
COPY . /app/

# Install Python dependencies including Whisper
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir git+https://github.com/openai/whisper.git

# # Collect static files
# RUN python manage.py collectstatic --noinput

# Set the entrypoint
ENTRYPOINT ["python", "creator.py"]
