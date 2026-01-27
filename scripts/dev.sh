#!/bin/bash
# Dev server management for Anima Ex Mortali

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT_NAME="anima-ex-mortali"
PID_FILE="$PROJECT_DIR/.nuxt/dev.pid"
LOG_FILE="$PROJECT_DIR/.nuxt/dev.log"
PORT_FILE="$PROJECT_DIR/.nuxt/dev.port"

# Check if a port is used by this project
is_our_process() {
  local pid=$1
  local cwd=$(lsof -a -p $pid -d cwd -Fn 2>/dev/null | grep '^n' | cut -c2-)
  [[ "$cwd" == *"$PROJECT_NAME"* ]]
}

# Kill all processes from this project on any port
kill_our_processes() {
  local killed=false
  for port in $(seq 3000 3010); do
    local pids=$(lsof -ti:$port 2>/dev/null)
    for pid in $pids; do
      if is_our_process $pid; then
        kill -9 $pid 2>/dev/null
        echo "Killed process $pid on port $port"
        killed=true
      fi
    done
  done
  $killed && sleep 0.5
}

# Find first available port starting from 3000
find_available_port() {
  for port in $(seq 3000 3010); do
    local pids=$(lsof -ti:$port 2>/dev/null)
    if [ -z "$pids" ]; then
      echo $port
      return
    fi
  done
  echo "No available port found" >&2
  exit 1
}

start() {
  # Check if already running via PID file
  if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    local port=$(cat "$PORT_FILE" 2>/dev/null || echo "unknown")
    echo "Dev server already running (PID: $(cat "$PID_FILE"), port: $port)"
    exit 1
  fi

  # Kill any existing processes from this project
  kill_our_processes

  # Find first available port
  local PORT=$(find_available_port)
  echo "Using port $PORT"

  # Ensure .nuxt directory exists
  mkdir -p "$PROJECT_DIR/.nuxt"

  # Start server in background with explicit port
  cd "$PROJECT_DIR"
  nohup npx nuxt dev --port $PORT > "$LOG_FILE" 2>&1 &
  PID=$!
  echo $PID > "$PID_FILE"
  echo $PORT > "$PORT_FILE"

  # Wait briefly and check if process survived startup
  sleep 0.5
  if ! kill -0 "$PID" 2>/dev/null; then
    echo "Dev server failed to start. Log output:"
    cat "$LOG_FILE"
    rm -f "$PID_FILE" "$PORT_FILE"
    exit 1
  fi

  echo "Dev server started (PID: $PID)"
  echo "URL: http://localhost:$PORT"
  echo "Logs: $LOG_FILE"
}

stop() {
  local stopped=false

  # Kill by PID file if exists
  if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if kill -0 "$PID" 2>/dev/null; then
      kill -- -"$PID" 2>/dev/null || kill "$PID" 2>/dev/null
      stopped=true
      echo "Dev server stopped (PID: $PID)"
    fi
    rm -f "$PID_FILE" "$PORT_FILE"
  fi

  # Also kill any orphaned processes from this project
  kill_our_processes && stopped=true

  if [ "$stopped" = false ]; then
    echo "Dev server was not running"
  fi
}

status() {
  if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    local port=$(cat "$PORT_FILE" 2>/dev/null || echo "unknown")
    echo "running (PID: $(cat "$PID_FILE"), port: $port)"
    exit 0
  else
    [ -f "$PID_FILE" ] && rm -f "$PID_FILE" "$PORT_FILE"
    echo "stopped"
    exit 1
  fi
}

case "$1" in
  start) start ;;
  stop) stop ;;
  status) status ;;
  *) echo "Usage: $0 {start|stop|status}" && exit 1 ;;
esac
