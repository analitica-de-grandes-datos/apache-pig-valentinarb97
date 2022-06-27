/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

fs -rm -f -r output;

data= LOAD 'data.tsv' USING PigStorage('\t') AS (c1:CHARARRAY,c2:BAG{t: TUPLE(p:CHARARRAY)},c3:MAP[]);
keys = FOREACH data GENERATE FLATTEN(c2) AS letter, FLATTEN(KEYSET(c3)) as key;
grupo = GROUP keys BY (letter,key);
conteo = FOREACH grupo GENERATE group, COUNT(keys);
STORE conteo INTO './output'  USING PigStorage('\t');