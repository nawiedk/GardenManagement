# Blatt 1

Erstellen eines ER-Modells der Datenbank

## Kritische Entscheidungen


Die wichtigsten Entscheidungen die ich getroffen habe, wären zum einen die Kardinalität zwischen der Relation "pflanzt_ein" und "Pflanze", da ich hier mit "\[0,1]\" eindeutig bestimmen kann ob eine Pflanze wildwachsend ist oder ob sie von einem Gärtner eingepflanzt wurde.

Zudem hätte ich eine ternäre Beziehung "nimmt_teil" zwischen den Entities "Gärtner", "Bürger" und "Pflegemaßnahme" erstellen können, nur wäre dies in diesem Fall problematisch gewesen, da wir somit nicht mehr eindeutig bestimmen könnten wie viele Gärtner an einer Pflegemaßnahme teilnehmen können, obwohl eindeutig beschrieben wurde, dass eine Pflegemaßnahme von genau einem Gärtner geleitet werden muss. Hier habe ich die Relation in zwei seperate Relationen getrennt, wodurch ich nun die Kardinalität deutlich darstellen kann. 

Außerdem verwende ich die Kardinalität "\[1,\*\]\" hin und wieder, da ich hiermit implizieren kann, dass gewisse Entities mindestens einmal in einer Relation vorkommen müssen, da es sonst zur Verschwendung des Datenbankspeichers kommen würde, wenn wir Elemente abspeichern würden, welche nicht in Verwendung sind. Dies gilt für die Entities "Wohnort", "Pflanzentyp", "Bild", "Standort", "Spezialisierung" und "Pflegeart". 

Auch habe ich eine rekursive Relation bei "Pflegemaßnahme" erstellt. Mit der Kardinalität "\[0,\*\]\" kann ich aussagen, dass eine Pflegemaßnahme die Voraussetzung für mehrere neue Pflegemaßnahmen sein kann. Hingegen wird mit der Kardinalität "\[0,1]\" klar, dass eine Pflegemaßnahme nur explizit eine andere Pflegemaßnahme als unmittelbaren Vorgänger haben darf.

Zusätzlich habe ich der Relation "erstellt" das Attribut "Erfolg" angefügt, da ich somit dem Pflegeprotokoll die Pflegemaßnahmen mit ihren zugehörigen Bewertungen zuteilen kann. Würde dieses Attribut dem Pflegeprotokoll zugeteilt werden, so würden wir Bewertungen nur zu den Pflegeprotokollen abgeben können, aber nicht zu den jeweils eingetragenen Pflegemaßnahmen. Ein ähnliches Problem würde sich zeigen, wenn wir den Gärtner mittels einer neuen Relation "bewertet" direkt mit "Pflegemaßnahme" verbinden würden. In diesem Fall würde der Gärtner eine Pflegemaßnahme nicht im Zusammenhang mit dem Pflegeprotokoll bewerten.
