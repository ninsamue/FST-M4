-- Load the CSV file
dialogTable = LOAD 'hdfs:///user/root/episodeIV_dialouges.txt' USING PigStorage('\t') AS (Character:chararray,Line:chararray);
-- Group data using the country column
GroupByCharacter = GROUP dialogTable BY Character;
-- Generate result format
CountByLines = FOREACH GroupByCharacter GENERATE CONCAT((chararray)$0, CONCAT(':', (chararray)COUNT($1)));
-- Save result in HDFS folder
STORE CountByLines INTO 'CharacterLinesOutput' USING PigStorage('\t');