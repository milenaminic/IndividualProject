'Checking tables'
SELECT * 
FROM [dbo].[CustomerData_csv]

SELECT *
FROM [dbo].[ItemData_csv]

SELECT *
FROM [dbo].[ItemData_csv]

'Replacing empty rows with NULL value (for each column) in each table'
UPDATE [dbo].[ItemData_csv]
SET  [SALEPRICE]= NULL
WHERE [SALEPRICE] = ''

SELECT COUNT(*)
FROM [dbo].[CustomerData_csv]
WHERE [HOBBY] = ''

SELECT COUNT(*)
FROM [dbo].[TransactionsData_csv]
WHERE [WEBBROWSER] = ''

UPDATE [dbo].[TransactionsData_csv]
SET  [WEBBROWSER]= NULL
WHERE  [WEBBROWSER]= ''


SELECT COUNT(*)
FROM [dbo].[TransactionsData_csv]
WHERE [PPC_ADD] = ''


UPDATE [dbo].[TransactionsData_csv]
SET [PPC_ADD] = NULL
WHERE  [PPC_ADD]= ''


SELECT COUNT(*)
FROM [dbo].[TransactionsData_csv]
WHERE [PURCHASE] = ''


UPDATE [dbo].[TransactionsData_csv]
SET  [PURCHASE]= NULL
WHERE [PURCHASE] = ''


SELECT COUNT(*)
FROM [dbo].[TransactionsData_csv]
WHERE [DISCOUNT] = ''

UPDATE [dbo].[TransactionsData_csv]
SET [DISCOUNT] = NULL
WHERE [DISCOUNT] = ''

SELECT COUNT(*)
FROM [dbo].[TransactionsData_csv]
WHERE  [PAYMENT]= ''

UPDATE [dbo].[TransactionsData_csv]
SET [PAYMENT] = NULL
WHERE  [PAYMENT]= ''

SELECT COUNT(*)
FROM [dbo].[TransactionsData_csv]
WHERE [WAREHOUSE] = ''


UPDATE [dbo].[TransactionsData_csv]
SET [WAREHOUSE] = NULL
WHERE [WAREHOUSE] = ''


SELECT COUNT(*)
FROM [dbo].[TransactionsData_csv]
WHERE [REVIEW] = ''

UPDATE [dbo].[TransactionsData_csv]
SET  [REVIEW]= NULL
WHERE  [REVIEW]= ''

SELECT COUNT(*)
FROM [dbo].[TransactionsData_csv]
WHERE  [TIMESTAMP] = ''

'Check if we have duplicate rows'

SELECT [USERID],[GENDER],[DOB],[COUNTRY],[EDUCATION],[HOBBY], COUNT(*) AS QTY
FROM [dbo].[CustomerData_csv]
GROUP BY [USERID],[GENDER],[DOB],[COUNTRY],[EDUCATION],[HOBBY]
HAVING COUNT(*)>1
ORDER BY [USERID]

SELECT [ITEM],[CATEGORY],[COLOR],[SUPLID],[PURCHASEPRICE],[SALEPRICE], COUNT(*) AS QTY
FROM [dbo].[ItemData_csv]
GROUP BY [ITEM],[CATEGORY],[COLOR],[SUPLID],[PURCHASEPRICE],[SALEPRICE]
HAVING COUNT(*)>1

SELECT [ITEM],[CATEGORY],[COLOR], COUNT(*) AS QTY   'row where tem solumn is 383478 is problematic and duplicated so we need to clean it'
FROM [dbo].[ItemData_csv]
GROUP BY [ITEM],[CATEGORY],[COLOR]
HAVING COUNT(*)>1



SELECT [USERID],[WEBBROWSER],[PPC_ADD],[ITEM],[PURCHASE],[QTY],[DISCOUNT],[PAYMENT],[WAREHOUSE],[SHIPDAYS],[DELIVERYDATE],[REVIEW],[RATING],[TRACKNO],[TIMESTAMP], COUNT(*) AS QTY
FROM [dbo].[TransactionsData_csv]
GROUP BY  [USERID],[WEBBROWSER],[PPC_ADD],[ITEM],[PURCHASE],[QTY],[DISCOUNT],[PAYMENT],[WAREHOUSE],[SHIPDAYS],[DELIVERYDATE],[REVIEW],[RATING],[TRACKNO],[TIMESTAMP]
HAVING COUNT(*)>1
ORDER BY [USERID]

SELECT [USERID], COUNT(*) AS QTY
FROM [dbo].[CustomerData_csv]
GROUP BY [USERID]
HAVING COUNT(*)>1
ORDER BY [USERID]

SELECT [USERID],[ITEM],[TRACKNO], COUNT(*) AS QTY
FROM [dbo].[TransactionsData_csv]
GROUP BY  [USERID],[ITEM],[TRACKNO]
HAVING COUNT(*)>1

'Delete duplicate rows'

SELECT DISTINCT *
INTO [dbo].[ItemData_csv_duplicate]
FROM [dbo].[ItemData_csv]
GROUP BY [ITEM],[CATEGORY],[COLOR],[SUPLID],[PURCHASEPRICE],[SALEPRICE]

SELECT COUNT(*)
FROM [dbo].[ItemData_csv_duplicate]

DROP TABLE [dbo].[ItemData_csv]



'Change a name of table by doing right click on table name and rename it'
SELECT COUNT(*)
FROM [dbo].[ItemData_csv]

'Round purchaseprice to two decimal places'                                  -----?----
SELECT * FROM [dbo].[ItemData_csv] WHERE [ITEM] = '100026'

SELECT [ITEM],  ROUND([PURCHASEPRICE],2) FROM [dbo].[ItemData_csv]




SELECT * FROM [dbo].[ItemData_csv] WHERE [SUPLID] IS NULL AND (
SELECT COUNT(*) FROM [dbo].[ItemData_csv] 


'Delete first row then every 2nd row. My assume is that we need to delete first row for each item because there are a lot of null values and it should be unique identifier of item'

DELETE TOP(1) FROM [dbo].[ItemData_csv]

ALTER TABLE [dbo].[ItemData_csv] ADD ID INT IDENTITY(1,1) NOT NULL

SELECT * FROM [dbo].[ItemData_csv]
WHERE ID NOT IN (SELECT MIN(ID) FROM [dbo].[ItemData_csv] GROUP BY [ITEM],[CATEGORY],[COLOR],[PURCHASEPRICE],[SALEPRICE])

SELECT MAX(ID) as MAXRECID FROM [dbo].[ItemData_csv] GROUP BY [ITEM],[CATEGORY],[COLOR],[PURCHASEPRICE],[SALEPRICE]

SELECT * FROM [dbo].[ItemData_csv] WHERE ID NOT IN (SELECT MAX(ID) as MAXRECID FROM [dbo].[ItemData_csv] GROUP BY [ITEM],[CATEGORY],[COLOR],[PURCHASEPRICE],[SALEPRICE])
DELETE FROM [dbo].[ItemData_csv] WHERE ID NOT IN (SELECT MAX(ID) as MAXRECID FROM [dbo].[ItemData_csv] GROUP BY [ITEM],[CATEGORY],[COLOR],[PURCHASEPRICE],[SALEPRICE])

ALTER TABLE [dbo].[ItemData_csv] DROP COLUMN ID


SELECT *FROM [dbo].[ItemData_csv] 
SELECT *FROM [dbo].[CustomerData_csv]
SELECT *FROM [dbo].[TransactionsData_csv]

SELECT DISTINCT REVIEW FROM TransactionsData_csv 

 
SELECT COUNT(DISTINCT [USERID]) FROM [dbo].[TransactionsData_csv]
SELECT COUNT(*) FROM [dbo].[TransactionsData_csv]


SELECT * FROM [dbo].[TransactionsData_csv] WHERE [RATING] > '5'

SELECT * FROM [dbo].[TransactionsData_csv] WHERE [USERID] = '27730' AND [ITEM] = '356568'

'Select unique values for each column to see if any column has problems'
SELECT DISTINCT [CATEGORY] FROM [dbo].[ItemData_csv]
SELECT DISTINCT [COLOR] FROM [dbo].[ItemData_csv]
SELECT DISTINCT [SUPLID] FROM [dbo].[ItemData_csv]  'according the dictionary contains of this column must be #####AZ'
SELECT * FROM [dbo].[ItemData_csv] WHERE [ITEM] = '383478'   'Check what row is problematic'
DELETE FROM [dbo].[ItemData_csv] WHERE [ITEM] = '383478'  AND [PURCHASEPRICE] = '480'

Q1 ->How many values are missing per column?
ANSWER -> column education has 112 missing values, column hobby has 25, column suplid has 46, 



SELECT COUNT(*)
FROM [dbo].[CustomerData_csv]
WHERE [GENDER] IS NULL

SELECT COUNT(*)
FROM [dbo].[CustomerData_csv]
WHERE [DOB]  IS NULL

SELECT COUNT(*)
FROM [dbo].[CustomerData_csv]
WHERE [COUNTRY]  IS NULL

SELECT COUNT(*)
FROM [dbo].[CustomerData_csv]
WHERE [EDUCATION]  IS NULL

SELECT COUNT(*)
FROM [dbo].[CustomerData_csv]
WHERE [HOBBY]  IS NULL

SELECT COUNT(*)
FROM [dbo].[ItemData_csv]
WHERE [CATEGORY]  IS NULL

SELECT COUNT(*)
FROM [dbo].[ItemData_csv]
WHERE [COLOR]  IS NULL

SELECT COUNT(*)
FROM [dbo].[ItemData_csv]
WHERE [SUPLID]  IS NULL

SELECT * FROM [dbo].[ItemData_csv] WHERE [SUPLID] IS NULL

SELECT COUNT(*)     
FROM [dbo].[ItemData_csv]
WHERE  [PURCHASEPRICE] IS NULL

SELECT * FROM [dbo].[ItemData_csv] WHERE [PURCHASEPRICE] IS NULL 
SELECT * FROM TransactionsData_csv WHERE ITEM in (SELECT ITEM FROM [dbo].[ItemData_csv] WHERE [PURCHASEPRICE] IS NULL)  -- Transaction for this item doesn't exist. We can delete row from table ItemData
DELETE FROM [dbo].[ItemData_csv] WHERE [PURCHASEPRICE] IS NULL 

SELECT * FROM [dbo].[ItemData_csv] WHERE [PURCHASEPRICE] IS NULL
SELECT * FROM [dbo].[ItemData_csv] WHERE [CATEGORY] = 'HAT' AND [COLOR] = 'RAINBOW' AND [SUPLID] = '40392XX'


SELECT COUNT(*)
FROM [dbo].[ItemData_csv]
WHERE  [SALEPRICE] IS NULL

SELECT * FROM [dbo].[ItemData_csv] WHERE [SALEPRICE] IS NULL

'SELECT * FROM [dbo].[ItemData_csv_original] WHERE [ITEM] = '120605'
SELECT * FROM [dbo].[ItemData_csv_original]'

SELECT * FROM [dbo].[ItemData_csv_original] WHERE [ITEM] = '499074'
SELECT * FROM [dbo].[ItemData_csv] WHERE [ITEM] = '383478'


SELECT [ITEM],[CATEGORY],[COLOR], COUNT(*) AS QTY
FROM [dbo].[ItemData_csv_original]
GROUP BY [ITEM],[CATEGORY],[COLOR]
HAVING COUNT(*)>1

SELECT [ITEM], COUNT(*) AS QTY
FROM [dbo].[ItemData_csv_original]
GROUP BY [ITEM]
HAVING COUNT(*)>1

CREATE TABLE #TemporaryTable          -- Local temporary table - starts with single #
(
    ITEM int,
    QTY int
)
Insert into #TemporaryTable
SELECT [ITEM], COUNT(*) AS QTY
FROM [dbo].[ItemData_csv_original]
GROUP BY [ITEM]
HAVING COUNT(*)>1

SELECT * from TransactionsData_csv
WHERE item in (select item from #TemporaryTable)
order by item

select * from CustomerData_csv where USERID in (38800,42590)
SELECT * FROM TransactionsData_csv WHERE ITEM = '368619'
SELECT * FROM [dbo].[ItemData_csv_original] WHERE ITEM = '100000'

SELECT * 
FROM ItemData_csv_original
GROUP BY [ITEM],[CATEGORY],[COLOR],[SUPLID],[PURCHASEPRICE],[SALEPRICE]7

SELECT DISTINCT suplid from ItemData_csv_original

SELECT COUNT(*) from ItemData_csv_original