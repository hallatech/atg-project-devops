


--  @version $Id: //product/DAS/version/11.3/templates/DAS/sql/usage_tracking_ddl.xml#2 $$Change: 1393648 $
-- This file contains create table statements, which will configureyour database for usage tracking

create table das_usage_metric (
	usage_metric_id	number(19)	not null,
	server_identifier	varchar2(100)	not null,
	usage_date	timestamp	not null,
	usage_hour_of_day	number(3)	not null,
	usage_value	number(10)	default 0 not null
,constraint das_usage_metric_p primary key (usage_metric_id));




