# Use official Python image
FROM python:3.10

# Set the working directory in the container
WORKDIR /app

# Copy required files
COPY requirements.txt ./

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app code
COPY . .

# Expose the FastAPI port
EXPOSE 8000

# Run the FastAPI app
CMD ["uvicorn", "blog.main:app", "--host", "0.0.0.0", "--port", "8000"]
