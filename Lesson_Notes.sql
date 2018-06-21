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

 /* Now lets look at LIKE
 Here we find account names that start with C, have one in the middle or
 end in s */
SELECT *
FROM accounts
WHERE name LIKE 'C%'

SELECT *
FROM accounts
WHERE name LIKE '%one%'

SELECT *
FROM accounts
WHERE name LIKE '%s'

/* The IN operator lets you select specific info */
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom')

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords')

/* if you want everything but just add a NOT in front of IN or LIKE */
SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords')

SELECT *
FROM accounts
WHERE name NOT LIKE '%s'

/* if you want to limit your where clause you can use AND */

SELECT *
FROM orders
WHERE standard_qty > 1000
AND poster_qty = 0
AND gloss_qty = 0

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%'
AND name NOT LIKE '%s';

SELECT *
FROM web_events
WHERE channel IN ('organic','adwords')
AND occurred_at BETWEEN '2016-01-01' and '2016-12-30'
ORDER BY occurred_at

/* if you want to be more inclusive use OR */

SELECT id
FROM orders
WHERE (gloss_qty > 4000 OR poster_qty > 4000)

SELECT *
FROM orders
WHERE (gloss_qty > 1000 OR poster_qty > 1000)
AND standard_qty = 0

SELECT name, primary_poc
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
AND (primary_poc LIKE '%ana%'
     OR primary_poc LIKE '%Ana%')
AND primary_poc NOT LIKE '%eana%';

recap:

Statement	How to Use It	Other Details
SELECT	SELECT Col1, Col2, ...	Provide the columns you want
FROM	FROM Table	Provide the table where the columns exist
LIMIT	LIMIT 10	Limits based number of rows returned
ORDER BY	ORDER BY Col	Orders table based on the column. Used with DESC.
WHERE	WHERE Col > 5	A conditional statement to filter your results
LIKE	WHERE Col LIKE '%me%'	Only pulls rows where column has 'me' within the text
IN	WHERE Col IN ('Y', 'N')	A filter for only rows with column of 'Y' or 'N'
NOT	WHERE Col NOT IN ('Y', 'N')	NOT is frequently used with LIKE and IN
AND	WHERE Col1 > 5 AND Col2 < 3	Filter rows where two or more conditions must be true
OR	WHERE Col1 > 5 OR Col2 < 3	Filter rows where at least one condition must be true
BETWEEN	WHERE Col BETWEEN 3 AND 5	Often easier syntax than using an AND
