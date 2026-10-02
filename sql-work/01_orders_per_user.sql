-- Reasoning: LEFT JOIN keeps users with no orders, and COUNT(o.id) gives them 0 instead of 1.
SELECT u.name, COUNT(o.id) AS total_orders
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
GROUP BY u.id, u.name;