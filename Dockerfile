# Use the official Node.js 14 image as base
FROM public.ecr.aws/lambda/nodejs:18.2023.04.17.20

# Set the working directory inside the container
WORKDIR /usr/src/server


# Copy package.json and package-lock.json to the working directory
COPY package*.json ./
COPY src/assets/* ./dist/assets/documents

RUN yum install -y python3 make gcc-c++ && \
    yum clean all && \
    rm -rf /var/cache/yum

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build TypeScript files
RUN npm run build

# Expose the port on which your Express app runs
EXPOSE 3000

# Command to run your application
ENTRYPOINT ["node", "dist/server.js"]
