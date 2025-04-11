FROM python:3.9-slim

# ✅ Install only necessary system dependencies (remove PortAudio)
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    tesseract-ocr \
    poppler-utils \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# ✅ Install Python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Expose Streamlit port
EXPOSE 10000

# Start frontend (Streamlit only)
CMD ["streamlit", "run", "app.py", "--server.port=10000", "--server.enableCORS=false", "--server.enableXsrfProtection=false"]

