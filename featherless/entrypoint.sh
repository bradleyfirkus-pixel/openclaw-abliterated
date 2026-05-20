#!/usr/bin/env bash
set -euo pipefail

: "${FEATHERLESS_MODEL:=huihui-ai/Qwen3-8B-abliterated}"

mkdir -p /data/workspace/default
cp /app/SOUL.md /data/workspace/default/SOUL.md

node <<'NODE'
const fs = require("fs");

const model = process.env.FEATHERLESS_MODEL || "huihui-ai/Qwen3-8B-abliterated";
const apiKey = process.env.FEATHERLESS_API_KEY || "";

let cfg = fs.readFileSync("/app/openclaw.template.json", "utf8");
cfg = cfg.replaceAll("__FEATHERLESS_MODEL__", model);
cfg = cfg.replaceAll("__FEATHERLESS_API_KEY__", apiKey);

fs.writeFileSync("/data/openclaw.json", cfg);
NODE

echo "Starting OpenClaw Abliterated"
echo "Port: ${PORT:-18789}"
echo "Model: ${FEATHERLESS_MODEL}"

exec openclaw gateway run \
  --allow-unconfigured \
  --bind lan \
  --port "${PORT:-18789}"
