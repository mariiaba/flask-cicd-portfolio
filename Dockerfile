# Step 1: Use an official Python runtime as a parent image
FROM python:3.9-slim

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Step 4: Copy the rest of the application code into the container
COPY ./app /app

# Step 5: Expose the port the app runs on
EXPOSE 5000

# Step 6: Define the command to run the application
CMD ["python", "main.py"]
