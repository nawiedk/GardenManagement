PRAGMA auto_vacuum = 1;
PRAGMA encoding = 'UTF-8';
PRAGMA foreign_keys = 1;
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;


SELECT *
FROM Pflanze
WHERE PflanzeID NOT IN (
    SELECT DISTINCT PflanzeID
    )


SELECT



SELECT *
FROM Pflegemassnahme
WHERE Datum BETWEEN '2022-12-12' And '2023-02-28';