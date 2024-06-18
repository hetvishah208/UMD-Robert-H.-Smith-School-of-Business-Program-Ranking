-- Team 10 SQL Samurai

USE BUDT702_Project_0502_10

-- List of Business Transactions / WH Questions :
-- 1. Which is the highest ranking earned by each program at the Robert H. Smith School of Business over the years ? Also specify the year in which the highest ranking was achieved ? Solve using a non-correlating subquery.
-- 2. Who are the faculty members with top 3 research grants. Specify all the details of the faculty along with the grant amounts in descending order.
-- 3. For the year 2022, which program had the best placement record, and what was the rank achieved corresponding to the program ?
-- 4. What are the details of the faculty members of the top-ranked program the current year (i.e., 2023). Also display the courses being taught by the respective faculty. Solve using a non-correlating sub-query.
-- 5. Create a view - For the currently top 2 ranked programs, what are the average GRE and TOEFL score requirements ?
-- 6. Create a view - Who are the alumni of the program that has achieved the highest ranking in 2023. What have they achieved ?

-- QUESTION 1: Which is the highest ranking earned by each program at the Robert H. Smith School of Business ? Also specify the year in which the highest ranking was achieved ? Solve using a non-correlating subquery.

SELECT p.prgmName AS 'Program Name', r.prgmRankYear AS 'Program Ranking Year', r.ranking AS 'Highest Ranking Achieved'
FROM [SmithSchoolRanking.Program] p INNER JOIN [SmithSchoolRanking.Rank] r ON p.prgmId = r.prgmId
INNER JOIN (
  SELECT prgmId, MIN(ranking) AS highest_rank
  FROM [SmithSchoolRanking.Rank]
  GROUP BY prgmId
) highest_ranking
ON r.prgmId = highest_ranking.prgmId AND r.ranking = highest_ranking.highest_rank;

-- QUESTION 2 : Who are the faculty members with top 3 research grants. Specify all the details of the faculty along with the grant amounts in descending order.

SELECT TOP 3 f.facultyName AS 'Faculty Name', f.facultyTitle AS 'Faculty Title', f.facultyQualification AS 'Qualification', re.researchTitle AS 'Research Title',
re.researchArea AS 'Area of Interest', re.researchGrant AS 'Grant Amount (in $)'
FROM [SmithSchoolRanking.Faculty] f INNER JOIN [SmithSchoolRanking.Research] re
ON f.facultyID = re.researchID
ORDER BY re.researchGrant DESC;

-- QUESTION 3 : For the year 2022, which program had the best placement record, and what was the rank achieved corresponding to the program ?

SELECT TOP 1 p.prgmName AS 'Program Name', r.ranking AS 'Program Rank', pl.placementRate AS 'Placement Rate (in %)'
FROM [SmithSchoolRanking.Program] p INNER JOIN [SmithSchoolRanking.Placement] pl
ON p.prgmID = pl.prgmID INNER JOIN [SmithSchoolRanking.Rank] r
ON r.prgmID = pl.prgmID
WHERE YEAR(r.prgmRankYear) = 2022
ORDER BY pl.placementRate DESC;

-- QUESTION 4 : What are the details of the faculty members of the top-ranked program the current year (i.e., 2023). Also display the courses being taught by the respective faculty. Solve using a non-correlating sub-query.

SELECT f.facultyName AS 'Faculty Name', f.facultyDOJ AS 'Faculty Date of Joining', f.facultyEmpDurationInYears AS 'Faculty Employment Duration (in years)',
f.facultyQualification AS 'Faculty Qualification', a.courseName AS 'Course Name'
FROM [SmithSchoolRanking.Faculty] f INNER JOIN [SmithSchoolRanking.Assign] a
ON f.facultyID = a.facultyID INNER JOIN [SmithSchoolRanking.Rank] r ON a.prgmID = r.prgmID
WHERE r.ranking IN (
	SELECT MIN(ranking)
	FROM [SmithSchoolRanking.Rank]
	WHERE prgmRankYear = YEAR(GETDATE())
);

-- QUESTION 5 : Create a view - For the currently top 2 ranked programs, what are the average GRE and TOEFL score requirements ?

GO
DROP VIEW IF EXISTS ExamScoresView
GO
CREATE VIEW ExamScoresView AS
SELECT TOP 2 p.prgmName AS 'Program Name', p.prgmAvgGREReq AS 'GRE Requirements', p.prgmAvgTOFELReq AS 'TOEFL Requiremnts'
FROM [SmithSchoolRanking.Rank] r INNER JOIN [SmithSchoolRanking.Program] p
ON r.prgmID = p.prgmID
WHERE r.prgmRankYear = 2023
ORDER BY r.ranking ASC;
GO
SELECT *
FROM ExamScoresView;

-- QUESTION 6 : Create a view - Who are the alumni of the program that has achieved the highest ranking in 2023. What have they achieved ?

GO
DROP VIEW IF EXISTS AlumniInfoView
GO
CREATE VIEW AlumniInfoView AS
SELECT a.alumniName AS 'Alumni Name', a.alumniGraduationYear AS 'Alumni Graduation Year', p.prgmName AS 'Program Name', a.alumniCompanyName AS 'Alumni Company Name', a.alumniDesignation AS 'Alumni Designation'
FROM [SmithSchoolRanking.Alumni] a INNER JOIN [SmithSchoolRanking.Rank] r
ON a.prgmID = r.prgmID INNER JOIN [SmithSchoolRanking.Program] p
ON a.prgmID = p.prgmID
WHERE r.ranking IN (
	SELECT MIN(ranking)
	FROM [SmithSchoolRanking.Rank]
	WHERE prgmRankYear = 2023
)
GO
SELECT *
FROM AlumniInfoView;