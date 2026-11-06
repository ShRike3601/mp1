#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/../../VERSIONS.env"
K3S_IMAGE="rancher/k3s:${K3S_VERSION//+/-}"
k3d cluster create mp1 \
  --image "$K3S_IMAGE" \
  --servers 1 --agents 1 \
  --k3s-arg "--disable=traefik@server:*" \
  --k3s-arg "--disable=servicelb@server:*" \
  --k3s-arg "--disable=metrics-server@server:*"
kubectl label node k3d-mp1-agent-0 mp1/role=function --overwrite
kubectl taint node k3d-mp1-agent-0 mp1/role=function:NoSchedule --overwrite
