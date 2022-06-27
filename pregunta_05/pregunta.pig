/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
fs -rm -f -r output;
data= LOAD 'data.tsv' USING PigStorage('\t') as (c1:CHARARRAY,c2:BAG{t: TUPLE(p:CHARARRAY)},c3:CHARARRAY);
letters = FOREACH data GENERATE FLATTEN(c2) AS letter;
grupo = GROUP letters BY letter;
conteo = FOREACH grupo GENERATE group, COUNT(letters);
STORE conteo INTO './output'  USING PigStorage(',');
