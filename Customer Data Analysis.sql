create database CBA;
use CBA;
create table engagement_data (EngagementID int,
							  ContentID int,
                              ContentType varchar(40),
                              Likes	int,
                              EngagementDate date,
                              CampaignID int,
                              ProductID	int,
                              ViewsClicksCombined varchar(40));
select*from engagement_data;
create table customer_journey (JourneyID int,
								CustomerID int,
                                ProductID int,
                                VisitDate date,
                                Stage varchar(100),
                                Action varchar(100),
                                Duration varchar(100));
select*from customer_journey;
ALTER TABLE customer_reviews MODIFY ReviewDate DATE;

create table customer_reviews (ReviewID int,
								CustomerID int,
                                ProductID	int,
                                ReviewDate date,
                                Rating	int,
                                ReviewText varchar(100));
                  
select*from customer_reviews;

create table customers (CustomerID	int,
						CustomerName varchar(100),
                        Email	varchar(100),
                        Gender	varchar(100),
                        Age	int,customer_journeyJourneyID
                        GeographyID int);
select*from customers;
create table geography (GeographyID int,
						Country	varchar(100),
                        City varchar(100));
                        

select*from geography;
create table products (ProductID	int,
						ProductName	varchar(100),
                        Category varchar(100),
                        Price float);
select*from products;

SELECT avg(Duration),
COUNT(*) AS Dropoff
FROM customer_journey
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID FROM customer_journey WHERE Duration = 'Purchase'
)
GROUP BY Duration
ORDER BY Dropoff DESC;

SELECT customer_journey.CustomerID, CustomerName, Age, Gender,Duration
FROM customer_journey
JOIN customers ON customer_journey.CustomerID =customers.CustomerID
WHERE customer_journey.Duration IS NOT NULL AND customer_journey.Duration
ORDER BY customer_journey.Duration DESC;

SELECT 
    stage, 
    COUNT(DISTINCT CustomerID) AS customers_count
FROM customer_journey
GROUP BY stage
ORDER BY customers_count ;

SELECT 
    stage, 
    AVG(Duration) AS avg_time_spent
FROM customer_journey
GROUP BY stage;

SELECT 
    Action, 
    COUNT(DISTINCT CustomerID) AS total_customers, 
    COUNT(DISTINCT CASE WHEN ProductID = 'Yes' THEN CustomerID END) AS converted_customers,
    ROUND(
        (COUNT(DISTINCT CASE WHEN ProductID = 'Yes' THEN CustomerID END) / COUNT(DISTINCT CustomerID)) * 100, 
        2
    ) AS conversion_rate
FROM customer_journey
GROUP BY Action
ORDER BY conversion_rate DESC;

DESC customer_journey;
DESC engagement_data;

SELECT 
    customer_journey.CustomerID, 
    customer_journey.Stage, 
    customer_journey.Duration, 
	customer_journey.Action, 
    customer_journey.timestamp
FROM customer_journey ProductID
JOIN engagement_data ProductID 
    ON customer_journey.ProductID = enagagement_data.ProductID
ORDER BY customer_journey.ProductID, enagagement_data.ProductID;

SELECT 
    ProductID, 
    COUNT(*) AS total_reviews,
    ROUND(AVG(rating),2) AS avg_rating
FROM customer_reviews
GROUP BY ProductID
ORDER BY avg_rating DESC;

SELECT 
    ProductID, 
	Round(AVG(rating), 2) AS avg_rating, 
    Count(*) AS total_reviews
FROM customer_reviews
GROUP BY ProductID
ORDER BY ProductID;