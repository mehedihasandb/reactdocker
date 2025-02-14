# FROM node:20.14-alpine
# RUN addgroup app && adduser -S -G app app
# USER app
# WORKDIR /app
# COPY . .
# RUN npm install
# ENV API_URL=http://api.myapi.com/
# EXPOSE 3000
# CMD ["npm", "start"]

FROM node:20.14-alpine

# Create a non-root user
RUN addgroup app && adduser -S -G app app

# Set working directory
WORKDIR /app

# Copy files first (to leverage Docker cache)
COPY . .

# Fix permissions: Change ownership of /app to 'app' user
RUN chown -R app:app /app

# Switch to non-root user
USER app

# Install dependencies
RUN npm install

# Set environment variables
ENV API_URL=http://api.myapi.com/

# Expose port
EXPOSE 3000

# Use JSON format for CMD (recommended)
CMD ["npm", "start"]
