CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    created_at TEXT
);

CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    total_amount REAL,
    status TEXT,
    created_at TEXT
);

CREATE TABLE order_items (
    id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_name TEXT,
    quantity INTEGER,
    unit_price REAL
);

INSERT INTO users VALUES
    (1, 'Alice', 'alice@example.com', '2026-01-01'),
    (2, 'Brian', 'brian@example.com', '2026-01-05'),
    (3, 'Carol', 'carol@example.com', '2026-01-10'),
    (4, 'David', 'david@example.com', '2026-01-15');

INSERT INTO orders VALUES
    (1, 1, 100.00, 'delivered', '2026-02-01'),
    (2, 1, 250.00, 'shipped',   '2026-02-05'),
    (3, 2,  80.00, 'pending',   '2026-02-07'),
    (4, 2,  40.00, 'delivered', '2026-02-09'),
    (5, 4, 500.00, 'delivered', '2026-02-11'),
    (6, 1,  60.00, 'pending',   '2026-02-12');

INSERT INTO order_items VALUES
    (1, 1, 'Pen',    10, 10.00),
    (2, 2, 'Book',    5, 50.00),
    (3, 5, 'Laptop',  1, 500.00);