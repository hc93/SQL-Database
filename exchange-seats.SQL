-- Logic:
-- odd id (not the last id) --> id + 1
-- odd id (last id) --> id
-- even id --> id - 1

-- IF
SELECT IF(id % 2 = 0, id-1, if(id = (SELECT COUNT(*) FROM seat), id, id+1) ) AS id, student
FROM seat
ORDER BY id ASC

-- CASE WHEN
SELECT (CASE WHEN id % 2 != 0 AND id != cnt THEN id + 1
             WHEN id % 2 != 0 AND id = cnt THEN id
        ELSE id - 1 END) AS id, student
FROM seat, (SELECT COUNT(*) AS cnt FROM seat) AS t
ORDER BY id ASC
