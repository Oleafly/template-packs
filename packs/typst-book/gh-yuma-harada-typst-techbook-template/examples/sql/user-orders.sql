SELECT
  users.id,
  users.name,
  COUNT(orders.id) AS order_count
FROM users
LEFT JOIN orders
  ON orders.user_id = users.id
GROUP BY
  users.id,
  users.name
ORDER BY
  users.id;
  