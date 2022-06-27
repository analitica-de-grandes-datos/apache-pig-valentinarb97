/*
Pregunta
===========================================================================

El archivo `data.csv` tiene la siguiente estructura:

  driverId       INT
  truckId        INT
  eventTime      STRING
  eventType      STRING
  longitude      DOUBLE
  latitude       DOUBLE
  eventKey       STRING
  correlationId  STRING
  driverName     STRING
  routeId        BIGINT
  routeName      STRING
  eventDate      STRING

Escriba un script en Pig que carge los datos y obtenga los primeros 10 
registros del archivo para las primeras tres columnas, y luego, ordenados 
por driverId, truckId, y eventTime. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

         >>> Escriba su respuesta a partir de este punto <<<
*/
fs -rm -f -r output;
data = LOAD 'data.csv' USING PigStorage(',') as (driverId:INT,truckId:INT,eventTime:CHARARRAY,eventType:CHARARRAY,
longitude:DOUBLE,latitude:DOUBLE,eventKey:CHARARRAY,correlationId:CHARARRAY,driverName:CHARARRAY,routeId:CHARARRAY,routeName:CHARARRAY,eventDate:CHARARRAY);
columnas = FOREACH data GENERATE driverId,truckId,eventTime;
filas= LIMIT columnas 10;
grupos= GROUP filas BY driverId;
ordenado = FOREACH grupos {sort = ORDER filas BY driverId, truckId,eventTime; latest = LIMIT sort 1000; GENERATE FLATTEN(latest);};
STORE ordenado INTO './output'  USING PigStorage(',');