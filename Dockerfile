FROM python:3.6.2-alpine3.6

# Install dependencies for pip installs
RUN apk add --no-cache build-base postgresql-dev

# Copy in the PIP requirements
COPY requirements.txt .

# Install dependencies
RUN pip3 install \
        Django==1.11.4 \
        gunicorn==19.7.1 \
        psycopg2==2.7.3

# Remove install dependencies
RUN apk del --no-cache build-base postgresql-dev

# By default, expose port 8000 - can be changed when composing
EXPOSE 8000

# Copy in the sample app
COPY ./app /app

# Start the application using gunicorn
WORKDIR /app
CMD gunicorn mydjango.wsgi:application -w 2 -b :8000
