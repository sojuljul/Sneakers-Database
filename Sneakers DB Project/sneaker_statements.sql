-- retrieves all users reselling a shoe
SELECT Shoe_id, Shoe_name, Retail_value, ResUsername, Resell_value, Shoe_size
FROM RESELLS, SHOE, USER
WHERE Shoe_id = ResShoe_id AND Username = ResUsername;

-- retrieves all shoes w/ their color (latest at top)
SELECT Shoe_id, Shoe_name, Release_date, Retail_value, SC_color
FROM SHOE, SHOE_COLOR
WHERE Shoe_id = SCShoe_id
ORDER BY Release_date DESC;

-- retrieves all shoes (latest at top)
SELECT Shoe_id, Shoe_name, Release_date, Retail_value
FROM SHOE
ORDER BY Release_date DESC;

-- retrieves all shoes w/ no confirmed release date
SELECT Shoe_id, Shoe_name, Release_date, Retail_value, SC_color
FROM SHOE, SHOE_COLOR
WHERE Shoe_id = SCShoe_id AND Release_date IS NULL
ORDER BY Shoe_name;

-- retrieves all shoes w/ the name "Yeezy"
SELECT Shoe_id, Shoe_name, Release_date, Retail_value, SC_color
FROM SHOE, SHOE_COLOR
WHERE Shoe_id = SCShoe_id AND Shoe_name LIKE '%Yeezy%'
ORDER BY Release_date DESC;

-- retrieves all users and the total they spent on shoes
SELECT PUsername, SUM(Retail_value) AS Total_spent
FROM PURCHASES, SHOE
WHERE Shoe_id = PShoe_id
GROUP BY PUsername;

-- retrieves the average resell value for all shoes that are being resold 
SELECT Shoe_id, Shoe_name, SC_color, FORMAT(AVG(Resell_value), 2) AS Average_resell
FROM SHOE, SHOE_COLOR, RESELLS
WHERE Shoe_id = SCShoe_id AND Shoe_id = ResShoe_id
GROUP BY ResShoe_id;

-- retrieves all shoes that in color "Black"
SELECT Shoe_id, Shoe_name, SC_color, Release_date, Retail_value
FROM SHOE, SHOE_COLOR
WHERE Shoe_id = SCShoe_id AND SC_color LIKE '%Black%'
ORDER BY Release_date DESC;