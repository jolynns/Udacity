
/*step 1*/
SELECT DATE_TRUNC('day',occurred_at) AS day,
   channel, COUNT(*) as events
FROM web_events
GROUP BY 1,2
ORDER BY 3 DESC;

/*step 2*/
SELECT *
FROM (SELECT DATE_TRUNC('day',occurred_at) AS day,
           channel, COUNT(*) as events
     FROM web_events
     GROUP BY 1,2
     ORDER BY 3 DESC) sub;

/*step 3*/


SELECT channel, AVG(events) AS avg_events
FROM
    (SELECT channel, DATE_TRUNC('day', occurred_at) AS day,
    COUNT(*) as events
    FROM web_events
    GROUP BY 1, 2) sub
GROUP BY 1
ORDER BY 2 DESC


/* seccond one */
SELECT MIN(DATE_TRUNC('month', occurred_at))
FROM orders

SELECT SUM(total_amt_usd) total_usd, AVG(standard_qty) std_avg, AVG(gloss_qty) gls_avg, AVG(poster_qty) pst_avg
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = (SELECT MIN(DATE_TRUNC('month', occurred_at))
FROM orders)

SELECT r_name, MAX(tot_sales)
FROM
    (SELECT s.name s_rep, r.name r_name, MAX(o.total_amt_usd) tot_sales
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    JOIN sales_reps s
    ON a.sales_rep_id = s.id
    JOIN region r
    ON r.id = s.region_id
    GROUP BY 1,2) sub1
GROUP BY 1
