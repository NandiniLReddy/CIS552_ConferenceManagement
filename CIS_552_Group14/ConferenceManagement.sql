-- Table to store information about conferences
CREATE TABLE Conferences (
    ConferenceID INT,
    PartitionID INT,  -- Added for partitioning
    ConferenceName VARCHAR(255) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Venue VARCHAR(255) NOT NULL,
    PRIMARY KEY (ConferenceID, PartitionID)
);

-- Table to store information about speakers
CREATE TABLE Speakers (
    SpeakerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Bio TEXT
);

-- Table to store information about conference sessions
CREATE TABLE Sessions (
    SessionID INT,
    PartitionID INT,
    SessionTitle VARCHAR(255) NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    ConferenceID INT,
    SpeakerID INT,
    PRIMARY KEY (SessionID, PartitionID),
    FOREIGN KEY (ConferenceID, PartitionID) REFERENCES Conferences(ConferenceID, PartitionID),
    FOREIGN KEY (SpeakerID) REFERENCES Speakers(SpeakerID) 
);

-- Table to store information about attendees
CREATE TABLE Attendees (
    AttendeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    RegistrationDate DATE NOT NULL
);

-- Table to track attendance of attendees in sessions
CREATE TABLE SessionAttendance (
    SessionID INT,
    AttendeeID INT,
    PRIMARY KEY (SessionID, AttendeeID),
    FOREIGN KEY (SessionID) REFERENCES Sessions(SessionID),
    FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
);

-- Table to store information about sponsors
CREATE TABLE Sponsors (
    SponsorID INT PRIMARY KEY,
    SponsorName VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(100),
    Email VARCHAR(100) NOT NULL
);

-- Table to associate sponsors with conferences
CREATE TABLE ConferenceSponsors (
    ConferenceID INT,
    SponsorID INT,
    PRIMARY KEY (ConferenceID, SponsorID),
    FOREIGN KEY (ConferenceID) REFERENCES Conferences(ConferenceID),
    FOREIGN KEY (SponsorID) REFERENCES Sponsors(SponsorID)
);
-- Table to store information about publications
CREATE TABLE Publications (
    PublicationID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Authors TEXT NOT NULL,
    PublicationDate DATE,
    ConferenceID INT,
    FOREIGN KEY (ConferenceID) REFERENCES Conferences(ConferenceID)
);

-- Table to store information about presentations
CREATE TABLE Presentations (
    PresentationID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    SessionID INT,
    SpeakerID INT,
    FOREIGN KEY (SessionID) REFERENCES Sessions(SessionID),
    FOREIGN KEY (SpeakerID) REFERENCES Speakers(SpeakerID)
);

-- Table to store information about users (e.g., organizers, admins)
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    UserType VARCHAR(20) NOT NULL -- e.g., 'Organizer', 'Admin'
);

-- Table to store information about registration
CREATE TABLE Registrations (
    RegistrationID INT PRIMARY KEY,
    AttendeeID INT,
    ConferenceID INT,
    RegistrationDate DATE NOT NULL,
    FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID),
    FOREIGN KEY (ConferenceID) REFERENCES Conferences(ConferenceID)
);

-- Table to store information about feedback on sessions
CREATE TABLE SessionFeedback (
    SessionID INT,
    AttendeeID INT,
    Rating INT, -- Add other feedback fields as needed
    PRIMARY KEY (SessionID, AttendeeID),
    FOREIGN KEY (SessionID) REFERENCES Sessions(SessionID),
    FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
);

-- Table to store information about conference rooms or locations
CREATE TABLE ConferenceLocations (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(255) NOT NULL
);

-- Table to associate locations with conferences
CREATE TABLE ConferenceLocationMapping (
    ConferenceID INT,
    LocationID INT,
    PRIMARY KEY (ConferenceID, LocationID),
    FOREIGN KEY (ConferenceID) REFERENCES Conferences(ConferenceID),
    FOREIGN KEY (LocationID) REFERENCES ConferenceLocations(LocationID)
);


INSERT INTO Conferences (ConferenceID, PartitionID, ConferenceName, StartDate, EndDate, Venue)
VALUES (1, 1, 'Conference 1', '2023-01-01', '2023-01-03', 'Venue 1');

INSERT INTO Conferences (ConferenceID, PartitionID, ConferenceName, StartDate, EndDate, Venue)
VALUES (2, 1, 'Conference 2', '2023-02-01', '2023-02-03', 'Venue 2');

INSERT INTO Speakers (SpeakerID, FirstName, LastName, Email, Bio)
VALUES (1, 'John', 'Doe', 'john.doe@example.com', 'Experienced speaker in the field.');

INSERT INTO Speakers (SpeakerID, FirstName, LastName, Email, Bio)
VALUES (2, 'Jane', 'Smith', 'jane.smith@example.com', 'Renowned expert in the industry.');

INSERT INTO Sessions (SessionID, PartitionID, SessionTitle, StartTime, EndTime, ConferenceID, SpeakerID)
VALUES (1, 1, 'Introduction to AI', '2023-01-01 10:00:00', '2023-01-01 11:30:00', 1, 1);

INSERT INTO Sessions (SessionID, PartitionID, SessionTitle, StartTime, EndTime, ConferenceID, SpeakerID)
VALUES (2, 1, 'Advanced Machine Learning', '2023-01-02 14:00:00', '2023-01-02 15:30:00', 1, 2);

INSERT INTO Attendees (AttendeeID, FirstName, LastName, Email, RegistrationDate)
VALUES (1, 'Alice', 'Johnson', 'alice.johnson@example.com', '2023-01-01');

INSERT INTO Attendees (AttendeeID, FirstName, LastName, Email, RegistrationDate)
VALUES (2, 'Bob', 'Miller', 'bob.miller@example.com', '2023-01-02');

INSERT INTO SessionAttendance (SessionID, AttendeeID)
VALUES (1, 1);

INSERT INTO SessionAttendance (SessionID, AttendeeID)
VALUES (2, 2);

INSERT INTO Sponsors (SponsorID, SponsorName, ContactPerson, Email)
VALUES (1, 'Tech Corp', 'John Tech', 'john.tech@techcorp.com');

INSERT INTO Sponsors (SponsorID, SponsorName, ContactPerson, Email)
VALUES (2, 'Innovate Solutions', 'Jane Innovate', 'jane.innovate@innovatesolutions.com');

INSERT INTO ConferenceSponsors (ConferenceID, SponsorID)
VALUES (1, 1);

INSERT INTO ConferenceSponsors (ConferenceID, SponsorID)
VALUES (2, 2);

INSERT INTO Publications (PublicationID, Title, Authors, PublicationDate, ConferenceID)
VALUES (1, 'Advances in AI', 'John Doe, Jane Smith', '2023-01-15', 1);

INSERT INTO Publications (PublicationID, Title, Authors, PublicationDate, ConferenceID)
VALUES (2, 'Data Science Trends', 'Alice Johnson, Bob Miller', '2023-02-01', 2);

INSERT INTO Presentations (PresentationID, Title, SessionID, SpeakerID)
VALUES (1, 'AI in Healthcare', 1, 1);

INSERT INTO Presentations (PresentationID, Title, SessionID, SpeakerID)
VALUES (2, 'Future of Machine Learning', 2, 2);

INSERT INTO Users (UserID, Username, Password, UserType)
VALUES (1, 'admin', 'admin123', 'Admin');

INSERT INTO Users (UserID, Username, Password, UserType)
VALUES (2, 'organizer', 'organizer456', 'Organizer');

INSERT INTO Registrations (RegistrationID, AttendeeID, ConferenceID, RegistrationDate)
VALUES (1, 1, 1, '2023-01-01');

INSERT INTO Registrations (RegistrationID, AttendeeID, ConferenceID, RegistrationDate)
VALUES (2, 2, 2, '2023-02-01');

INSERT INTO SessionFeedback (SessionID, AttendeeID, Rating)
VALUES (1, 1, 5);

INSERT INTO SessionFeedback (SessionID, AttendeeID, Rating)
VALUES (2, 2, 4);

SELECT DATABASE();

SELECT USER(), CURRENT_USER();

SELECT @@hostname;

ALTER USER 'root'@'localhost' IDENTIFIED BY '#1810nandinilreddy';

ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY '#1810nandinilreddy';

FLUSH PRIVILEGES;

INSERT INTO Conferences (ConferenceID, PartitionID, ConferenceName, StartDate, EndDate, Venue)
VALUES 
  (4, 1, 'Conference 4', '2023-04-01', '2023-04-03', 'Venue 4'),
  (5, 1, 'Conference 5', '2023-05-01', '2023-05-03', 'Venue 5'),
  (6, 1, 'Conference 6', '2023-06-01', '2023-06-03', 'Venue 6'),
  (7, 1, 'Conference 7', '2023-07-01', '2023-07-03', 'Venue 7'),
  (8, 1, 'Conference 8', '2023-08-01', '2023-08-03', 'Venue 8'),
  (9, 1, 'Conference 9', '2023-09-01', '2023-09-03', 'Venue 9'),
  (10, 1, 'Conference 10', '2023-10-01', '2023-10-03', 'Venue 10'),
  (11, 1, 'Conference 11', '2023-11-01', '2023-11-03', 'Venue 11'),
  (12, 1, 'Conference 12', '2023-12-01', '2023-12-03', 'Venue 12'),
  (13, 1, 'Conference 13', '2024-01-01', '2024-01-03', 'Venue 13');

-- Additional Speakers
INSERT INTO Speakers (SpeakerID, FirstName, LastName, Email, Bio)
VALUES 
  (4, 'Emily', 'Williams', 'emily.williams@example.com', 'Specialist in Data Science.'),
  (5, 'Michael', 'Johnson', 'michael.johnson@example.com', 'AI researcher with extensive experience.'),
  (6, 'Sophia', 'Lee', 'sophia.lee@example.com', 'Machine Learning enthusiast.');

-- Additional Sessions
INSERT INTO Sessions (SessionID, PartitionID, SessionTitle, StartTime, EndTime, ConferenceID, SpeakerID)
VALUES 
  (4, 1, 'Data Science Workshop', '2023-04-01 14:00:00', '2023-04-01 16:00:00', 4, 4),
  (5, 1, 'Ethics in AI', '2023-05-01 10:00:00', '2023-05-01 11:30:00', 5, 5),
  (6, 1, 'Neural Networks Fundamentals', '2023-06-01 15:00:00', '2023-06-01 16:30:00', 6, 6);

-- Additional Attendees
INSERT INTO Attendees (AttendeeID, FirstName, LastName, Email, RegistrationDate)
VALUES 
  (4, 'David', 'Brown', 'david.brown@example.com', '2023-03-15'),
  (5, 'Olivia', 'Taylor', 'olivia.taylor@example.com', '2023-04-20'),
  (6, 'Daniel', 'Anderson', 'daniel.anderson@example.com', '2023-05-10');

-- Additional Session Attendance
INSERT INTO SessionAttendance (SessionID, AttendeeID)
VALUES 
  (4, 4),
  (5, 5),
  (6, 6);

-- Additional Sponsors
INSERT INTO Sponsors (SponsorID, SponsorName, ContactPerson, Email)
VALUES 
  (4, 'Data Solutions Ltd', 'Alex Data', 'alex.data@datasolutions.com'),
  (5, 'AI Innovations', 'Mark AI', 'mark.ai@aiinnovations.com');

-- Additional Conference Sponsors
INSERT INTO ConferenceSponsors (ConferenceID, SponsorID)
VALUES 
  (4, 4),
  (5, 5);


-- Additional Publications
INSERT INTO Publications (PublicationID, Title, Authors, PublicationDate, ConferenceID)
VALUES 
  (1, 'Big Data Trends', 'Michael Johnson, Sophia Lee', '2023-05-15', 3),
  (1, 'AI and Ethics Handbook', 'Emily Williams, Michael Johnson', '2023-06-01', 4);

-- Additional Presentations
INSERT INTO Presentations (PresentationID, Title, SessionID, SpeakerID)
VALUES 
  (3, 'Practical Data Science', 4, 4),
  (4, 'AI in Business Strategy', 5, 5);

-- Additional Users
INSERT INTO Users (UserID, Username, Password, UserType)
VALUES 
  (3, 'editor', 'editor789', 'Editor'),
  (4, 'reviewer', 'reviewer123', 'Reviewer');

-- Additional Registrations
INSERT INTO Registrations (RegistrationID, AttendeeID, ConferenceID, RegistrationDate)
VALUES 
  (3, 3, 3, '2023-06-01'),
  (4, 4, 4, '2023-07-01');

-- Additional Session Feedback
INSERT INTO SessionFeedback (SessionID, AttendeeID, Rating)
VALUES 
  (3, 3, 4),
  (4, 4, 5);

-- Data Collection:
-- Retrieve basic information about all conferences
SELECT ConferenceID, ConferenceName, StartDate, EndDate, Venue
FROM Conferences;

-- Retrieve the list of speakers for a specific conference
SELECT SpeakerID, FirstName, LastName, Email
FROM Speakers
WHERE SpeakerID IN (
    SELECT DISTINCT SpeakerID
    FROM Sessions
    WHERE ConferenceID = 1  -- Replace with the desired ConferenceID
);

-- Count the number of attendees in each session of a specific conference
SELECT s.SessionID, s.SessionTitle, COUNT(sa.AttendeeID) AS AttendeeCount
FROM Sessions s
LEFT JOIN SessionAttendance sa ON s.SessionID = sa.SessionID
WHERE s.ConferenceID = 1  -- Replace with the desired ConferenceID
GROUP BY s.SessionID, s.SessionTitle;

-- Find sessions that overlap in time for a specific conference
SELECT s1.SessionID AS Session1ID, s1.SessionTitle AS Session1Title,
       s2.SessionID AS Session2ID, s2.SessionTitle AS Session2Title
FROM Sessions s1, Sessions s2
WHERE s1.ConferenceID = 1  -- Replace with the desired ConferenceID
  AND s2.ConferenceID = 1
  AND s1.SessionID <> s2.SessionID
  AND ((s1.StartTime <= s2.StartTime AND s1.EndTime >= s2.StartTime)
       OR (s2.StartTime <= s1.StartTime AND s2.EndTime >= s1.StartTime));

-- Retrieve top-rated sessions based on attendee feedback
SELECT s.SessionID, s.SessionTitle, AVG(sf.Rating) AS AverageRating
FROM Sessions s
LEFT JOIN SessionFeedback sf ON s.SessionID = sf.SessionID
WHERE s.ConferenceID = 1  -- Replace with the desired ConferenceID
GROUP BY s.SessionID, s.SessionTitle
ORDER BY AverageRating DESC
LIMIT 5;  -- Adjust the limit based on your requirements


-- SQL Queries 

SELECT ConferenceName, StartDate, EndDate, Venue
FROM Conferences;

SELECT SpeakerID, FirstName, LastName, Email
FROM Speakers
WHERE SpeakerID IN (
    SELECT DISTINCT SpeakerID
    FROM Sessions
    WHERE ConferenceID = 1
);

SELECT s.SessionID, s.SessionTitle, s.StartTime, s.EndTime
FROM Sessions s
JOIN SessionAttendance sa ON s.SessionID = sa.SessionID
WHERE sa.AttendeeID = 1;

SELECT SessionID, AVG(Rating) AS AverageRating
FROM SessionFeedback
GROUP BY SessionID
ORDER BY AverageRating DESC;

SELECT PresentationID, Title, COUNT(*) AS AttendeeCount
FROM SessionAttendance
JOIN Presentations ON SessionAttendance.SessionID = Presentations.SessionID
GROUP BY PresentationID
ORDER BY AttendeeCount DESC;

SELECT SponsorName, ContactPerson, Email
FROM Sponsors
WHERE SponsorID IN (
    SELECT SponsorID
    FROM ConferenceSponsors
    
);

-- OPTIMIZATION

SELECT Sessions.SessionID, Sessions.SessionTitle, Sessions.StartTime, Sessions.EndTime, COUNT(SessionAttendance.AttendeeID) AS AttendanceCount
FROM Sessions
LEFT JOIN SessionAttendance ON Sessions.SessionID = SessionAttendance.SessionID
GROUP BY Sessions.SessionID, Sessions.SessionTitle, Sessions.StartTime, Sessions.EndTime;


SELECT s.SessionID, s.SessionTitle, s.StartTime, s.EndTime, COUNT(sa.AttendeeID) AS AttendanceCount
FROM Sessions s
LEFT JOIN SessionAttendance sa ON s.SessionID = sa.SessionID
GROUP BY s.SessionID, s.SessionTitle, s.StartTime, s.EndTime;

-- QUESTIONS AND ANSWERS 

SELECT SessionID, SessionTitle, StartTime, EndTime
FROM Sessions
WHERE ConferenceID = 1;

SELECT AVG(Rating) AS AverageRating
FROM SessionFeedback sf
JOIN Sessions s ON sf.SessionID = s.SessionID
WHERE s.ConferenceID = 1;


SELECT SponsorID, SponsorName
FROM Sponsors
WHERE SponsorID IN (SELECT SponsorID FROM ConferenceSponsors WHERE ConferenceID = 1);



