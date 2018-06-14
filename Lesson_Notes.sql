/*
We start with the basics of SELECT, FROM and LIMIT
SELECT contains the comumns we want seperated by commas or * for all columns
FROM is the name of the table we want to SELECT FROM
LIMIT tell the query how many rows to hand back
*/

SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;

/* now lets look at ordering data
ORDER BY will order data in accencing order
*/

SELECT id, occurred_at, total_amt_usd
 FROM orders
ORDER BY occurred_at
LIMIT 10;

/* DESC will switch the order to descending*/

SELECT id, account_id, total_amt_usd
 FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

SELECT id, account_id, total
 FROM orders
ORDER BY total
LIMIT 20;

/* now we add a second lever to the ORDER BY
we first order by data and then by amount in descending order
*/
SELECT total_amt_usd, occurred_at
	FROM orders
ORDER BY occurred_at, total_amt_usd DESC

/* now we have the where clause. I goes after FROM but before ORDER and LIMIT
When searching for numric values you can use < > = <= >= !=
*/
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
ORDER BY gloss_amt_usd
LIMIT 100;
/* when searching for non-numeric you need to put the name in single quotes */
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil'
LIMIT 20;

/* now lets make a derived column where we do some simple math to make a new value */

SELECT
	id,
    account_id,
    standard_amt_usd,
    standard_qty,
    standard_amt_usd / standard_qty AS unit_price
 FROM orders
 LIMIT 10;
/* you dont need to preselct the values if you don't want them in your final output */
 SELECT
	id,
    account_id,
     poster_amt_usd/ (standard_amt_usd + gloss_amt_usd + poster_amt_usd) *100 AS poster_percent
 FROM orders
 LIMIT 10;
