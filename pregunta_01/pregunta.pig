
/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

fs -rm -f -r output;
data = LOAD 'data.tsv' using PigStorage('\t') AS (letter:CHARARRAY,fecha:CHARARRAY,id:INT);
x = group data BY (letter);
unt = FOREACH x GENERATE group as letter, COUNT($1);
STORE unt  INTO './output' USING PigStorage(',');