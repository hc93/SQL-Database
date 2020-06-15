-- Write a sql to find the name of the winning candidate.
-- You may assume there is no tie, in other words there will be at most one winning candidate.


SELECT Name FROM Candidate
WHERE id = (
    SELECT CandidateID FROM Vote
    GROUP BY CandidateID
    ORDER BY COUNT(CandidateID) DESC
    LIMIT 1
  )

-- using JOIN

SELECT Name FROM Candidate
JOIN
  ( SELECT CandidateID FROM Vote
    GROUP BY CandidateID
    ORDER BY COUNT(CandidateID) DESC
    LIMIT 1 ) AS winner
ON (Candidate.id = winner.CandidateID)
