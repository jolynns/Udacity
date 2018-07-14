SELECT RIGHT(website, 3) AS domain, COUNT(*)
FROM accounts
GROUP BY domain

SELECT LEFT(UPPER(name), 1) AS first_letter, COUNT(*)
FROM accounts
GROUP BY first_letter
ORDER BY count DESC

SELECT RIGHT(name, 1) AS first_letter, COUNT(*),
	CASE WHEN RIGHT(name, 1) LIKE '[[:digit:]]' THEN 'num'
    ELSE 'letter' END AS type
FROM accounts
GROUP BY first_letter
ORDER BY count DESC

SELECT  COUNT(*),
	CASE WHEN RIGHT(UPPER(name), 1) IN( 'A','E','I','O','U') THEN 'vowel'
    ELSE 'letter' END AS type
FROM accounts
GROUP BY type
ORDER BY count DESC

SELECT  COUNT(*),
	CASE WHEN RIGHT(name, 1) IN('a','e','i','o','u', 'A','E','I','O','U') THEN 'vowel'
    ELSE 'letter' END AS type, COUNT(*)/351 *10 AS percent
FROM accounts
GROUP BY type
ORDER BY count DESC

SELECT SUM(vowels) vowels, SUM(other) other
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U')
                        THEN 1 ELSE 0 END AS vowels,
          CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U')
                       THEN 0 ELSE 1 END AS other
         FROM accounts) t1;



SELECT LEFT(primary_poc, POSITION(' ' IN primary_poc)-1) AS first,
    RIGHT(primary_poc, (CHAR_LENGTH(primary_poc) - POSITION(' ' IN primary_poc))) AS last
FROM accounts

SELECT LEFT(name, POSITION(' ' IN name)-1) AS last, RIGHT(name, (CHAR_LENGTH(name) - POSITION(' ' IN name))) AS first
FROM sales_reps


SELECT LOWER(first)||'.'||LOWER(last)||'@' || name||'.com' AS email
FROM
(SELECT LOWER(name) AS name, LEFT(primary_poc, POSITION(' ' IN primary_poc)-1) AS first,
    RIGHT(primary_poc, (CHAR_LENGTH(primary_poc) - POSITION(' ' IN primary_poc))) AS last
FROM accounts) t1;


SELECT LOWER(first)||'.'||LOWER(last)||'@' || name ||'.com' AS email
FROM
(SELECT replace( LOWER(name), ' ', '') AS name, LEFT(primary_poc, POSITION(' ' IN primary_poc)-1) AS first,
    RIGHT(primary_poc, (CHAR_LENGTH(primary_poc) - POSITION(' ' IN primary_poc))) AS last
FROM accounts) t1;

/* OR */

WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', name, '.com'), LEFT(LOWER(first_name), 1) || RIGHT(LOWER(first_name), 1) || LEFT(LOWER(last_name), 1) || RIGHT(LOWER(last_name), 1) || LENGTH(first_name) || LENGTH(last_name) || REPLACE(UPPER(name), ' ', '')
FROM t1;


WITH t1 AS
    (SELECT LEFT(date,2) AS mon,
    SUBSTR(date, 4, 2) AS day,
    SUBSTR(date,7,4) AS yr,
    RIGHT(date, CHAR_LENGTH(date) - POSITION(' ' IN date)) AS time_st
FROM sf_crime_data)
SELECT (yr ||'-'||mon||'-'||day||' '||time_st)::DATE AS form_date
FROM t1
