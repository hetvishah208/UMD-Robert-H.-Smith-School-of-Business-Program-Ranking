-- Team 10 SQL Samurai
USE BUDT702_Project_0502_10

--SQL drop tables:

DROP TABLE IF EXISTS [SmithSchoolRanking.Rank];
DROP TABLE IF EXISTS [SmithSchoolRanking.Placement];
DROP TABLE IF EXISTS [SmithSchoolRanking.Alumni];
DROP TABLE IF EXISTS [SmithSchoolRanking.Research];
DROP TABLE IF EXISTS [SmithSchoolRanking.Assign];
DROP TABLE IF EXISTS [SmithSchoolRanking.Faculty];
DROP TABLE IF EXISTS [SmithSchoolRanking.Program];

--SQL create tables:

CREATE TABLE [SmithSchoolRanking.Program] (
prgmID CHAR (2) NOT NULL,
prgmName VARCHAR (50),
prgmAcronym VARCHAR (5),
prgmDegree VARCHAR (6),
prgmCredit CHAR (2),
prgmSemester CHAR (2),
prgmDuration CHAR (2),
prgmAvgGPA DECIMAL (2,1),
prgmAvgGREReq CHAR (3),
prgmAvgTOFELReq VARCHAR (3),
	CONSTRAINT pk_Program_prgmID PRIMARY KEY (prgmID),
);

CREATE TABLE [SmithSchoolRanking.Rank] (
rankID CHAR (2) NOT NULL,
ranking INT,
prgmRankYear CHAR (4),
rankingAgencyID CHAR (2),
rankingAgencyName VARCHAR (25),
prgmID CHAR (2)
	CONSTRAINT pk_rankID PRIMARY KEY (rankID),
	CONSTRAINT fk_Program_prgmID FOREIGN KEY (prgmID)
		REFERENCES [SmithSchoolRanking.Program] (prgmID)
		ON DELETE CASCADE
		ON UPDATE NO ACTION
);

CREATE TABLE [SmithSchoolRanking.Faculty] (
facultyID CHAR (2) NOT NULL,
facultyName VARCHAR(600),
facultyFName VARCHAR(600),
facultyLName VARCHAR(600),
facultyTitle VARCHAR(600),
facultyQualification VARCHAR(600),
facultyDOJ CHAR(4),
facultyEmpDurationInYears INT,
facultyEmail VARCHAR(500),
	CONSTRAINT pk_facultyID PRIMARY KEY (facultyID)
);

CREATE TABLE [SmithSchoolRanking.Research](
researchID CHAR (2) NOT NULL,
researchTitle VARCHAR(300),
researchArea VARCHAR(300),
researchGrant INT,
facultyID CHAR (2),
	CONSTRAINT pk_researchID PRIMARY KEY (researchID),
	CONSTRAINT fk_Faculty_facultyID FOREIGN KEY(facultyID)
		REFERENCES [SmithSchoolRanking.Faculty](facultyID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

CREATE TABLE [SmithSchoolRanking.Placement] (
placementID CHAR (2) NOT NULL,
placementRate INT,
avgSalary DECIMAL (12,2),
graduationYear CHAR (4),
placementTopIndustry VARCHAR (90),
placementTopCompany VARCHAR (90),
prgmID CHAR (2),
	CONSTRAINT pk_Placement_placementID PRIMARY KEY (placementID),
	CONSTRAINT fk_Program_prgmID2 FOREIGN KEY (prgmID)
		REFERENCES [SmithSchoolRanking.Program] (prgmID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE [SmithSchoolRanking.Alumni] (
alumniID CHAR (2) NOT NULL,
alumniGraduationYear CHAR (4),
alumniName VARCHAR (75),
alumniCompanyName VARCHAR (75),
alumniDesignation VARCHAR (75),
prgmID CHAR (2),
	CONSTRAINT pk_alumniID PRIMARY KEY (alumniID),
	CONSTRAINT fk_Program_prgmID3 FOREIGN KEY (prgmID)
		REFERENCES [SmithSchoolRanking.Program] (prgmID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);

CREATE TABLE [SmithSchoolRanking.Assign] (
facultyID CHAR (2) NOT NULL,
prgmID CHAR (2) NOT NULL,
courseName VARCHAR (25)
	CONSTRAINT pk_Assign_facultyID_prgmID PRIMARY KEY (facultyID, prgmID),
	CONSTRAINT fk_Faculty_facultyID2 FOREIGN KEY (facultyID)
		REFERENCES [SmithSchoolRanking.Faculty] (facultyID)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_Program_prgmID4 FOREIGN KEY (prgmID)
		REFERENCES [SmithSchoolRanking.Program] (prgmID)
		ON DELETE CASCADE
		ON UPDATE NO ACTION
);

-- SQL insert into statements:

INSERT INTO [SmithSchoolRanking.Program] 
VALUES
	('01', 'Information Systems', 'IS', 'M.S.', 30, 3, 16, 3.5, 310, 100),
	('02', 'Business Analytics', 'BA', 'M.S.', 30, 3, 16, 3.3, 307, 97),
	('03', 'Supply Chain Management', 'SCM', 'M.S.', 30, 3, 16, 3.3, 309, 99),
	('04', 'Marketing Analytics', 'MA', 'M.S.', 30, 3, 16, 3.5, 310, 100),
	('05', 'Quantitative Finance', 'QF', 'M.S.', 36, 4, 24, 3.4, 313, 103),
	('06', 'Accounting', 'ACC', 'M.S.', 30, 3, 16, 3.2, 309, 99),
	('07', 'Finance', 'FIN', 'M.S.', 30, 3, 16, 3.4, 312, 105),
	('08', 'Full Time Management Studies', 'FTMBA', 'M.B.A.', 54, 4, 24, 3.5, 320, 108),
	('09', 'Flex Management Studies', 'FLMBA', 'M.B.A.', 36, 4, 24, 3.5, 315, 105),
	('10', 'Executive Management Studies', 'EXMBA', 'M.B.A.', 30, 3, 16, 3.5, 320, 108);

INSERT INTO [SmithSchoolRanking.Rank]
VALUES
	('01',11,2023,'01','US News','01'),
	('02',31,2022,'02','QS','02'),
	('03',28,2023,'03','Top Universities','03'),
	('04',6,2017,'04','College Factual','04'),
	('05',20,2022,'05','Quantnet','05'),
	('06',30,2022,'04','College Factual','06'),
	('07',2,2022,'06','Financial Times','07'),
	('08',31,2018,'06','Financial Times','08'),
	('09',12,2022,'01','US News','09'),
	('10',12,2023,'01','US News','10'),
	('11',7,2021,'07','Best Value Schools','01'),
	('12',38,2023,'02','QS','02'),
	('13',26,2022,'08','Shiksha','03'),
	('14',17,2022,'01','US News','04'),
	('15',26,2020,'09','Poets and Quants','05'),
	('16',50,2021,'01','US News','06'),
	('17',4,2017,'06','Financial Times','07'),
	('18',24,2022,'01','US News','08'),
	('19',24,2023,'10','Fortune','09'),
	('20',15,2018,'11','Economist','10');

INSERT INTO [SmithSchoolRanking.Faculty]
VALUES
	('01', 'John Bono', 'John', 'Bono', 'Associate Clinical Professor of Information Systems', 'Ph.D., Information Systems', 2019, 4, 'jbono@umd.edu'),
	('02', 'Tejwansh (Tej) Singh Anand', 'Tejwansh (Tej) Singh', 'Anand', 'Academic Director, MS in Information Systems', 'Ed.D.', 2021, 2, 'tejanand@umd.edu'),
	('03', 'Sujin Kim', 'Sujin', 'Kim', 'Associate Clinical Professor', 'Ph.D. in Operations Research and Information Engineering', 2016, 7, 'kimsj22@umd.edu'),
	('04', 'Woei-jyh (Adam) Lee', 'Woei-jyh (Adam) Lee', 'Lee', 'Associate Clinical Professor', 'Ph.D. Bioinformatics', 2012, 11, 'adamlee@umd.edu'),
	('05', 'Kislaya Prasad', 'Kislaya', 'Prasad', 'Academic Director, Center for Global Business', 'Ph. D in Economics', 2005, 18, 'kprasad@umd.edu'),
	('06', 'Ilya Ryzhov', 'Ilya', 'Ryzhov', 'Area Chair, Decision, Operations and Information Technologies', 'Ph.D. in Operations Research and Financial Engineering', 2011, 12, 'iryzhov@umd.edu'),
	('07', 'S. Raghu Raghavan', 'S. Raghu', 'Raghavan', 'Dean''s Professor of Management Science and Operations Management', 'Ph.D. in Operations Research', NULL, NULL, 'raghavan@umd.edu'),
	('08', 'Siva Viswanathan', 'Siva', 'Viswanathan', 'Deans Professor of Information Systems', 'Ph.D. Information Systems', 2001, 22, 'sviswan1@umd.edu'),
	('09', 'Kunpeng Zhang', 'Kunpeng', 'Zhang', 'Associate Professor', 'Ph.D. in Computer Science', 2015, 8, 'kpzhang@umd.edu'),
	('10', 'Thomas M. Corsi', 'Thomas', 'Corsi', 'Academic Director, MS Supply Chain Program', 'Ph.D Economics and Urban Geography', 1976, 47, 'tcorsi@umd.edu'),
	('11', 'M. Gisela Bardossy', 'M. Gisela', 'Bardossy', 'Associate Clinical Professor', 'Ph.D. degree in Management Science', 2018, 5, 'bardossy@umd.edu'),
	('12', 'Humberto C. Coronado', 'Humberto C.', 'Coronado', 'Academic Director, Master of Science in Supply Chain Management', 'MBA, Robert H. Smith School of Business', NULL, NULL, 'hcoronad@umd.edu'),
	('13', 'Martin Dresner', 'Martin', 'Dresner', 'Professor', 'Ph.D., University of British Columbia', 1988, 35, 'mdresner@umd.edu'),
	('14', 'Philip T. Evers', 'Philip', 'Evers', 'Associate Professor of Supply Chain Management', 'Ph.D., University of Minnesota', 1993, 30, 'pevers@umd.edu'),
	('15', 'Leland L. Gardner', 'Leland', 'Gardner', 'Principal Lecturer', 'Master of Business Administration', 2017, 6, 'lgardne1@umd.edu'),
	('16', 'Gosia Langa-Basit', 'Gosia', 'Langs-Basit', 'Senior Lecturer', 'Masters of Science, ABD, organizational behavior', 2008, 15, 'glanga@umd.edu'),
	('17', 'Niratcha “Grace” Tungtisanont', 'Niratcha', 'Tungtisanont', 'Lecturer', 'Ph.D., Clemson University', 2017, 6, 'niratcha@umd.edu'),
	('18', 'Suresh Acharya', 'Suresh', 'Acharya', 'Academic Director, MS in Business Analytics', 'MS in Operations Research', 2018, 5, 'suresh12@umd.edu'),
	('19', 'Gisela Bardossy', 'Gisela', 'Bardossy', 'Associate Clinical Professor', 'Ph.D in Management Sciences', 2018, 5, 'bardossy@umd.edu'),
	('20', 'Zhi-Long Chen', 'Zhi-Long', 'Chen', 'Professor of Operations Management', 'Ph.D Operations Research', 2001, 22, 'zlchen@umd.edu'),
	('21', 'Jessica Clark', 'Jessica', 'Clark', 'Assistant Professor of Information Systems', 'Ph.D. in Information Systems', 2017, 6, 'jmclark@umd.edu'),
	('22', 'Xiaojia Guo', 'Xiaojia', 'Guo', 'Assistant Professor', 'Ph.D. Management Science and Operations', 2021, 2, 'xjguo@umd.edu'),
	('23', 'Raghu Raghavan', 'Raghu', 'Raghavan', 'Dean''s Professor of Management Science and Operations Management', 'Ph.D. in Operations Research, Massachusetts Institute of Technology', NULL, NULL, 'raghavan@umd.edu'),
	('24', 'Emanuel Zur', 'Emanuel', 'Zur', 'Associate Dean of MS Programs', 'Ph.D., New York University', 2013, 10, 'ezur@umd.edu'),
	('25', 'M. Gisela Bardossy', 'M. Gisela', 'Bardossy', 'Faculty Director, QUEST', 'Ph.D. degree in Management Science from the Smith School of Business', 2018, 5, 'bardossy@umd.edu'),
	('26', 'Sean Cao', 'Sean', 'cao', 'Director and Co-founder of the AI Initiative for Capital Market Research', 'Ph.D., University of Illinois at Urbana-Champaign', 2022, 1, 'scao824@umd.edu'),
	('27', 'Jon Crocker', 'Jon', 'Crocker', 'Clinical Professor', 'JD, University of Miami', 2017, 6, 'jcrocker@umd.edu'),
	('28', 'Darlene Dennison', 'Darlene', 'Dennison', 'Adjunct Faculty', 'MBA, San Diego State University', NULL, NULL, 'ddenniso@umd.edu'),
	('29', 'Stacey Ferris', 'Stacey', 'ferris', 'Adjunct Professor of Accounting', 'Master of Accountancy, Georgia Southern University', 2021, 2, 'sferris4@umd.edu'),
	('30', 'Lawrence A. Gordon', 'Lawrence', 'Gordon', 'EY Alumni Professor of Managerial Accounting and Information Assurance', 'Ph.D., Managerial Economics, Rensselaer Polytechnic Institute', 1980, 43, 'lagordon@umd.edu'),
	('31', 'Rebecca Hann', 'Rebecca', 'Han', 'Assistant Dean of Doctoral Programs', 'Ph.D., University of Pennsylvania', 2008, 15, 'rhann@umd.edu'),
	('32', 'Michael Kimbrough', 'Michael', 'Kimbrough', 'Area Chair, Accounting and Information Assurance', 'Ph.D. in Accounting, Indiana University in Bloomington', 2010, 13, 'mkimbrou@umd.edu'),
	('33', 'Jeffrey Milton', 'Jeffrey', 'Milton', 'Associate Clinical Professor', 'LLM Taxation, Georgetown Law School', 2010, 13, 'jmilton@umd.edu'),
	('34', 'Nick Seybert', 'Nick', 'Seybert', 'Associate Professor', 'PhD, Johnson Graduate School of Management, Cornell University', 2010, 13, 'nseybert@umd.edu'),
	('35', 'Sean Cao', 'Sean', 'Cao', 'Associate Professor', 'Ph.D., University of Illinois at Urbana-Champaign', 2022, 1, 'scao824@umd.edu'),
	('36', 'Louiqa Raschid', 'Louiqa', 'Raschid', 'Dean’s Professor of Information Systems', 'Ph.D. in Electrical Engineering, University of Florida, Gainesville', 1987, 37, 'lraschid@umd.edu'),
	('37', 'Vojislav Maksimovic', 'Vojislav', 'Maksimovic', 'Associate Director, C-BERC', 'Ph.D., Harvard University', 2007, 16, 'vmaksimovic@rhsmith.umd.edu'),
	('38', 'Paul Shapiro', 'Paul', 'Shapiro', 'Associate Clinical Professor', 'Ph.D Systems Engineering', 2019, 4, 'pshapiro@umd.edu'),
	('39', 'Haluk Ünal', 'Haluk', 'Ünal', 'Professor of Finance', 'Ph.D in Finance', 1988, 35, 'unal@umd.edu'),
	('40', 'Sarah Kroncke', 'Sarah', 'Kroncke', 'Senior Lecturer', 'MBA', 2006, 17, 'skroncke@rhsmith.umd.edu');

INSERT INTO [SmithSchoolRanking.Research]
VALUES
	('01', 'Mapping the Cocaine Supply Chain', 'Supply Chain', 150000, '10'),
	('02', 'Smith Researchers Address Liver Transplant Geographic Inequities', 'Manufacturing & Service Operations Management', 360000, '10'),
	('03', 'Bringing the Industry to Smith', 'Information Systems', 11000, '01'),
	('04', 'Restoring America’s Competitive Edge', 'U.S. Department of Education', 1520000, '05'),
	('05', 'Collaborative Research: Incentives in the Workplace', 'National Science Foundation', 679000, '05'),
	('06', 'Optimal Learning Framework for Post-Seismic Regional Building Damage Inference', 'Seismic Earthquake Detection', 161000, '06'),
	('07', 'Responsible AI: The Adoption of AI in Retail Product Pricing and Social Equity and Inclusion for Consumers', 'Artificial Intelligence', 150000, '35'),
	('08', 'Detecting and Mitigating Toxic Content in Online Platforms', 'Artificial Intelligence', 130000, '21'),
	('09', 'Data-Driven Fight Against Pandemics', 'Data Analysis', 90000, '36'),
	('10', 'Collaborative: Role of Intellectual Capital in predicting outcomes of Entrepreneurial Firms', 'Finance', 240000, '37'),
	('11', 'The Heterogeneous Diffusion of AI Skills,” and the creation of the “Smith AI Index', 'Artificial Intelligence', NULL, '09'),
	('12', 'AI for Efficient and Equitable Organ Allocation Policies', 'Artificial Intelligence', NULL, '07');

INSERT INTO [SmithSchoolRanking.Placement] 
VALUES
	('01',95,83000,2022,'Internet & Cloud Computing','Google','01'),
	('02',85,83000,2022,'Financial Services','CapitalOne','02'),
	('03',90,77000,2022,'Hospitality Service Provider','Marriott International','03'),
	('04',80,78780,2022,'Social Networking','Facebook','04'),
	('05',89,85000,2022,'Financial Services','Citi','05'),
	('06',78,66000,2022,'Audit, Tax and Advisory Services','KPMG','06'),
	('07',75,83000,2022,'Financial Services','Morgan Stanley','07'),
	('08',93,121103,2022,'Consulting','Deloitte','08'),
	('09',90,105026,2022,'E-Commerce','Amazon','09'),
	('10',92,114845,2022,'Technology Services','IBM','10'),
	('11',93,74311,2021,'Management, Consulting & Tech Firm','ZS Associates','01'),
	('12',86,59517,2021,'Financial Services','JPMorgan Chase and Co.','02'),
	('13',92,68409,2021,'Computer Services','Dell Technologies','03'),
	('14',79,75000,2021,'Technology Services','Apple Inc.','04'),
	('15',88,79516,2021,'Financial, Software and Media','Bloomberg L.P','05'),
	('16',80,61577,2021,'Consulting','Deloitte','06'),
	('17',74,69000,2021,'Professional Services','PwC','07'),
	('18',91,111070,2021,'Investment Banking','Goldman Sachs Group, Inc.','08'),
	('19',89,107371,2021,'Technology Services','Microsoft Corporation','09'),
	('20',93,113500,2021,'Accounting','EY','10'),
	('21',96,72737,2021,'Management, Consulting and Technology Firm','ZS Associates','01'),
	('22',90,57000,2021,'Financial Services','JPMorgan Chase and Co.','02'),
	('23',91,69580,2021,'Computer Services','Dell Technologies','03'),
	('24',76,63714,2021,'Technology Services','Apple Inc.','04'),
	('25',89,79000,2021,'Financial, Software and Media','Bloomberg L.P','05');

INSERT INTO [SmithSchoolRanking.Alumni]
VALUES
	('01','1950','Robert H. Smith','JBG Smith','Real Estate Developer','01'),
	('02','1950','Leo Van Munching','Heineken','CEO','08'),
	('03','1954','Allen J. Krowe','IBM','CEO','08'),
	('04','1955','Ed Snider','Comcast','Chairman','06'),
	('05','1966','William Mayer','Credit Suisse','CEO','08'),
	('06','1972','Michale J. Ward','CSX Corporation','CEO','08'),
	('07','1980','Carly Fiorina','Hewlett-Packard','CEO','10'),
	('08','1983','Rob McGovern','Career Builder','Founder','10'),
	('09','1991','Beatriz Perez','Coca-Cola','CSO','01'),
	('10','1996','Kevin Plank','Under Armour','Founder & CEO','10'),
	('11','2014','Shelbi Brookshire','UMD Smith School of Business Assistant','Dean','08'),
	('12','2018','Phillip Riordan','Booz Allen','Project Manager','08'),
	('13','2020','Nihal Poipatla','Abercrombie and Fitch','Customer Intelligence Analyst','01'),
	('14','2020','Varun Goenka','TruStage','Data Analyst IV','01'),
	('15','2015','John Malone','UMD Smith School of Business','Assistant Director','01'),
	('16','2023','Neha Sharma','Navy Federal Credit Union','Lending Data Analyst','02'),
	('17','2020','Humza Malik','SC&H Group','Senior Consultant','01'),
	('18','2020','Aniket Datar','PwC','Senior Associate','01'),
	('19','2019','Priya Ashok','Morgan Stanley','Associate','01'),
	('20','2021','Tyler Regino','Flybuy by Radius Networks','Product Manager','10'),
	('21','2019','Bryce Trezise','Deloitte','Senior Consultant','02'),
	('22','2019','Qingxia (Quency) Yu','Fetch Rewards','Senior Machine Learning Engineer','04'),
	('23','2020','Megha Komarraju','NICE CXone','Implementation Analyst','01'),
	('24','2022','Carrie Walczak','Capital One','Finance Associate','05'),
	('25','2022','Niani McDonald','UMD Smith School of Business','Data Analyst','04'),
	('26','2022','Tennie (U-Tung) Chang','Wunderman Thompson','Analyst','04'),
	('27','2016','Benjamin Eidelberg','Washington Wizards','Director, Basketball Strategy & Analytics','04'),
	('28','2022','Farid Freyha','Employbridge','Marketing Analyst','04'),
	('29','2019','Harriet Peng','Navy Federal Credit Union','Data Scientist','04'),
	('30','2020','Tanisha Sabhaney','WSAudiology','Product Marketing Analyst','04');

INSERT INTO [SmithSchoolRanking.Assign]
VALUES
	('01','01','BUDT704'),
	('03','02','BUDT731'),
	('02','01','BUDT721'),
	('04','01','BUDT702'),
	('04','02','BUDT702'),
	('05','08','BUSM761'),
	('39','05','BUFN732'),
	('07','01','BUDT723'),
	('07','08','BUSM750'),
	('40','05','BUFN730'),
	('33','06','BMGT417'),
	('20','10','EMBA788V'),
	('20','08','BUSM624'),
	('21','01','BUDT733'),
	('27','09','BUSI718K'),
	('24','09','BUSI610'),
	('31','06','BMGT220L');

-- SQL create views:

GO
DROP VIEW IF EXISTS ExamScoresView
GO
CREATE VIEW ExamScoresView AS
SELECT p.prgmAvgGREReq, p.prgmAvgTOFELReq
FROM [SmithSchoolRanking.Program] p
GO
SELECT *
FROM ExamScoresView;

GO
DROP VIEW IF EXISTS FacultyResearchView
GO
CREATE VIEW FacultyResearchView AS
SELECT f.facultyID ,f.facultyName, r.researchArea
FROM [SmithSchoolRanking.Faculty] f INNER JOIN [SmithSchoolRanking.Research] r
ON f.facultyID = r.researchID
GO
SELECT *
FROM FacultyResearchView;

-- SQL select statements:

SELECT * FROM [SmithSchoolRanking.Program];
SELECT * FROM [SmithSchoolRanking.Rank];
SELECT * FROM [SmithSchoolRanking.Faculty];
SELECT * FROM [SmithSchoolRanking.Research];
SELECT * FROM [SmithSchoolRanking.Placement];
SELECT * FROM [SmithSchoolRanking.Alumni];
SELECT * FROM [SmithSchoolRanking.Assign];