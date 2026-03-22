# Binance Crypto Data Service

Ingests live Binance market data and serves it via a REST API backed by SQLite.

## What It Does

- Streams 1m and 15m candles for 200+ tokens into SQLite
- Collects open interest, funding rates, and order book snapshots
- Fetches daily macro indices (DXY, VIX) via Yahoo Finance
- Exposes `/candles`, `/orderbook`, `/oi`, `/funding`, and `/macro/latest` REST endpoints

## Tech Stack

- **Python:** FastAPI, python-binance, aiosqlite, yfinance, Polars
- **Storage:** SQLite

## Setup

```bash
pip install -r requirements.txt
export BINANCE_API_KEY=your_key
export BINANCE_API_SECRET=your_secret
python streamer.py &
uvicorn api:app --host 0.0.0.0 --port 8001
```

## License

MIT
