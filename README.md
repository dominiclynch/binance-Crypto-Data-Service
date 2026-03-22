# Binance Crypto Data Service

Real-time market data aggregation service for Binance Futures. Streams candles, order book snapshots, funding rates, and macro indices into SQLite, then serves them via FastAPI endpoints.

## What It Does

- Polls 1-minute candles for 100+ tokens every 60 seconds
- Aggregates to 15-minute buckets for ML consumption
- Captures order book bid/ask imbalance snapshots every 30 seconds
- Streams open interest and funding rates every 5 minutes
- Fetches daily macro data (DXY, VIX) from Yahoo Finance
- Serves everything via authenticated REST API

## API Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /candles/{symbol}` | Historical candle data with timeframe filtering |
| `GET /orderbook/{symbol}` | Order book imbalance snapshots |
| `GET /futures/{symbol}` | Open interest and funding rates |
| `GET /macro` | DXY and VIX latest values |
| `GET /healthz` | Service health with data freshness |

## Data Flow

```
Binance API  -->  Streamers (async)  -->  SQLite DBs  -->  FastAPI  -->  ML Models / Dashboards
                      |                      |
                 candles (1m/15m)        4 databases:
                 order book depth        candles.db
                 OI + funding            orderbook.db
                 DXY + VIX              futures.db
                                        macro.db
```

## Key Files

| File | Purpose |
|------|---------|
| `api.py` | FastAPI server with all endpoints |
| `streamer.py` | Candle polling and aggregation |
| `ob_streamer.py` | Order book snapshot capture |
| `futures_metrics_streamer.py` | OI and funding rate polling |
| `macro_fetch.py` | DXY/VIX daily fetch |
| `watchdog.sh` | Health check and auto-restart |

## Tech Stack

- **Python** — FastAPI, aiosqlite, python-binance, pandas
- **Storage** — SQLite (4 databases)
- **Macro Data** — yfinance, Yahoo Finance CSV

## Setup

```bash
pip install -r requirements.txt
export BINANCE_API_KEY=your_key
export BINANCE_API_SECRET=your_secret
python api.py
```

## License

MIT