#!/bin/bash
# Start data collection services manually

echo "Starting data collection services..."

# Kill any existing processes
pkill -f "streamer.py"
pkill -f "futures_metrics_streamer.py"
pkill -f "ob_streamer.py"

# Start the main data streamer
cd /root/Crypto-Data-Service
nohup python3 streamer.py > streamer.log 2>&1 &
echo "Started streamer.py (PID: $!)"

# Start futures metrics streamer
nohup python3 futures_metrics_streamer.py > futures.log 2>&1 &
echo "Started futures_metrics_streamer.py (PID: $!)"

# Start orderbook streamer
nohup python3 ob_streamer.py > orderbook.log 2>&1 &
echo "Started ob_streamer.py (PID: $!)"

# Start macro data fetcher
nohup python3 macro_fetch.py > macro.log 2>&1 &
echo "Started macro_fetch.py (PID: $!)"

echo "All services started. Check logs for status."
echo "Streamer log: tail -f /root/Crypto-Data-Service/streamer.log"
echo "Futures log: tail -f /root/Crypto-Data-Service/futures.log"
echo "Orderbook log: tail -f /root/Crypto-Data-Service/orderbook.log"
echo "Macro log: tail -f /root/Crypto-Data-Service/macro.log"
