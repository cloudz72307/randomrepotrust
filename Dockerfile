FROM node:20-alpine

RUN apk add --no-cache curl build-base bash git
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:$PATH"

RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app
COPY . /app

RUN pnpm install
RUN npm install -g tsx
ENV NODE_OPTIONS="--import tsx"
RUN pnpm -r build

EXPOSE 10000
ENV PORT=10000

CMD ["tsx", "devserver.ts"]
