# Stage 1: build
FROM node:20-alpine AS builder
WORKDIR /app

# Copy package.json & install deps
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build Next.js production
RUN npm run build

# Stage 2: production image
FROM node:20-alpine AS prod
WORKDIR /app

# Copy node_modules và build từ stage 1
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package*.json ./

EXPOSE 3000

# Run production server
CMD ["npm", "start"]
