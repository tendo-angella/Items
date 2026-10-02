-- Reasoning: GROUP BY status gives one row per status, with COUNT and SUM calculated for each group.
SELECT status,
       COUNT(*) AS order_count,
       SUM(total_amount) AS total_sum
FROM orders
GROUP BY status;