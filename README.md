# SQL Practice

This repo contains SQL tasks that I solve to practice and improve my SQL skills.
I solve every task in both **PostgreSQL** and **SQL Server**, so I can see how the two databases are different.

## Database

All tasks use **videoezy**, a DVD rental sample database (Pagila schema),
with tables like `film`, `customer`, `rental`, `payment` and `inventory`.

Every task is solved twice:
- `postgresql/` – PostgreSQL version
- `sql-server/` – SQL Server version

## Tasks

| # | Task | Main concepts | PostgreSQL | SQL Server |
|---|------|---------------|------------|------------|
| 1 | Top 10 customers by payment | JOIN, GROUP BY, SUM | [link](postgresql/videoezy/01_top_customers_by_payment.sql) | [link](sql-server/videoezy/01_top_customers_by_payment.sql) |
| 2 | Films per category | COUNT, AVG, ROUND | [link](postgresql/videoezy/02_films_per_category.sql) | [link](sql-server/videoezy/02_films_per_category.sql) |
| 3 | Top 3 rented films per category | CTE, DENSE_RANK | [link](postgresql/videoezy/03_top3_films_per_category.sql) | [link](sql-server/videoezy/03_top3_films_per_category.sql) |
| 4 | Monthly revenue with running total | SUM OVER, LAG, date truncation | [link](postgresql/videoezy/04_monthly_revenue_running_total.sql) | [link](sql-server/videoezy/04_monthly_revenue_running_total.sql) |
| 5 | Average days between rentals | LAG, PARTITION BY, date difference | [link](postgresql/videoezy/05_days_between_rentals.sql) | [link](sql-server/videoezy/05_days_between_rentals.sql) |
| 6 | Films never rented | NOT EXISTS (anti-join), CASE WHEN EXISTS | [link](postgresql/videoezy/06_films_never_rented.sql) | [link](sql-server/videoezy/06_films_never_rented.sql) |

## What I learned

- **NULL is not zero.** In tasks 4 and 5, the first month and the first rental have no previous value.
  When I replaced NULL with 0, the averages and changes became wrong. `AVG` skips NULL, so it is better to keep NULL.
- **DENSE_RANK vs RANK vs ROW_NUMBER.** `DENSE_RANK` gives the same rank to ties and does not skip numbers (1, 2, 2, 3).
  `RANK` skips (1, 2, 2, 4). `ROW_NUMBER` never gives ties, so I use it when I need exactly N rows.
- **Two kinds of ORDER BY.** `ORDER BY` inside `OVER()` only controls the calculation.
  Only the final `ORDER BY` controls the order of the result.
- **Sorting dates as text is dangerous.** A month formatted as `MM-yyyy` sorts in the wrong order across years.
  The format `yyyy-MM` sorts correctly.
- **Same function, different behaviour.** In SQL Server, `AVG` of integers returns an integer, so I multiply by `1.0` first.
  In PostgreSQL, `AVG` of integers already returns a decimal.
- **NOT EXISTS is the safest anti-join.** `NOT IN` returns no rows if the subquery contains a NULL.
  `LEFT JOIN ... IS NULL` gave wrong results when the join went through two tables (film → inventory → rental).
