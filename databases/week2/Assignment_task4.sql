-- Active: 1660903523654@@127.0.0.1@3306@insurance
-- Creating a DATABASE
-- Insurance Policy Database Created
USE insurance;
CREATE TABLE Person(
	PID INTEGER NOT NULL AUTO_INCREMENT,
	FirstName VARCHAR(255),
	LastName VARCHAR(255),
	BirthDate DATE,
	Street VARCHAR(255),
	Suburb VARCHAR(255),
	State VARCHAR(255),
	Postcode CHAR(10),
	CONSTRAINT Person_PID_pk PRIMARY KEY(PID)
);  
CREATE TABLE Client(
	PID INTEGER,
	CID INTEGER NOT NULL PRIMARY KEY,
    CONSTRAINT Clint_PID_fk
    FOREIGN KEY (PID) REFERENCES Person (PID)
);

CREATE TABLE Staff(
	PID INTEGER,
	SID INTEGER,
	PRIMARY KEY (SID),
    CONSTRAINT  Staff_PID_fk FOREIGN KEY (PID) REFERENCES Person (PID)
    );
    
CREATE TABLE Insured_item(
	ItemID INTEGER NOT NULL AUTO_INCREMENT ,
	Brand VARCHAR(255) ,
	Model VARCHAR(255),
	ModelYear VARCHAR(255),
	Reg   VARCHAR(255) unique not null,
	CONSTRAINT  Insured_item_ID_pk PRIMARY KEY(ItemID)
);

CREATE TABLE Policy(
	PNO INTEGER NOT NULL AUTO_INCREMENT,
	Pname  VARCHAR(255),
	Status  VARCHAR(255),
	EffectiveDate    DATE,
	ExpiryDate 	 DATE,
	AgreedValue REAL,
	Comments  VARCHAR(255),
    SID INTEGER,
    ItemID INTEGER,
	CONSTRAINT  Policy_PNO_pk PRIMARY KEY(PNO),
    CONSTRAINT policy_PID_fk
   FOREIGN KEY (SID) REFERENCES Staff(SID),
   CONSTRAINT policy_ID_fk
   FOREIGN KEY (ItemID) REFERENCES Insured_item(ItemID)
);
CREATE TABLE Underwriting_record(
	URID INTEGER NOT NULL AUTO_INCREMENT,
	Status  VARCHAR(255),
	PNO INTEGER,
	CONSTRAINT  Underwriting_record_URID_pk PRIMARY KEY(URID),
    CONSTRAINT Underwriting_record_PNO_fk
    FOREIGN KEY (PNO) REFERENCES Policy(PNO)
);

CREATE TABLE Underwritten_by(
    UWID INTEGER NOT NULL AUTO_INCREMENT,
	SID INTEGER ,
	URID INTEGER ,
	WDate DATE,
	Comments  VARCHAR(255),
	CONSTRAINT  Underwritten_by_pk PRIMARY KEY(UWID),
    CONSTRAINT Underwritten_by_SID_fk
	FOREIGN KEY (SID) REFERENCES Staff(SID),
    CONSTRAINT Underwritten_by_URID_fk
   FOREIGN KEY (URID) REFERENCES Underwriting_record(URID)
);

CREATE TABLE Coverage(
	COID INTEGER NOT NULL AUTO_INCREMENT,
	Cname VARCHAR(255),
	UpLimit REAL ,
	Comments  VARCHAR(255),
	PNO Integer,
	CONSTRAINT  Coverage_COID_pk PRIMARY KEY(COID),
    CONSTRAINT Coverage_Pno_fk
	FOREIGN KEY (PNO) REFERENCES Policy(PNO)
);
CREATE TABLE Rating_record(
	RID INTEGER NOT NULL AUTO_INCREMENT,
	Rate REAL ,
	Status VARCHAR(255),
	COID INTEGER,
	CONSTRAINT  Rating_record_RID_pk PRIMARY KEY(RID),
    CONSTRAINT Rating_record_coid_fk
	FOREIGN KEY (COID) REFERENCES Coverage(COID)
);
CREATE TABLE Insured_by(
    InsuredID INTEGER NOT NULL AUTO_INCREMENT,
	CID INTEGER,
	PNO INTEGER,
	CONSTRAINT  Insured_by_pk PRIMARY KEY(InsuredID),
	CONSTRAINT Insured_BY_CID_FK
	FOREIGN KEY (CID) REFERENCES Client(CID),
    CONSTRAINT Insured_BY_PNO_FK
	FOREIGN KEY (PNO) REFERENCES Policy(PNO)
);
CREATE TABLE Rated_by(
    RatedID INTEGER NOT NULL AUTO_INCREMENT,
	SID INTEGER ,
	RID INTEGER,
	Rdate DATE,
	Comments VARCHAR(255),
	CONSTRAINT  Rated_by_pk PRIMARY KEY(RatedID),
    CONSTRAINT RATED_BY_SID_FK
	FOREIGN KEY (SID) REFERENCES Staff(SID),
    CONSTRAINT RATED_BY_RID_FK
	FOREIGN KEY (RID) REFERENCES Rating_record(RID)
);