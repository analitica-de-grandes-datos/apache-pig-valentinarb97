/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
fs -rm -f -r output;

data = LOAD 'data.tsv' USING PigStorage('\t') as (c1:CHARARRAY,c2:BAG{t: TUPLE(p:CHARARRAY)},c3:MAP[]);
conteo = FOREACH data GENERATE c1 as c1,COUNT(c2) as c2, COUNT(KEYSET(c3)) as c3;
grupos= GROUP conteo BY c1;
ordenado = FOREACH grupos {sort = ORDER conteo BY c1, c2,c3; latest = LIMIT sort 1000; GENERATE FLATTEN(latest);};
STORE ordenado INTO './output'  USING PigStorage(',');