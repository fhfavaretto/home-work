/* AJUSTA A CLASSE DE VALOR NOS LAN�AMENTOS CONTABEIS */


/* 11001 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100033','11103010100323','11103010100027') OR CT2_CREDIT IN ('11102010100033','11103010100323','11103010100027')) AND CT2_FILIAL = '11001' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010010001', CT2_CLVLCR = '010010001' WHERE (CT2_DEBITO IN ('11102010100033','11103010100323','11103010100027') OR CT2_CREDIT IN ('11102010100033','11103010100323','11103010100027')) AND CT2_FILIAL = '11001' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11001 - 002*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100046','11103010100333') OR CT2_CREDIT IN ('11102010100046','11103010100333')) AND CT2_FILIAL = '11001' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010010002', CT2_CLVLCR = '010010002' WHERE (CT2_DEBITO IN ('11102010100046','11103010100333') OR CT2_CREDIT IN ('11102010100046','11103010100333')) AND CT2_FILIAL = '11001' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11015 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100026','11103010100050','11103010100338') OR CT2_CREDIT IN ('11102010100026','11103010100050','11103010100338')) AND CT2_FILIAL = '11015' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010150001', CT2_CLVLCR = '010150001' WHERE (CT2_DEBITO IN ('11102010100026','11103010100050','11103010100338') OR CT2_CREDIT IN ('11102010100026','11103010100050','11103010100338')) AND CT2_FILIAL = '11015' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11051 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100130','11103010100344') OR CT2_CREDIT IN ('11102010100130','11103010100344')) AND CT2_FILIAL = '11051' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010510001', CT2_CLVLCR = '010510001' WHERE (CT2_DEBITO IN ('11102010100130','11103010100344') OR CT2_CREDIT IN ('11102010100130','11103010100344')) AND CT2_FILIAL = '11051' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11051 - 002*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100088','11103010100345') OR CT2_CREDIT IN ('11102010100088','11103010100345')) AND CT2_FILIAL = '11051' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010510002', CT2_CLVLCR = '010510002' WHERE (CT2_DEBITO IN ('11102010100088','11103010100345') OR CT2_CREDIT IN ('11102010100088','11103010100345')) AND CT2_FILIAL = '11051' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11004 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100109','11103010100123') OR CT2_CREDIT IN ('11102010100109','11103010100123')) AND CT2_FILIAL = '11004' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010040001', CT2_CLVLCR = '010040001' WHERE (CT2_DEBITO IN ('11102010100109','11103010100123') OR CT2_CREDIT IN ('11102010100109','11103010100123')) AND CT2_FILIAL = '11004' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11008 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100097','11103010100100') OR CT2_CREDIT IN ('11102010100097','11103010100100')) AND CT2_FILIAL = '11008' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010080001', CT2_CLVLCR = '010080001' WHERE (CT2_DEBITO IN ('11102010100097','11103010100100') OR CT2_CREDIT IN ('11102010100097','11103010100100')) AND CT2_FILIAL = '11008' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11016 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100096','11103010100099') OR CT2_CREDIT IN ('11102010100096','11103010100099')) AND CT2_FILIAL = '11016' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010160001', CT2_CLVLCR = '010160001' WHERE (CT2_DEBITO IN ('11102010100096','11103010100099') OR CT2_CREDIT IN ('11102010100096','11103010100099')) AND CT2_FILIAL = '11016' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11020 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100098','11103010100101') OR CT2_CREDIT IN ('11102010100098','11103010100101')) AND CT2_FILIAL = '11020' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010200001', CT2_CLVLCR = '010200001' WHERE (CT2_DEBITO IN ('11102010100098','11103010100101') OR CT2_CREDIT IN ('11102010100098','11103010100101')) AND CT2_FILIAL = '11020' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11022 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100099','11103010100273') OR CT2_CREDIT IN ('11102010100099','11103010100273')) AND CT2_FILIAL = '11022' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010220001', CT2_CLVLCR = '010220001' WHERE (CT2_DEBITO IN ('11102010100099','11103010100273') OR CT2_CREDIT IN ('11102010100099','11103010100273')) AND CT2_FILIAL = '11022' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11025 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100061','11103010100039') OR CT2_CREDIT IN ('11102010100061','11103010100039')) AND CT2_FILIAL = '11025' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010250001', CT2_CLVLCR = '010250001' WHERE (CT2_DEBITO IN ('11102010100061','11103010100039') OR CT2_CREDIT IN ('11102010100061','11103010100039')) AND CT2_FILIAL = '11025' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11039 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100146','11103010100277') OR CT2_CREDIT IN ('11102010100146','11103010100277')) AND CT2_FILIAL = '11039' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010390001', CT2_CLVLCR = '010390001' WHERE (CT2_DEBITO IN ('11102010100146','11103010100277') OR CT2_CREDIT IN ('11102010100146','11103010100277')) AND CT2_FILIAL = '11039' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11040 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100100','11103010100279') OR CT2_CREDIT IN ('11102010100100','11103010100279')) AND CT2_FILIAL = '11040' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010400001', CT2_CLVLCR = '010400001' WHERE (CT2_DEBITO IN ('11102010100100','11103010100279') OR CT2_CREDIT IN ('11102010100100','11103010100279')) AND CT2_FILIAL = '11040' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11041 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100070','11103010100065') OR CT2_CREDIT IN ('11102010100070','11103010100065')) AND CT2_FILIAL = '11041' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010410001', CT2_CLVLCR = '010410001' WHERE (CT2_DEBITO IN ('11102010100070','11103010100065') OR CT2_CREDIT IN ('11102010100070','11103010100065')) AND CT2_FILIAL = '11041' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11002 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100107','11103010100152','11103010100318') OR CT2_CREDIT IN ('11102010100107','11103010100152','11103010100318')) AND CT2_FILIAL = '11002' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010020001', CT2_CLVLCR = '010020001' WHERE (CT2_DEBITO IN ('11102010100107','11103010100152','11103010100318') OR CT2_CREDIT IN ('11102010100107','11103010100152','11103010100318')) AND CT2_FILIAL = '11002' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11002 - 002*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100105','11103010100150','11103010100317') OR CT2_CREDIT IN ('11102010100105','11103010100150','11103010100317')) AND CT2_FILIAL = '11002' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010020002', CT2_CLVLCR = '010020002' WHERE (CT2_DEBITO IN ('11102010100105','11103010100150','11103010100317') OR CT2_CREDIT IN ('11102010100105','11103010100150','11103010100317')) AND CT2_FILIAL = '11002' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11012 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100190','11103010100347') OR CT2_CREDIT IN ('11102010100190','11103010100347')) AND CT2_FILIAL = '11012' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010120001', CT2_CLVLCR = '010120001' WHERE (CT2_DEBITO IN ('11102010100190','11103010100347') OR CT2_CREDIT IN ('11102010100190','11103010100347')) AND CT2_FILIAL = '11012' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11034 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100063','11103010100034','11103010100346') OR CT2_CREDIT IN ('11102010100063','11103010100034','11103010100346')) AND CT2_FILIAL = '11034' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010340001', CT2_CLVLCR = '010340001' WHERE (CT2_DEBITO IN ('11102010100063','11103010100034','11103010100346') OR CT2_CREDIT IN ('11102010100063','11103010100034','11103010100346')) AND CT2_FILIAL = '11034' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11034 - 002*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100189','11103010100320') OR CT2_CREDIT IN ('11102010100189','11103010100320')) AND CT2_FILIAL = '11034' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010340002', CT2_CLVLCR = '010340002' WHERE (CT2_DEBITO IN ('11102010100189','11103010100320') OR CT2_CREDIT IN ('11102010100189','11103010100320')) AND CT2_FILIAL = '11034' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11021 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100112','11103010100013','11103010100408') OR CT2_CREDIT IN ('11102010100112','11103010100013','11103010100408')) AND CT2_FILIAL = '11021' AND CT2_DATA BETWEEN '20171001'AND'20171031';
UPDATE CT2010 SET CT2_CLVLDB = '010210001', CT2_CLVLCR = '010210001' WHERE (CT2_DEBITO IN ('11102010100112','11103010100013','11103010100408') OR CT2_CREDIT IN ('11102010100112','11103010100013','11103010100408')) AND CT2_FILIAL = '11021' AND CT2_DATA BETWEEN '20171001'AND'20171031';

/* 11019 - 001*/
SELECT * FROM CT2010 WHERE (CT2_DEBITO IN ('11102010100011','11103010100057','11103010100348') OR CT2_CREDIT IN ('11102010100011','11103010100057','11103010100348')) AND CT2_FILIAL = '11019' AND CT2_DATA BETWEEN '20170401'AND'20171231';
UPDATE CT2010 SET CT2_CLVLDB = '010190001', CT2_CLVLCR = '010190001' WHERE (CT2_DEBITO IN ('11102010100011','11103010100057','11103010100348') OR CT2_CREDIT IN ('11102010100011','11103010100057','11103010100348')) AND CT2_FILIAL = '11019' AND CT2_DATA BETWEEN '20170401'AND'20171231';




