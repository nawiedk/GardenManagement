# Blatt 2

Überführung des ER-Modells in ein Relationenmodell

## Kritische Entscheidungen

### Ohne Verschmelzung

- Die wichtigste Entscheidung die ich hier getroffen habe, ist das erstellen von künstlichen Primärschlüsseln. Das Erstellen dieser ist insofern relevant um Entitäten mittels ihrer Primärschlüssel, als Fremdschlüssel, in Relationen miteinander zu verknüpfen zu können. Auch hat es den Vorteil, dass ich mir mehrstellige Primärschlüssel ersparen kann. So kann ich anstelle eines langen Aufrufs über Stadt, PLZ, Strasse und Hausnummer einfach Wohnort.WohnortID aufrufen.
- Außerdem habe ich überflüßige Elemente wie in der Korrektur erwähnt entfernt und andere Fehler, welche die Entities, Relationen und Attribute betroffen haben, behoben.
- Bei der Entität Pflegemassnahme habe ich für die Relation setztVoraus habe ich den Namen 1 und 2 angefügt, um zu verdeutlichen, dass es sich hierbei um zwei verschiedene Primärschlüssel handeln muss.
### Nach der Verschmelzung

- Bei dem Verschmelzen habe ich alle 1:1 und 1:n Beziehungen in Betracht genommen. In meinem ER-Modell gibt es jedoch nur 1:n Beziehungen. Bei diesen habe ich die Primärschlüssel der n-Seite als Fremdschlüssel in die 1-Seite eingefügt. Durch das Verschmelzen werden die Relationships zwischen den beiden Entitäten somit überflüßig. Übrig bleiben deshalb nur noch die Entitäten und die Relationships zwischen Entitäten die nicht verschmolzen werden konnten.
