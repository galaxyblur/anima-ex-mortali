#!/bin/bash
# Dev server management for Anima Ex Mortali

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PID_FILE="$PROJECT_DIR/.nuxt/dev.pid"
LOG_FILE="$PROJECT_DIR/.nuxt/dev.log"
PORT=3000

kill_port() {
  local port=$1
  local pids=$(lsof -ti:$port 2>/dev/null)
  for pid in $pids; do
    # Only kill if process was started from this project directory
    local cwd=$(lsof -a -p $pid -d cwd -Fn 2>/dev/null | grep '^n' | cut -c2-)
    if [ "$cwd" = "$PROJECT_DIR" ]; then
      kill -9 $pid 2>/dev/null
      echo "Killed process $pid (from this project)"
    else
      echo "Skipping process $pid (from $cwd)"
    fi
  done
  sleep 0.5
}

start() {
  # Check if already running via PID file
  if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    echo "Dev server already running (PID: $(cat "$PID_FILE"))"
    exit 1
  fi

  # Kill anything on our port (handles orphaned processes)
  if lsof -ti:$PORT >/dev/null 2>&1; then
    echo "Port $PORT in use - checking for processes from this project..."
    kill_port $PORT
  fi

  # Ensure .nuxt directory exists
  mkdir -p "$PROJECT_DIR/.nuxt"

  # Start server in background with explicit port
  cd "$PROJECT_DIR"
  nohup npx nuxt dev --port $PORT > "$LOG_FILE" 2>&1 &
  PID=$!
  echo $PID > "$PID_FILE"

  # Wait briefly and check if process survived startup
  sleep 0.5
  if ! kill -0 "$PID" 2>/dev/null; then
    echo "Dev server failed to start. Log output:"
    cat "$LOG_FILE"
    rm -f "$PID_FILE"
    exit 1
  fi

  echo "Dev server started (PID: $PID)"
  echo "Logs: $LOG_FILE"
}

stop() {
  local stopped=false

  # Kill by PID file if exists
  if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if kill -0 "$PID" 2>/dev/null; then
      # Kill process group to get all children
      kill -- -"$PID" 2>/dev/null || kill "$PID" 2>/dev/null
      stopped=true
      echo "Dev server stopped (PID: $PID)"
    fi
    rm -f "$PID_FILE"
  fi

  # Also kill anything still on the port (catches orphans)
  if lsof -ti:$PORT >/dev/null 2>&1; then
    kill_port $PORT
    stopped=true
    echo "Cleaned up processes on port $PORT"
  fi

  if [ "$stopped" = false ]; then
    echo "Dev server was not running"
  fi
}

status() {
  if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    echo "running (PID: $(cat "$PID_FILE"))"
    exit 0
  else
    [ -f "$PID_FILE" ] && rm "$PID_FILE"  # Clean stale PID
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
