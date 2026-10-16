use sem_2026_2027

DROP TABLE Contracts
DROP TABLE Volunteers
DROP TABLE Non_profit_Organizations

CREATE TABLE Volunteers(
	vid TINYINT PRIMARY KEY,
	vname VARCHAR(200),
	dob DATE,
	email VARCHAR(100),
	phone CHAR(10),
)

CREATE TABLE Non_profit_Organizations(
	id TINYINT,
	org_name VARCHAR(200),
	org_desc VARCHAR(300),
	org_size INT,
	contact VARCHAR(100),
	PRIMARY KEY(id)
	)

	CREATE TABLE Contracts(
		vid TINYINT REFERENCES Volunteers(vid),
		id TINYINT ,--REFERENCES Non_profit_Organizations(id),
		sign_date DATETIME,
		[start_date] DATE default getdate(),
		no_hours FLOAT,
		tasks VARCHAR(200),
		--[period] SMALLINT,
		cid TINYINT PRIMARY KEY identity(1,1)
		--CONSTRAINT FK_Org FOREIGN KEY (id) REFERENCES Non_profit_Organizations(id)
		 FOREIGN KEY (id) REFERENCES Non_profit_Organizations(id)
		 ON DELETE CASCADE 
		 ON UPDATE SET DEFAULT
		)

		ALTER TABLE Contracts DROP COLUMN Tasks

		ALTER TABLE Contracts
		ADD [period] INT NOT NULL
		ALTER TABLE Contracts
		ADD CONSTRAINT UNIQUE_period unique(start_date,period)

		ALTER TABLE Contracts ALTER COLUMN no_hours DECIMAL(4,2)

		ALTER TABLE Contracts
		

		


