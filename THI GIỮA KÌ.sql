/*=========== TẠO CSDL ==============*/

CREATE DATABASE FootballManagement ;
USE FootballManagement ;                        			 -- Sử dụng CSDL

/*=========== TẠO BẢNG ==============*/

CREATE TABLE Players (
	PlayerId VARCHAR(10) PRIMARY KEY,
	FullName VARCHAR(100) NOT NULL,
	DOB DATE,
	Position ENUM ('ThuMon', 'HauVe', 'TienVe', 'TienDao'),
	Number INT NOT NULL
);

CREATE TABLE Matchs (
	MatchId VARCHAR(10) PRIMARY KEY,
	MatchName VARCHAR(100) NOT NULL,
	MatchDate DATE,
	Stadium VARCHAR(100)
);

CREATE TABLE MatchPerformance (
	PlayerId VARCHAR(10),
	MatchId VARCHAR(10),  
	MinutesPlayed INT,
	Goals INT default 0 , -- Mặc định là 0.
    foreign key (PlayerId) references Players (PlayerId), -- Khóa ngoại tham chiếu đến Players.
    foreign key (MatchId) references Matchs (MatchId)     -- Khóa ngoại tham chiếu đến Matchs.
														  -- Khóa chính: Là sự kết hợp của (PlayerId, MatchId).
);


/*=========== THÊM DỮ LIỆU ==============*/

INSERT INTO Players (PlayerId, FullName, DOB, Position, Number) 
VALUES 
	('CT01', 'Dang Van Lam', '1993-08-13', 'ThuMon', 1),
	('CT02', 'Que Ngoc Hai', '1993-05-15', 'HauVe', 3),
	('CT03', 'Nguyen Quang Hai', '1997-04-12', 'TienVe', 19),
	('CT04', 'Nguyen Tien Linh', '1997-10-20', 'TienDao', 22),
	('CT05', 'Do Hung Dung', '1993-09-08', 'TienVe', 8);
    
INSERT INTO Matchs (MatchId, MatchName, MatchDate, Stadium) 
VALUES
	('TD01', 'Viet Nam - Thai Lan', '2023-01-13', 'My Dinh'),
	('TD02', 'Viet Nam - Indonesia', '2023-01-09', 'My Dinh'),
	('TD03', 'Viet Nam - Malaysia', '2022-12-27', 'My Dinh');
    
INSERT INTO MatchPerformance (PlayerId, MatchId, MinutesPlayed, Goals) 
VALUES
	('CT01', 'TD01', 90, 0),
	('CT03', 'TD01', 85, 1),
	('CT04', 'TD01', 90, 1),
	('CT02', 'TD02', 90, 0),
	('CT04', 'TD02', 70, 2),
	('CT03', 'TD03', 90, 1),
	('CT05', 'TD03', 60, 0);
    

/*=========== CẬP NHẬT DỮ LIỆU ==============*/

UPDATE Matchs SET Stadium = 'Thammasat'
WHERE MatchId = 'TD01';

UPDATE MatchPerformance SET Goals = 3
where PlayerId = 'CT04' AND MatchId = 'TD02';

DELETE FROM MatchPerformance 
WHERE PlayerId = 'CT05' AND MatchId = 'TD03';

 
 /*==========TRUY VẤN DỮ LIỆU==============*/
 
SELECT PlayerId, FullName, Position 
FROM players
WHERE Position = 'TienDao';

SELECT MatchName, MatchDate 
FROM matchs
WHERE Stadium = 'My Dinh';

SELECT PlayerId, MatchId, Goals
FROM MatchPerformance
WHERE Goals >= 1;

SELECT FullName 
FROM players
WHERE FullName LIKE '%Hai' ;

SELECT * FROM matchperformance 
ORDER BY MinutesPlayed DESC;

SELECT PlayerId, FullName, DOB, Position, Number
FROM players
ORDER BY DOB ASC
LIMIT 2;


SELECT MatchId, SUM(Goals) AS TotalGoals
FROM MatchPerformance
GROUP BY MatchId;

SELECT Position, COUNT(*) AS NumberOfPlayer
FROM Players
GROUP BY Position;

SELECT PlayerId, COUNT(MatchId) AS TotalMatches
FROM MatchPerformance
GROUP BY PlayerId
HAVING COUNT(MatchId) >= 2;
















