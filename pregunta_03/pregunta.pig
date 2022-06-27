/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
fs -rm -f -r output;
data= LOAD 'data.tsv' using PigStorage('\t') AS (letra:CHARARRAY,fecha:CHARARRAY,valor:INT);
ordenado = ORDER data BY valor ASC;
select = FOREACH ordenado GENERATE valor;
primeros = LIMIT select 5; 
STORE primeros INTO './output'  USING PigStorage(',');
fs -get output;