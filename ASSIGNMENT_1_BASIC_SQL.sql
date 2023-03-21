 -- 1. Load the given dataset into snowflake with a primary key to Order Date column.

--ANS:-
 
 CREATE OR REPLACE TABLE SALES_DATA(
    ORDER_ID CHAR(30),
    ORDER_DATE DATE PRIMARY KEY NOT NULL,
    SHIP_DATE DATE,
    SHIP_MODE VARCHAR(100),
    CUSTOMER_NAME CHAR(40),
    SEGMENT CHAR(40),
    STATE CHAR(40),
    COUNTRY CHAR(100),
     MARKET CHAR(30),
     REGION CHAR(30),
     PRODUCT_ID CHAR(100),
     CATEGORY CHAR(40),
     SUB_CATEGORY CHAR(30),
     PRODUCT_NAME  CHAR(150),
     SALES NUMBER(10,5),
     QUANTITY INT,
     DISCOUNT NUMBER(8,5),
     PROFIT  NUMBER(12,8),
     SHIPPING_COST FLOAT,
     ORDER_PRIORITY CHAR(30),
     YEAR INT); 
     
   SELECT * FROM SALES_DATA;
  
--2. Change the Primary key to Order Id Column.
  --ANS;-
  CREATE OR REPLACE TABLE SALES_DATA_COPY
  AS SELECT * FROM SALES_DATA;
  
  ALTER TABLE SALES_DATA_COPY
  DROP PRIMARY KEY;
  
  ALTER TABLE SALES_DATA_COPY
  ADD PRIMARY KEY (ORDER_ID);
  
 
 
 
 --3. Check the data type for Order date and Ship date and mention in what data type it should be?
 -- -ANS

 SELECT GET_DDL('TABLE','SALES_DATA_COPY');
 SELECT  TO_CHAR(DATE(order_date),'YYYY-MM-DD') AS ORDER_DATE FROM SALES_DATA_COPY;
 SELECT TO_CHAR(TO_DATE(ship_date),'YYYY-MM-DD') AS SHIP_DATE FROM SALES_DATA_COPY;
 
 
 
--4. Create a new column called order_extract and extract the number after the last -
---from Order ID column.
--ANS --
  
  
  SELECT *, 
  SUBSTR(ORDER_ID,9) AS ORDER_EXTRACT FROM SALES_DATA_COPY;
  
  
 -- 5. Create a new column called Discount Flag and categorize it based on discount.
--Use ‘Yes’ if the discount is greater than zero else ‘No’.--
  --ANS--
  
  SELECT *,
  CASE 
      WHEN DISCOUNT > 0 THEN 'YES'
      ELSE 'NO'
    END AS Discount_Flag
  
FROM SALES_DATA_COPY;
  
  
 --6. Create a new column called process days and calculate how many days it takes
--for each order id to process from the order to its shipment.
  --ANS--
  
  SELECT DATEDIFF('DAY',ORDER_DATE,SHIP_DATE)AS PROCESS_DAYS FROM SALES_DATA_COPY;
  
  

 
  
  --7. Create a new column called Rating and then based on the Process dates give
--rating like given below.
--a. If process days less than or equal to 3days then rating should be 5
--b. If process days are greater than 3 and less than or equal to 6 then rating
--should be 4
--c. If process days are greater than 6 and less than or equal to 10 then rating
--should be 3
--d. If process days are greater than 10 then the rating should be 2.
   
  --ANS- 
   
   SELECT *,
    CASE 
      WHEN PROCESS_DAYS <= 3 THEN '5'
      WHEN (PROCESS_DAYS > 3 AND PROCESS_DAYS <= 6)THEN '4'
      WHEN (PROCESS_DAYS > 6 AND PROCESS_DAYS <=10) THEN '3'
      WHEN PROCESS_DAYS > 10 THEN '2'
      ELSE PROCESS_DAYS
      
      END AS RATING
      FROM ASSIGNMENT_1_COMPLETE;
 
  CREATE OR REPLACE VIEW ASSIGNMENT_1_COMPLETE AS
  SELECT *,
      TO_CHAR(DATE(order_date),'YYYY-MM-DD') AS ORDER_DATE1 ,
      TO_CHAR(TO_DATE(ship_date),'YYYY-MM-DD') AS SHIP_DATE1 ,
  
  SUBSTR(ORDER_ID,9) AS ORDER_EXTRACT,
 
 CASE 
      WHEN DISCOUNT > 0 THEN 'YES'
      ELSE 'NO'
    END AS Discount_Flag,
     
     DATEDIFF('DAY',ORDER_DATE,SHIP_DATE)AS PROCESS_DAYS,
    
    CASE 
      WHEN PROCESS_DAYS <= 3 THEN '5'
      WHEN (PROCESS_DAYS > 3 AND PROCESS_DAYS <= 6)THEN '4'
      WHEN (PROCESS_DAYS > 6 AND PROCESS_DAYS <=10) THEN '3'
      WHEN PROCESS_DAYS > 10 THEN '2'
      ELSE PROCESS_DAYS
      
      END AS RATING
      FROM SALES_DATA_COPY;
  
  
 
  SELECT * FROM ASSIGNMENT_1_COMPLETE;
  
  
  