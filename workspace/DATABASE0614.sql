create database db01; -- 全部語法結束後才加上;
CREATE SCHEMA `db02`;
use db02; -- 切換預設
use db01; -- 切換預設
show charset;
show collation like '%utf8%'; -- 顯示僅關utf8的編碼
ALTER DATABASE db02 CHARACTER SET big5 COLLATE big5_chinese_ci; -- 修改編碼
select @@character_set_database, @@collation_database; -- 查詢當前「預設（粗體）」database編碼
drop database db02;