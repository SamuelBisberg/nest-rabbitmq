FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run build

FROM node:22-alpine AS runner

WORKDIR /app

COPY --from=builder /app/package*.json ./

RUN npm ci --only=production

COPY --from=builder /app/dist ./dist

CMD ["npm", "run", "start:prod"]
