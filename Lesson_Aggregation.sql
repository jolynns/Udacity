SELECT SUM(standard_qty) AS standard,
       SUM(gloss_qty) AS gloss,
       SUM(poster_qty) AS poster
     FROM orders;

/* Lets start simple*/
SELECT SUM(poster_qty) AS poster
FROM orders;

SELECT SUM(standard_qty) AS standard
FROM orders;

SELECT SUM(total_amt_usd) AS total_sales
FROM orders;

SELECT SUM(standard_amt_usd) AS standard,
	   SUM(gloss_amt_usd) AS gloss
FROM orders;

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;

/* lets look at min, max and avg*/

SELECT MIN(occurred_at) AS earlest_order
FROM orders;

SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

SELECT MAX(occurred_at) AS latest
FROM web_events;

SELECT occurred_at
FROM web_events
ORDER BY occurred_at
LIMIT 1;

SELECT AVG(standard_qty) AS standard,
		AVG(standard_amt_usd) AS std_sales,
		AVG(gloss_qty) AS gloss,
        AVG(gloss_amt_usd) AS gls_sales,
        AVG(poster_qty) AS poster,
        AVG(poster_amt_usd) AS pst_sales
FROM orders;

/* this gets the median (middle value) for total_amt_usd
It only works because we know how many columns and set the limit to half that number
 */
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

/* now lets look at grouping
when we aggragte data using sum but want to group this by account_id
it looks like This*/
SELECT account_id,
    SUM(standard_qty) AS std_sum,
    SUM(gloss_qty) AS gls_sum,
    SUM(poster_qty) AS pst_sum
FROM Orders
GROUP BY account_id
ORDER by account_id

/* quizz time:
Which account (by name) placed the earliest order?
 Your solution should have the account name and the date of the order.
 */

SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON o.account_id = a.id
ORDER BY o.occurred_at
LIMIT 1

/*Find the total sales in usd for each account. You should include two columns
- the total sales for each company's orders in usd and the company name.
*/

SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY a.name

/* Via what channel did the most recent (latest) web_event occur,
which account was associated with this web_event? Your query should return only
three values - the date, channel, and account name.
*/

SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at DESC
LIMIT 1;

/* Find the total number of times each type of channel from the web_events was used.
Your final table should have two columns - the channel and the number of times
 the channel was used.
*/

SELECT channel, COUNT(channel) channel_count
FROM web_events
GROUP BY channel;

/*Who was the primary contact associated with the earliest web_event? */

SELECT  a.primary_poc
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

/*What was the smallest order placed by each account in terms of total usd.
Provide only two columns - the account name and the total usd. Order from
smallest dollar amounts to largest. */

SELECT a.name, MIN(o.total_amt_usd) min_order
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY min_order;

/*Find the number of sales reps in each region. Your final table should have two
columns - the region and the number of sales_reps. Order from fewest reps to
most reps.*/

SELECT r.name, COUNT(s.name) acct_count
FROM sales_reps s
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
ORDER BY acct_count;


SELECT a.name,
	AVG(o.standard_qty) avg_standard,
    AVG(o.gloss_qty) avg_gloss,
    AVG(o.poster_qty) avg_poster
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name


SELECT a.name,
	AVG(o.standard_amt_usd) avg_standard,
    AVG(o.gloss_amt_usd) avg_gloss,
    AVG(o.poster_amt_usd) avg_poster
FROM accounts a
JOIN orders o
ON o.account_id = a.id
GROUP BY a.name

SELECT s.name,
		w.channel,
        COUNT(w.channel)
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name, w.channel
ORDER BY count DESC

SELECT r.name,
		w.channel,
        COUNT(w.channel)
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY r.name, w.channel
ORDER BY count DESC

/* DISTINCT*/

SELECT DISTINCT a.name AS acct,  r.name
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON r.id = s.region_id
ORDER BY acct

SELECT DISTINCT s.name AS srep,  a.name
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
ORDER BY srep

/* HAVING*/
SELECT sales_rep_id, COUNT(name)
FROM accounts
GROUP BY sales_rep_id
HAVING COUNT(name) > 5

SELECT account_id, COUNT(total) oc
FROM orders
GROUP BY account_id
HAVING COUNT(total) > 20
ORDER BY oc

SELECT account_id, count(total) oc
FROM orders
GROUP BY account_id
ORDER BY oc DESC
LIMIT 1;

SELECT a.name, SUM(o.total_amt_usd) tot_spend
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY tot_spend

SELECT a.name, SUM(o.total_amt_usd) tot_spend
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY tot_spend

SELECT a.name, SUM(o.total_amt_usd) tot_spend
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY tot_spend DESC
LIMIT 1;

SELECT a.name, SUM(o.total_amt_usd) tot_spend
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY tot_spend
LIMIT 1;

SELECT a.name, COUNT(w.channel)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel LIKE 'facebook'
GROUP BY a.name
HAVING COUNT(w.channel) > 6
ORDER BY count

SELECT a.name, w.channel, COUNT(w.channel)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.name, w.channel
ORDER BY count DESC
LIMIT 10

/* DATE Trunk */

SELECT DATE_TRUNC('year',occurred_at) AS year,
	SUM(total_amt_usd)
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

SELECT DATE_Trunc('month',occurred_at) AS month,
	SUM(total_amt_usd)
FROM orders
WHERE occurred_at BETWEEN '2014-0101' AND '2017-0101'
GROUP BY 1
ORDER BY 2 DESC


SELECT DATE_Trunc('year',occurred_at) AS year,
	COUNT(*)
FROM orders
GROUP BY 1
ORDER BY 2 DESC

SELECT DATE_trunc('month',o.occurred_at) AS month, a.name AS name,
	COUNT(*)
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE a.name LIKE 'Walmart'
GROUP BY 1, 2
ORDER BY 3 DESC
limit 1
