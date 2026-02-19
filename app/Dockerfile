# --- Stage 1: Build & Prepare ---
FROM node:20-alpine AS builder
WORKDIR /app

# Copy package files to install dependencies
COPY package*.json ./

# Install ALL dependencies (needed if you have a build/compilation step)
RUN npm ci

# Copy source code
COPY . .

# If you use TypeScript or a bundler, run the build here
# RUN npm run build 

# --- Stage 2: Production Runtime ---
FROM node:20-alpine AS prod

ENV NODE_ENV=production
WORKDIR /app

# Install tini for proper signal handling (CTRL+C, SIGTERM)
RUN apk add --no-cache tini

# Copy only the files needed for production from the builder stage
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/src ./src

# Install ONLY production dependencies and clean cache to save space
RUN npm ci --only=production && npm cache clean --force

# Use the non-root 'node' user for security
USER node

EXPOSE 3000

# Entrypoint handles process signals, CMD starts the app
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["node", "src/index.js"]