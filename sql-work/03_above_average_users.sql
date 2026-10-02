-- Reasoning: The inner subquery finds the average order amount, and IN returns each matching user once.
SELECT id, name, email
FROM users
WHERE id IN (
    SELECT user_id
    FROM orders
    WHERE total_amount > (SELECT AVG(total_amount) FROM orders)
);