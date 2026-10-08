use dbseminar1

CREATE TABLE Volunteer(
	id TINYINT PRIMARY KEY,
	v_name VARCHAR(200),
	dob DATE,
	email VARCHAR(100),
	phone CHAR(10),
)


CREATE TABLE NPO(
	id TINYINT,
	npo_name VARCHAR(200),
	npo_desc VARCHAR(300),
	npo_size INT,
	contact VARCHAR(100),

	PRIMARY KEY(id)
)