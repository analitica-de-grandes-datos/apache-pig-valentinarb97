/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       REGEX_EXTRACT(birthday, '....-..-..', 2) 
   FROM 
       u;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
fs -rm -f -r output;

u = LOAD 'data.csv' USING PigStorage(',') 
    AS ( 
            id: int, 
            firstname:chararray, 
            surname:chararray, 
            birthday:chararray, 
            color:chararray, 
            quantity:INT); 

sub_conjunto = FOREACH u GENERATE REGEX_EXTRACT(birthday, '(.*)-(.*)-(.*)', 2); 
STORE sub_conjunto INTO 'output';
