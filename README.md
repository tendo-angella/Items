# Items API

A small FastAPI app with two endpoints, backed by SQLite.

Framework: **FastAPI** (not Flask).

## Install

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

## Run the app

```bash
uvicorn app.main:app --reload
```

Open http://127.0.0.1:8000/docs to try the endpoints.

## Endpoints

| Method | Path   | What it does                                              |
|--------|--------|-----------------------------------------------------------|
| POST   | /items | Create an item (`name` required, `description` optional)  |
| GET    | /items | List all items                                            |

Example:

```bash
curl -X POST http://127.0.0.1:8000/items \
  -H "Content-Type: application/json" \
  -d '{"name": "Pen", "description": "Blue pen"}'
```

Errors: an empty or missing `name` returns `422`. A database failure returns `500` with a short message.

## Run the tests

```bash
python -m pytest
```

## SQL (Task 2)

The queries are in the `sql/` folder. Each file has a one-line note on the reasoning.

- `sql/setup.sql`: tables and sample data
- `sql/01_orders_per_user.sql`: each user's name with their order count (join)
- `sql/02_orders_by_status.sql`: order count and total amount per status (aggregation)
- `sql/03_above_average_users.sql`: users with an order above the average amount (subquery)

To try them:

```bash
sqlite3 sql.db < sql/setup.sql
sqlite3 sql.db < sql/01_orders_per_user.sql
```

## Project layout

- `app/main.py`: creates the app and handles database errors
- `app/database.py`: SQLite connection and session
- `app/models.py`: database table
- `app/schemas.py`: request and response shapes and validation
- `app/routers/items.py`: the endpoints
- `tests/`: pytest tests (use an in-memory database)
- `sql/`: SQL queries