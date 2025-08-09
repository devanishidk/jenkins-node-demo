# Use Node.js LTS
FROM node:18

# Create app directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install --production

# Copy app source code
COPY . .

# Expose app port
EXPOSE 3000

# Run the app
CMD ["node", "app.js"]
