CREATE DATABASE FileManagement;
USE FileManagement;
DROP DATABASE filemanagement;
CREATE USER dbadmin IDENTIFIED BY 'helloworld';
GRANT ALL ON FileManagement .* TO 'dbadmin'@'%';
FLUSH PRIVILEGES;

CREATE TABLE Registration(
usn_ssid CHAR(10) PRIMARY KEY,
Username VARCHAR(30) UNIQUE NOT NULL,
Email VARCHAR(255) UNIQUE NOT NULL,
Pass VARCHAR(255) NOT NULL,
Branch VARCHAR(255),
College VARCHAR(255) NOT NULL,
T_or_S CHAR(1) NOT NULL,
CONSTRAINT username_check CHECK (Username NOT LIKE '%[^A-Z0-9_]%'),
CONSTRAINT email_check CHECK (Email LIKE '%___@___%.__%')
);

SELECT * FROM REGISTRATION;

CREATE TABLE College(
College_id VARCHAR(10) PRIMARY KEY,
College_name VARCHAR(255) NOT NULL);

INSERT INTO College VALUES('SJEC', 'St. Joseph Engineering College, Mangalore');
INSERT INTO College VALUES('SCEM', 'Sahyadri College of Engineering and Management, Mangalore');
INSERT INTO College VALUES('SDM', 'S.D.M. Institute of Technology, Ujire');
INSERT INTO College VALUES('CEC', 'Canara Engineering College, Mangalore');
INSERT INTO College VALUES('VCET', 'Vivekananda College of Engineering and Technology, Puttur');

CREATE TABLE Branch(
Branch_id VARCHAR(10),
Branch_name VARCHAR(255) NOT NULL,
College_id VARCHAR(10) REFERENCES College(College_id),
PRIMARY KEY(Branch_id, College_id));

INSERT INTO Branch VALUES('CIV','Civil Engineering','SJEC');
INSERT INTO Branch VALUES('CSE','Computer Science and Engineering','SJEC');
INSERT INTO Branch VALUES('EEE','Electrical and Electronics Engineering','SJEC');
INSERT INTO Branch VALUES('ECE','Electronics and Communication Engineering','SJEC');
INSERT INTO Branch VALUES('ME','Mechanical Engineering','SJEC');

show tables;

DROP TABLE Registration;
DROP TABLE Teacher;
DROP TABLE Student;

CREATE TABLE Teacher (
    ssid CHAR(10) PRIMARY KEY,
    Fname VARCHAR(255) NOT NULL,
    Lname VARCHAR(255) NOT NULL,
    Designation VARCHAR(255) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    yr_of_exp NUMERIC(2) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Phno NUMERIC(13) NOT NULL,
    Skills VARCHAR(255),
    Image VARCHAR(255),
    FOREIGN KEY (Department) REFERENCES Branch (Branch_id),
    FOREIGN KEY (ssid) REFERENCES Registration (usn_ssid) ON DELETE CASCADE
);


CREATE TABLE Class(
	Class VARCHAR(10) PRIMARY KEY,
    Branch VARCHAR(20) REFERENCES Branch(Branch_id),
    Sem NUMERIC(1) NOT NULL,
    Sec CHAR(1) NOT NULL
);

INSERT INTO Class VALUES ('CSE1A','CSE',1,'A');
INSERT INTO Class VALUES ('CSE1B','CSE',1,'B');
INSERT INTO Class VALUES ('CSE1C','CSE',1,'C');
INSERT INTO Class VALUES ('CSE2A','CSE',2,'A');
INSERT INTO Class VALUES ('CSE2B','CSE',2,'B');
INSERT INTO Class VALUES ('CSE2C','CSE',2,'C');
INSERT INTO Class VALUES ('CSE3A','CSE',3,'A');
INSERT INTO Class VALUES ('CSE3B','CSE',3,'B');
INSERT INTO Class VALUES ('CSE3C','CSE',3,'C');
INSERT INTO Class VALUES ('CSE4A','CSE',4,'A');
INSERT INTO Class VALUES ('CSE4B','CSE',4,'B');
INSERT INTO Class VALUES ('CSE4C','CSE',4,'C');
INSERT INTO Class VALUES ('CSE5A','CSE',5,'A');
INSERT INTO Class VALUES ('CSE5B','CSE',5,'B');
INSERT INTO Class VALUES ('CSE5C','CSE',5,'C');
INSERT INTO Class VALUES ('CSE6A','CSE',6,'A');
INSERT INTO Class VALUES ('CSE6B','CSE',6,'B');
INSERT INTO Class VALUES ('CSE6C','CSE',6,'C');
INSERT INTO Class VALUES ('CSE7A','CSE',7,'A');
INSERT INTO Class VALUES ('CSE7B','CSE',7,'B');
INSERT INTO Class VALUES ('CSE7C','CSE',7,'C');
INSERT INTO Class VALUES ('CSE8A','CSE',8,'A');
INSERT INTO Class VALUES ('CSE8B','CSE',8,'B');
INSERT INTO Class VALUES ('CSE8C','CSE',8,'C');

CREATE TABLE Student (
    usn VARCHAR(10) PRIMARY KEY,
    Fname VARCHAR(255) NOT NULL,
    Lname VARCHAR(255) NOT NULL,
    Class VARCHAR(10) NOT NULL,
    DOB DATE NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Phno NUMERIC(13) NOT NULL,
    Image VARCHAR(255),
    Portfolio_links VARCHAR(500),
    About VARCHAR(700),
    FOREIGN KEY (Class) REFERENCES Class(Class),
    FOREIGN KEY (usn) REFERENCES Registration (usn_ssid) ON DELETE CASCADE
);

DELIMITER //
CREATE PROCEDURE greetings(IN USN CHAR(10))
BEGIN
	SELECT Username FROM Registration WHERE usn_ssid = USN; 
END//
CALL greetings('4SO19CS119')

CREATE TABLE Subject(
	Subject_code VARCHAR(10) PRIMARY KEY,
    Subject_name VARCHAR(100)
);

INSERT INTO Subject VALUES ('18CS51','MANAGEMENT, ENTREPRENEURSHIP FOR IT INDUSTRY');
INSERT INTO Subject VALUES ('18CS52','COMPUTER NETWORKS AND SECURITY');
INSERT INTO Subject VALUES ('18CS53','DATABASE MANAGEMENT SYSTEM');
INSERT INTO Subject VALUES ('18CS54','AUTOMATA THEORY AND COMPUTABILITY');
INSERT INTO Subject VALUES ('18CS55','APPLICATION DEVELOPMENT USING PYTHON');
INSERT INTO Subject VALUES ('18CS56','UNIX PROGRAMMING');
INSERT INTO Subject VALUES ('18CSL57','COMPUTER NETWORK LABORATORY');
INSERT INTO Subject VALUES ('18CSL58','DBMS LABORATORY WITH MINI PROJECT');
INSERT INTO Subject VALUES ('18CIV59','ENVIRONMENTAL STUDIES');

CREATE TABLE Subject_Handle (
    ssid VARCHAR(10) NOT NULL,
    Class VARCHAR(10) NOT NULL,
    Subject_code VARCHAR(10) NOT NULL,
    FOREIGN KEY (Class) REFERENCES Class(Class),
    FOREIGN KEY (Subject_code) REFERENCES Subject(Subject_code),
    PRIMARY KEY (ssid,Class,Subject_code)
);

INSERT INTO Subject_Handle VALUES ('4SOTSCS001','CSE5B','18CS51');
INSERT INTO Subject_Handle VALUES ('4SOTSCS002','CSE5B','18CS52');
INSERT INTO Subject_Handle VALUES ('4SOTSCS003','CSE5B','18CS53');
INSERT INTO Subject_Handle VALUES ('4SOTSCS004','CSE5B','18CS54');
INSERT INTO Subject_Handle VALUES ('4SOTSCS005','CSE5B','18CS55');
INSERT INTO Subject_Handle VALUES ('4SOTSCS006','CSE5B','18CS56');
INSERT INTO Subject_Handle VALUES ('4SOTSCS007','CSE5B','18CSL57');
INSERT INTO Subject_Handle VALUES ('4SOTSCS008','CSE5B','18CSL58');
INSERT INTO Subject_Handle VALUES ('4SOTSCS009','CSE5B','18CIV59');
INSERT INTO Subject_Handle VALUES ('4SOTSCS005','CSE5A','18CS55');
INSERT INTO Subject_Handle VALUES ('4SOTSCS005','CSE5C','18CS55');


CREATE TABLE Repository (
    Repoid INT PRIMARY KEY AUTO_INCREMENT,
    Reponame VARCHAR(255) NOT NULL,
    ssid VARCHAR(10) NOT NULL,
    Class VARCHAR(10) NOT NULL,
    Subject_code VARCHAR(10),
    Comments VARCHAR(500),
    FOREIGN KEY (ssid) REFERENCES Teacher (ssid) ON DELETE CASCADE,
    FOREIGN KEY (Class) REFERENCES Class (Class)
);
drop table repository;

CREATE TABLE File (
    Repoid INT NOT NULL,
    Filename VARCHAR(255) NOT NULL,
    Usn CHAR(10) NOT NULL,
    Location VARCHAR(255),
    Uploaded DATETIME,
    Marks SMALLINT,
    FOREIGN KEY (Repoid) REFERENCES Repository (Repoid) ON DELETE CASCADE,
    FOREIGN KEY (Usn) REFERENCES Student (usn),
    PRIMARY KEY(Repoid, Filename, Usn)
)
drop table file;

DELIMITER ;;
CREATE TRIGGER set_created_date
BEFORE INSERT ON File FOR EACH ROW
    SET New.Uploaded = NOW();


DROP TRIGGER set_created_date;


CREATE TABLE Notification (
    ssid VARCHAR(10) NOT NULL,
    Class VARCHAR(10) NOT NULL,
    Sent_time DATETIME NOT NULL,
    Title TEXT NOT NULL,
    Message TEXT,
    FOREIGN KEY (ssid) REFERENCES Teacher (ssid)  ON DELETE CASCADE,
    FOREIGN KEY (Class) REFERENCES Class (Class),
    PRIMARY KEY(ssid,Class,Sent_time)
);
drop table notification;

CREATE TRIGGER notification_sent_time
BEFORE INSERT ON Notification FOR EACH ROW
    SET New.Sent_time = NOW();
    
CREATE VIEW Message_recieved AS 
SELECT DISTINCT T.Image, T.Fname, T.Lname, S.Subject_name, N.Sent_time, N.Title, N.Message, N.CLass
FROM Notification N
JOIN Teacher T ON N.ssid = T.ssid
JOIN Subject_Handle SH ON N.ssid = SH.ssid
JOIN Subject S ON S.Subject_code = SH.Subject_code 
JOIN Class C ON N.Class = C.Class;

DROP VIEW Message_recieved;
DELIMITER |
CREATE TRIGGER assignment_notification
AFTER INSERT ON Repository FOR EACH ROW
BEGIN
	INSERT INTO Notification(ssid,Class,Title,Message) VALUES (NEW.ssid, NEW.Class, CONCAT(NEW.Reponame," ",NEW.Subject_code), NEW.Comments);
END;
|
drop trigger assignment_notification;

CREATE TABLE User_Admin(
	ssid CHAR(10) PRIMARY KEY,
    passw VARCHAR(255) NOT NULL,
    FOREIGN KEY (ssid) REFERENCES Teacher(ssid)
);
INSERT INTO User_Admin VALUES ('4SOTSCS000', md5('admin'))