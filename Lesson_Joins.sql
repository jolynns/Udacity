SELECT *
FROM accounts
JOIN orders
ON orders.account_id = accounts.id

SELECT orders.standard_qty, orders.gloss_qty,
       orders.poster_qty,  accounts.website,
       accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id

/* here we have aliases and joins */

SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
WHERE a.name LIKE 'Walmart'
ORDER BY name

/* these are all inner joins and only return tows that are in both tables */

SELECT r.name region, s.name sales_reps, a.name accounts
FROM region r
JOIN sales_reps s
ON  r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY a.name;

SELECT r.name region, a.name accounts,
        o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON  r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
ORDER BY a.name;

/* We can use outter joins to get data that only resides in one table */

/* Questions
1.	Provide a table that provides the region for each sales_rep along with their associated accounts.
This time only for the Midwest region. Your final table should include three columns:
the region name, the sales rep name, and the account name.
Sort the accounts alphabetically (A-Z) according to account name.*/
SELECT r.name region, s.name reps, a.name accounts
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN region r
ON r.id = s.region_id
WHERE r.name LIKE 'Midwest' /* WHERE r.name = 'Midwest'*/
ORDER BY accounts;

/*2.	Provide a table that provides the region for each sales_rep along with their associated accounts.
This time only for accounts where the sales rep has a first name starting with S and
in the Midwestregion. Your final table should include three columns: the region name,
the sales rep name, and the account name. Sort the accounts alphabetically
(A-Z) according to account name. */
SELECT r.name region, s.name reps, a.name accounts
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN region r
ON r.id = s.region_id
WHERE r.name LIKE 'Midwest' AND s.name LIKE 'S%'
ORDER BY accounts;

5 results

/*3.	Provide a table that provides the region for each sales_rep along with their associated accounts.
This time only for accounts where the sales rep has a last name starting
with K and in the Midwestregion. Your final table should include three columns:
the region name, the sales rep name, and the account name. Sort the accounts
alphabetically (A-Z) according to account name.*/
SELECT r.name region, s.name reps, a.name accounts
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN region r
ON r.id = s.region_id
WHERE r.name LIKE 'Midwest' AND s.name LIKE '% K%'
ORDER BY accounts;

13 Results

/*4.	Provide the name for each region for every order, as well as the account
name and the unit pricethey paid (total_amt_usd/total) for the order. However,
you should only provide the results if the standard order quantity exceeds 100.
Your final table should have 3 columns: region name, account name, and unit price.
In order to avoid a division by zero error, adding .01 to the denominator
here is helpful total_amt_usd/(total+0.01). */

SELECT r.name region, a.name accounts, o.total_amt_usd/ (o.total + 0.01) unit_price
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
WHERE o.standard_qty > 100;

/*5.	Provide the name for each region for every order, as well as the account
name and the unit pricethey paid (total_amt_usd/total) for the order. However,
you should only provide the results if the standard order quantity exceeds 100
and the poster order quantity exceeds 50. Your final table should have 3 columns:
region name, account name, and unit price. Sort for the smallest unit price first.
In order to avoid a division by zero error, adding .01 to the denominator here
is helpful (total_amt_usd/(total+0.01). */

SELECT r.name region, a.name accounts, o.total_amt_usd/ (o.total + 0.01) unit_price
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
WHERE o.standard_qty > 100 AND poster_qty > 50
ORDER BY unit_price

835 results

/*6.	Provide the name for each region for every order, as well as the account
name and the unit pricethey paid (total_amt_usd/total) for the order. However,
you should only provide the results if the standard order quantity exceeds 100
and the poster order quantity exceeds 50. Your final table should have 3 columns:
region name, account name, and unit price. Sort for the largest unit pricefirst.
In order to avoid a division by zero error, adding .01 to the denominator
here is helpful (total_amt_usd/(total+0.01). */

SELECT r.name region, a.name accounts, o.total_amt_usd/ (o.total + 0.01) unit_price
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
WHERE o.standard_qty > 100 AND poster_qty > 50
ORDER BY unit_price DESC

/*7.	What are the different channels used by account id 1001? Your final table
should have only 2 columns: account name and the different channels. You can
try SELECT DISTINCT to narrow down the results to only the unique values.*/

SELECT DISTINCT account_id, channel
FROM web_events
WHERE account_id = '1001'

6 results

/*8.	Find all the orders that occurred in 2015. Your final table should have 4
columns: occurred_at, account name, order total, and order total_amt_usd.*/

SELECT o.occurred_at, a.name accounts, o.total, o.total_amt_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2015-12-31'
ORDER BY o.occurred_at DESC;

98431
