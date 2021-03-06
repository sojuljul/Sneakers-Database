CREATE TABLE USER
(
Username VARCHAR(20) NOT NULL,
First_name VARCHAR(20) NOT NULL,
Last_name VARCHAR(20) NOT NULL,
Shoe_size INT NOT NULL,
Date_joined DATE NOT NULL,
PRIMARY KEY (Username),
CONSTRAINT chk_size CHECK(Shoe_size >= 1 AND Shoe_size <= 14),
CONSTRAINT chk_datejoin CHECK(Date_joined > '2018-07-01')
);

CREATE TABLE COMPANY
(
Company_name VARCHAR(20) NOT NULL,
Company_city VARCHAR(20),
Company_state VARCHAR(20) NOT NULL,
Year_est INT NOT NULL,
PRIMARY KEY (Company_name),
CONSTRAINT chk_year CHECK(Year_est >= 1990)
);

CREATE TABLE WEBSITE
(
Website_id INT NOT NULL,
Website_url VARCHAR(20) NOT NULL,
WCompany_name VARCHAR(20) NOT NULL,
PRIMARY KEY (Website_id),
FOREIGN KEY (WCompany_name) REFERENCES COMPANY(Company_name),
CONSTRAINT chk_webid CHECK(Website_id > 0)
);

CREATE TABLE SHOE
(
Shoe_id VARCHAR(20) NOT NULL,
Shoe_name VARCHAR(50) NOT NULL,
Release_date DATE,
Retail_value DECIMAL(10,2),
SCompany_name VARCHAR(20) NOT NULL,
SWebsite_id INT NOT NULL,
PRIMARY KEY (Shoe_id),
FOREIGN KEY (SCompany_name) REFERENCES COMPANY(Company_name),
FOREIGN KEY (SWebsite_id) REFERENCES WEBSITE(Website_id),
CONSTRAINT chk_retail CHECK(Retail_value > 0)
);

CREATE TABLE REVIEW
(
Review_id INT NOT NULL,
Review_date DATE NOT NULL,
Review_rating INT NOT NULL,
Review_description VARCHAR(50),
RevShoe_id VARCHAR(20) NOT NULL,
RevUsername VARCHAR(20) NOT NULL,
PRIMARY KEY (Review_id),
FOREIGN KEY (RevShoe_id) REFERENCES SHOE(Shoe_id),
FOREIGN KEY (RevUsername) REFERENCES USER(Username),
CONSTRAINT chk_reviewid CHECK(Review_id > 0),
CONSTRAINT chk_rating CHECK(Review_rating >= 0 AND Review_rating <= 5)
);

CREATE TABLE RESELLS
(
ResUsername VARCHAR(20) NOT NULL,
ResShoe_id VARCHAR(20) NOT NULL,
Resell_value DECIMAL(10,2),
PRIMARY KEY (ResUsername, ResShoe_id),
FOREIGN KEY (ResUsername) REFERENCES USER(Username),
FOREIGN KEY (ResShoe_id) REFERENCES SHOE(Shoe_id),
CONSTRAINT chk_resell CHECK(Resell_value > 0)
);

CREATE TABLE PURCHASES
(
PUsername VARCHAR(20) NOT NULL,
PShoe_id VARCHAR(20) NOT NULL,
Purchase_date DATE NOT NULL,
PRIMARY KEY (PUsername, PShoe_id),
FOREIGN KEY (PUsername) REFERENCES USER(Username),
FOREIGN KEY (PShoe_id) REFERENCES SHOE(Shoe_id)
);

CREATE TABLE SHOE_COLOR
(
SCShoe_id VARCHAR(20),
SC_color VARCHAR(50),
PRIMARY KEY (SCShoe_id, SC_color),
FOREIGN KEY (SCShoe_id) REFERENCES SHOE(Shoe_id)
);