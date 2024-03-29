#!/usr/bin/env bash

if [[ -z "${HEALTHCHECKS_PING_URL}" ]]; then
    printf "%s - Yikes - Missing HEALTHCHECKS_PING_URL environment variable" "$(date -u)"
    exit 0
fi

status_code=$(curl --connect-timeout 10 --max-time 30 -I -s -o /dev/null -w '%{http_code}' "${HEALTHCHECKS_PING_URL}")
if [[ ! ${status_code} =~ ^[2|3][0-9]{2}$ ]]; then
    printf "%s - Yikes - Heartbeat request failed, http code: %s" "$(date -u)" "${status_code}"
    exit 0
fi

printf "%s - Success - Heartbeat request received and processed successfully" "$(date -u)"
exit 0
