FROM node:24-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl dumb-init \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g openclaw@latest

WORKDIR /app

COPY featherless/entrypoint.sh /app/entrypoint.sh
COPY featherless/openclaw.template.json /app/openclaw.template.json
COPY featherless/SOUL.md /app/SOUL.md

RUN chmod +x /app/entrypoint.sh

ENV PORT=18789
ENV OPENCLAW_CONFIG_PATH=/data/openclaw.json
ENV OPENCLAW_STATE_DIR=/data

EXPOSE 18789

ENTRYPOINT ["dumb-init", "--"]
CMD ["/app/entrypoint.sh"]
