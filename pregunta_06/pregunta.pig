/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
fs -rm -f -r output;
data= LOAD 'data.tsv' USING PigStorage('\t') as (c1:CHARARRAY,c2:BAG{t: TUPLE(p:CHARARRAY)},c3:MAP[]);
letters = FOREACH data GENERATE c3 AS letter;
keys = FOREACH letters GENERATE FLATTEN(KEYSET($0)) as key;
grupo = GROUP keys BY key;
conteo = FOREACH grupo GENERATE group, COUNT(keys);
STORE conteo INTO './output'  USING PigStorage(',');