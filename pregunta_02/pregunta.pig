/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/
fs -rm -f -r output;
data= LOAD 'data.tsv'  using PigStorage('\t') AS (letra:CHARARRAY,fecha:CHARARRAY,valor:INT);
grupos= order data  BY letra ASC, valor ASC;
STORE grupos INTO './output'  USING PigStorage(',');
fs -get output ;
