PRAGMA auto_vacuum = 1;
PRAGMA encoding = 'UTF-8';
PRAGMA foreign_keys = 1;
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;

CREATE TABLE IF NOT EXISTS Wohnort (
    WohnortID INTEGER
        PRIMARY KEY AUTOINCREMENT,
    Stadt VARCHAR(255) NOT NULL
        CHECK (
            Stadt IS NOT '' AND
            Stadt GLOB '[ -~]*'
            ),
    PLZ INTEGER NOT NULL
        CHECK (PLZ > 0 AND
               PLZ < 10000
            ),
    Strasse VARCHAR(255) NOT NULL
        CHECK (
            Strasse IS NOT '' AND
            Strasse GLOB '[ -~]*'
            ),
    Hausnummer VARCHAR(255) NOT NULL
        CHECK (
            (
                Hausnummer GLOB '[1-9][0-9]{0,2}-[A-Za-z]' AND LENGTH(Hausnummer) BETWEEN 2 AND 5
                ) OR (
                Hausnummer GLOB '[1-9][0-9]{0,2}[A-Za-z]' AND LENGTH(Hausnummer) BETWEEN 1 AND 4
                )
            )
);

CREATE TABLE IF NOT EXISTS Nutzer (
    EMAIL VARCHAR(255)
        PRIMARY KEY
        COLLATE NOCASE
        CHECK (
            EMAIL IS NOT '' AND
            EMAIL GLOB '[A-Za-z0-9]*@[A-Za-z0-9]*\.[A-Za-z]*'
            ),
    Vorname VARCHAR(255) NOT NULL
        CHECK (
            Vorname IS NOT '' AND
            Vorname GLOB '[ -~]*'
            ),
    Nachname VARCHAR(255) NOT NULL
        CHECK (
            Nachname IS NOT '' AND
            Nachname GLOB '[ -~]*'
            ),
    Passwort VARCHAR(255) NOT NULL
        CHECK (
            Passwort IS NOT '' AND
            Passwort GLOB '[ -~]*'
            )
);

CREATE TABLE IF NOT EXISTS Buerger (
    EMAIL VARCHAR(255)
        PRIMARY KEY,
    WohnortID INTEGER,
    FOREIGN KEY (EMAIL)
        REFERENCES Nutzer (EMAIL),
    FOREIGN KEY (WohnortID)
        REFERENCES Wohnort (WohnortID)
);

CREATE TABLE IF NOT EXISTS Gaertner (
    EMAIL VARCHAR(255)
        PRIMARY KEY,
    FOREIGN KEY (EMAIL)
        REFERENCES Nutzer (EMAIL)
);

CREATE TABLE IF NOT EXISTS Pflanzentyp (
    PflanzentypID INTEGER
        PRIMARY KEY AUTOINCREMENT,
    Typ VARCHAR(255) NOT NULL
        CHECK (
            Typ IS NOT '' AND
            Typ GLOB '[ -~]*'
            )
);

CREATE TABLE IF NOT EXISTS Standort (
    StandortID INTEGER
        PRIMARY KEY AUTOINCREMENT,
    Breitengrad VARCHAR(255) NOT NULL
        CHECK (
            Breitengrad IS NOT '' AND
            Breitengrad GLOB '[ -~]*'
            ),
    Laengengrad VARCHAR(255) NOT NULL
        CHECK (
            Laengengrad IS NOT '' AND
            Laengengrad GLOB '[ -~]*'
            )
);

CREATE TABLE IF NOT EXISTS Pflanze (
    PflanzeID INTEGER
        PRIMARY KEY AUTOINCREMENT,
    lateinische_Bezeichnung VARCHAR(255) NOT NULL
        CHECK (
            lateinische_Bezeichnung IS NOT '' AND
            lateinische_Bezeichnung GLOB '[ -~]*'
            ),
    deutsche_Bezeichnung VARCHAR(255) NOT NULL
        CHECK (
            deutsche_Bezeichnung IS NOT '' AND
            deutsche_Bezeichnung GLOB '[ -~]*'
            ),
    Datum DATETIME
        CHECK (Datum IS NULL OR DATETIME(Datum) LIKE '____-__-__ __:__:__'),
    PflanzentypID INTEGER NOT NULL,
    StandortID INTEGER NOT NULL,
    EMAIL VARCHAR(255) NOT NULL,
    FOREIGN KEY (PflanzentypID)
        REFERENCES Pflanzentyp (PflanzentypID),
    FOREIGN KEY (StandortID)
        REFERENCES Standort (StandortID),
    FOREIGN KEY (EMAIL)
        REFERENCES Buerger (EMAIL)
);

CREATE TABLE IF NOT EXISTS Bild (
    BildID INTEGER
        PRIMARY KEY AUTOINCREMENT,
    Pfad VARCHAR(255) NOT NULL
        CHECK (
            Pfad IS NOT '' AND
            Pfad GLOB '[ -~]*'
            ),
    PflanzeID INTEGER NOT NULL,
    FOREIGN KEY (PflanzeID)
        REFERENCES Pflanze (PflanzeID)
);

CREATE TABLE IF NOT EXISTS Pflegeart (
    PflegeartID INTEGER
        PRIMARY KEY AUTOINCREMENT,
    Art VARCHAR(255) NOT NULL
        CHECK (
            Art IS NOT '' AND
            Art GLOB '[A-Za-z]*'
            )
);

CREATE TABLE IF NOT EXISTS Pflegemassnahme (
    PflegemassnahmeID INTEGER
        PRIMARY KEY AUTOINCREMENT,
    Datum DATE NOT NULL,
    EMAIL VARCHAR(255) NOT NULL,
    PflegeartID INTEGER NOT NULL,
    FOREIGN KEY (EMAIL)
        REFERENCES Gaertner (EMAIL),
    FOREIGN KEY (PflegeartID)
        REFERENCES Pflegeart (PflegeartID)
);


CREATE TABLE IF NOT EXISTS Pflegeprotokoll (
    PflegeprotokollID INTEGER
        PRIMARY KEY AUTOINCREMENT,
    EMAIL VARCHAR(255) NOT NULL,
    FOREIGN KEY (EMAIL)
        REFERENCES Gaertner (EMAIL)
);

CREATE TABLE IF NOT EXISTS Spezialisierung (
    SpezialisierungID INTEGER
        PRIMARY KEY AUTOINCREMENT,
    Art VARCHAR(255) NOT NULL
        CHECK (Art IS NOT '' AND
               Art GLOB '[A-Za-z]*'
            )
);



CREATE TABLE IF NOT EXISTS nimmtTeil (
    EMAIL VARCHAR(255),
    PflegemassnahmeID INTEGER,
    PRIMARY KEY (EMAIL, PflegemassnahmeID),
    FOREIGN KEY (EMAIL)
        REFERENCES Buerger (EMAIL),
    FOREIGN KEY (PflegemassnahmeID)
        REFERENCES Pflegemassnahme (PflegemassnahmeID)
);

CREATE TABLE IF NOT EXISTS hat (
    EMAIL VARCHAR(255),
    SpezialisierungID INTEGER,
    PRIMARY KEY (EMAIL, SpezialisierungID),
    FOREIGN KEY (EMAIL)
        REFERENCES Gaertner (EMAIL),
    FOREIGN KEY (SpezialisierungID)
        REFERENCES Spezialisierung (SpezialisierungID)
);

CREATE TABLE IF NOT EXISTS pflanztEin (
    PflanzeID INTEGER
        PRIMARY KEY,
    EMAIL VARCHAR(255) NOT NULL,
    FOREIGN KEY (PflanzeID)
        REFERENCES Pflanze (PflanzeID),
    FOREIGN KEY (EMAIL)
        REFERENCES Gaertner (EMAIL)
);

CREATE TABLE IF NOT EXISTS zugeordnet (
    PflanzeID INTEGER,
    PflegemassnahmeID INTEGER,
    PRIMARY KEY (PflanzeID, PflegemassnahmeID),
    FOREIGN KEY (PflanzeID)
        REFERENCES Pflanze (PflanzeID),
    FOREIGN KEY (PflegemassnahmeID)
        REFERENCES Pflegemassnahme (PflegemassnahmeID)
);

CREATE TABLE IF NOT EXISTS bewertet (
    EMAIL VARCHAR(255),
    PflegemassnahmeID INTEGER,
    Skala INTEGER NOT NULL,
    PRIMARY KEY (EMAIL, PflegemassnahmeID),
    FOREIGN KEY (EMAIL)
        REFERENCES Gaertner (EMAIL),
    FOREIGN KEY (PflegemassnahmeID)
        REFERENCES Pflegemassnahme (PflegemassnahmeID)
);

CREATE TABLE IF NOT EXISTS kommtVor (
    PflegemassnahmeID INTEGER,
    PflegeprotokollID INTEGER,
    Erfolg TEXT NOT NULL
        CHECK (Erfolg IS NOT '' AND
               Erfolg GLOB '[ -~]*'
            ),
    PRIMARY KEY (PflegemassnahmeID, PflegeprotokollID),
    FOREIGN KEY (PflegemassnahmeID)
        REFERENCES Pflegemassnahme (PflegemassnahmeID),
    FOREIGN KEY (PflegeprotokollID)
        REFERENCES Pflegeprotokoll (PflegeprotokollID)
);

CREATE TABLE IF NOT EXISTS setztVoraus (
    Pflegemassnahme1ID INTEGER
        PRIMARY KEY,
    Pflegemassnahme2ID INTEGER NOT NULL,
    FOREIGN KEY (Pflegemassnahme1ID)
        REFERENCES Pflegemassnahme (PflegemassnahmeID),
    FOREIGN KEY (Pflegemassnahme2ID)
        REFERENCES Pflegemassnahme (PflegemassnahmeID)
);