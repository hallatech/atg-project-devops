


--  @version $Id: //product/DCS/version/11.3/templates/DCS/sql/priceLists_ddl.xml#2 $$Change: 1386526 $

create table dcs_price_list (
	price_list_id	varchar2(40)	not null,
	version	integer	not null,
	display_name	varchar2(254)	null,
	description	varchar2(254)	null,
	creation_date	timestamp	null,
	last_mod_date	timestamp	null,
	start_date	timestamp	null,
	end_date	timestamp	null,
	locale	number(10)	null,
	base_price_list	varchar2(40)	null,
	item_acl	varchar2(1024)	null
,constraint dcs_price_list_p primary key (price_list_id)
,constraint dcs_pricbas_prcl_f foreign key (base_price_list) references dcs_price_list (price_list_id));

create index dcs_pricelstbase_i on dcs_price_list (base_price_list);

create table dcs_complex_price (
	complex_price_id	varchar2(40)	not null,
	version	integer	not null
,constraint dcs_complex_pric_p primary key (complex_price_id));


create table dcs_price (
	price_id	varchar2(40)	not null,
	version	integer	not null,
	price_list	varchar2(40)	not null,
	product_id	varchar2(40)	null,
	sku_id	varchar2(40)	null,
	parent_sku_id	varchar2(40)	null,
	pricing_scheme	integer	not null,
	list_price	number(19,7)	null,
	complex_price	varchar2(40)	null,
	start_date	timestamp	null,
	end_date	timestamp	null
,constraint dcs_price_p primary key (price_id)
,constraint dcs_priccomplx_p_f foreign key (complex_price) references dcs_complex_price (complex_price_id)
,constraint dcs_pricpric_lst_f foreign key (price_list) references dcs_price_list (price_list_id));

create index dcs_cmplx_prc_idx on dcs_price (complex_price);
create index dcs_price_idx1 on dcs_price (product_id);
create index dcs_price_idx2 on dcs_price (price_list,sku_id);

create table dcs_price_levels (
	complex_price_id	varchar2(40)	not null,
	price_levels	varchar2(40)	not null,
	sequence_num	integer	not null
,constraint dcs_price_levels_p primary key (complex_price_id,sequence_num)
,constraint dcs_lvlscomplx_p_f foreign key (complex_price_id) references dcs_complex_price (complex_price_id));


create table dcs_price_level (
	price_level_id	varchar2(40)	not null,
	version	integer	not null,
	quantity	integer	not null,
	price	number(19,7)	not null
,constraint dcs_price_level_p primary key (price_level_id));


create table dcs_gen_fol_pl (
	folder_id	varchar2(40)	not null,
	type	integer	not null,
	name	varchar2(40)	not null,
	parent	varchar2(40)	null,
	description	varchar2(254)	null,
	item_acl	varchar2(1024)	null
,constraint dcs_gen_fol_pl_p primary key (folder_id));


create table dcs_child_fol_pl (
	folder_id	varchar2(40)	not null,
	sequence_num	integer	not null,
	child_folder_id	varchar2(40)	not null
,constraint dcs_child_fol_pl_p primary key (folder_id,sequence_num)
,constraint dcs_chilfoldr_d_f foreign key (folder_id) references dcs_gen_fol_pl (folder_id));


create table dcs_plfol_chld (
	plfol_id	varchar2(40)	not null,
	sequence_num	integer	not null,
	price_list_id	varchar2(40)	not null
,constraint dcs_plfol_chld_p primary key (plfol_id,sequence_num)
,constraint dcs_plfoplfol_d_f foreign key (plfol_id) references dcs_gen_fol_pl (folder_id));




