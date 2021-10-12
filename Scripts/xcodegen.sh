#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
XCODEGEN="${SCRIPT_DIR}/../Tools/xcodegen/bin/xcodegen"


"$XCODEGEN" --spec "${SCRIPT_DIR}/../project.yml" --project "${SCRIPT_DIR}/.."
