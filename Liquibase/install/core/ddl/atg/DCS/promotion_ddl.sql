


--  @version $Id: //product/DCS/version/11.3/templates/DCS/sql/promotion_ddl.xml#1 $$Change: 1385662 $
-- Add the DCS_PRM_FOLDER table, promotionFolder

create table dcs_prm_folder (
	folder_id	varchar2(40)	not null,
	name	varchar2(254)	not null,
	parent_folder	varchar2(40)	null
,constraint dcs_prm_folder_p primary key (folder_id)
,constraint dcs_prm_prntfol_f foreign key (parent_folder) references dcs_prm_folder (folder_id));

create index prm_prntfol_idx on dcs_prm_folder (parent_folder);

create table dcs_stacking_rule (
	stacking_rule_id	varchar2(40)	not null,
	display_name	varchar2(254)	null,
	order_limits	number(10)	null,
	last_modified	timestamp	null
,constraint dcs_sr_p primary key (stacking_rule_id));


create table dcs_excl_stacking_rules (
	stacking_rule_id	varchar2(40)	not null,
	excl_stacking_rule_id	varchar2(40)	not null
,constraint dcs_excl_sr1_d_f foreign key (stacking_rule_id) references dcs_stacking_rule (stacking_rule_id)
,constraint dcs_excl_sr2_d_f foreign key (excl_stacking_rule_id) references dcs_stacking_rule (stacking_rule_id));

create index dcs_excl_sr1_x on dcs_excl_stacking_rules (stacking_rule_id);
create index dcs_excl_sr2_x on dcs_excl_stacking_rules (excl_stacking_rule_id);

create table dcs_promotion (
	promotion_id	varchar2(40)	not null,
	version	integer	not null,
	creation_date	timestamp	null,
	start_date	timestamp	null,
	end_date	timestamp	null,
	display_name	varchar2(254)	null,
	description	varchar2(254)	null,
	promotion_type	integer	null,
	enabled	number(1,0)	null,
	begin_usable	timestamp	null,
	end_usable	timestamp	null,
	priority	integer	null,
	evaluation_limit	number(10)	null,
	global	number(1,0)	null,
	anon_profile	number(1,0)	null,
	allow_multiple	number(1,0)	null,
	uses	integer	null,
	rel_expiration	number(1,0)	null,
	time_until_expire	integer	null,
	template	varchar2(254)	null,
	ui_access_lvl	integer	null,
	parent_folder	varchar2(40)	null,
	last_modified	timestamp	null,
	pmdl_version	integer	null,
	eval_target_items_first	number(1)	null,
	qualifier	varchar2(254)	null,
	stacking_rule	varchar2(40)	null,
	fil_Qual_Discounted_By_Any	number(1)	null,
	fil_Qual_Discounted_By_Current	number(1)	null,
	fil_Qual_Acted_As_Qual	number(1)	null,
	fil_Qual_On_Sale	number(1)	null,
	fil_Qual_Zero_Prices	number(1)	null,
	fil_Qual_Neg_Prices	number(1)	null,
	fil_Tar_Acted_As_Qual	number(1)	null,
	fil_Tar_Discounted_By_Current	number(1)	null,
	fil_Tar_Discounted_By_Any	number(1)	null,
	fil_Target_On_Sale	number(1)	null,
	fil_Tar_Zero_Prices	number(1)	null,
	fil_Tar_Neg_Prices	number(1)	null,
	fil_Tar_Price_LTOET_Prm_Price	number(1)	null
,constraint dcs_promotion_p primary key (promotion_id)
,constraint dcs_prm_fol_f foreign key (parent_folder) references dcs_prm_folder (folder_id)
,constraint dcs_sta_rule_f foreign key (stacking_rule) references dcs_stacking_rule (stacking_rule_id)
,constraint dcs_promotion1_c check (enabled in (0,1))
,constraint dcs_promotion2_c check (global in (0,1))
,constraint dcs_promotion3_c check (anon_profile in (0,1))
,constraint dcs_promotion4_c check (allow_multiple in (0,1))
,constraint dcs_promotion5_c check (rel_expiration in (0,1))
,constraint dcs_promotion6_c check (eval_target_items_first in (0,1)));

create index promo_folder_idx on dcs_promotion (parent_folder);
create index stacking_rule_idx on dcs_promotion (stacking_rule);
create index prmo_bgin_use_idx on dcs_promotion (begin_usable);
create index prmo_end_dte_idx on dcs_promotion (end_date);
create index prmo_end_use_idx on dcs_promotion (end_usable);
create index prmo_strt_dte_idx on dcs_promotion (start_date);

create table dcs_promo_media (
	promotion_id	varchar2(40)	not null,
	tag	varchar2(42)	not null,
	media_id	varchar2(40)	not null
,constraint dcs_promo_media_p primary key (promotion_id,tag)
,constraint dcs_prommdmed_d_f foreign key (media_id) references dcs_media (media_id)
,constraint dcs_prompromtn_d_f foreign key (promotion_id) references dcs_promotion (promotion_id));

create index promo_mdia_mid_idx on dcs_promo_media (media_id);
create index promo_mdia_pid_idx on dcs_promo_media (promotion_id);

create table dcs_promo_payment (
	promotion_id	varchar2(40)	not null,
	payment_type	varchar2(40)	not null);


create table dcs_discount_promo (
	promotion_id	varchar2(40)	not null,
	calculator	varchar2(254)	null,
	adjuster	number(19,7)	null,
	pmdl_rule	clob	not null,
	one_use	number(1,0)	null
,constraint dcs_discount_pro_p primary key (promotion_id)
,constraint dcs_discpromtn_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_discount_pro_c check (one_use in (0, 1)));


create table dcs_promo_upsell (
	promotion_id	varchar2(40)	not null,
	upsell	number(1,0)	null
,constraint dcs_promo_upsell_p primary key (promotion_id)
,constraint dcs_proupsell_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_promo_upsell_c check (upsell in (0, 1)));


create table dcs_upsell_action (
	action_id	varchar2(40)	not null,
	version	number(10)	not null,
	name	varchar2(40)	not null,
	upsell_prd_grp	clob	null
,constraint dcs_upsell_actn_p primary key (action_id));


create table dcs_close_qualif (
	close_qualif_id	varchar2(40)	not null,
	version	number(10)	not null,
	name	varchar2(254)	not null,
	priority	number(10)	null,
	qualifier	clob	null,
	upsell_media	varchar2(40)	null,
	upsell_action	varchar2(40)	null
,constraint dcs_close_qualif_p primary key (close_qualif_id)
,constraint dcs_cq_media_d_f foreign key (upsell_media) references dcs_media (media_id)
,constraint dcs_cq_action_d_f foreign key (upsell_action) references dcs_upsell_action (action_id));

create index dcs_closequalif2_x on dcs_close_qualif (upsell_media);
create index dcs_closequalif1_x on dcs_close_qualif (upsell_action);

create table dcs_prm_cls_qlf (
	promotion_id	varchar2(40)	not null,
	closeness_qualif	varchar2(40)	not null
,constraint dcs_promo_cq_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_prmclsqlf_d_f foreign key (closeness_qualif) references dcs_close_qualif (close_qualif_id));

create index dcs_prm_cls_qlf2_x on dcs_prm_cls_qlf (promotion_id);
create index dcs_prm_cls_qlf1_x on dcs_prm_cls_qlf (closeness_qualif);

create table dcs_prm_sites (
	promotion_id	varchar2(40)	not null,
	site_id	varchar2(40)	not null
,constraint dcs_prm_sites1_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_prm_sites2_d_f foreign key (site_id) references site_configuration (id));

create index dcs_prm_sites1_x on dcs_prm_sites (promotion_id);
create index dcs_prm_sites2_x on dcs_prm_sites (site_id);

create table dcs_prm_site_grps (
	promotion_id	varchar2(40)	not null,
	site_group_id	varchar2(40)	not null
,constraint dcs_prm_sgrps1_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_prm_sgrps2_d_f foreign key (site_group_id) references site_group (id));

create index dcs_prm_sgrps1_x on dcs_prm_site_grps (promotion_id);
create index dcs_prm_sgrps2_x on dcs_prm_site_grps (site_group_id);

create table dcs_prm_tpl_vals (
	promotion_id	varchar2(40)	not null,
	placeholder	varchar2(40)	not null,
	placeholderValue	clob	null
,constraint dcs_prm_tpl_vals_p primary key (promotion_id,placeholder)
,constraint dcs_prmtplvals_d_f foreign key (promotion_id) references dcs_promotion (promotion_id));


create table dcs_prm_cls_vals (
	close_qualif_id	varchar2(40)	not null,
	placeholder	varchar2(40)	not null,
	placeholderValue	clob	null
,constraint dcs_prm_cls_vals_p primary key (close_qualif_id,placeholder)
,constraint dcs_prmclsvals_d_f foreign key (close_qualif_id) references dcs_close_qualif (close_qualif_id));


create table dcs_upsell_prods (
	action_id	varchar2(40)	not null,
	product_id	varchar2(40)	not null,
	sequence_num	number(10)	not null
,constraint dcs_upsell_prods_p primary key (action_id,product_id)
,constraint dcs_ups_prod_d_f foreign key (product_id) references dcs_product (product_id));

create index dcs_upsellprods1_x on dcs_upsell_prods (product_id);

create table dcs_excl_promotions (
	promotion_id	varchar2(40)	not null,
	excl_promotion_id	varchar2(40)	not null
,constraint dcs_excl_pr1_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_excl_pr2_d_f foreign key (excl_promotion_id) references dcs_promotion (promotion_id));

create index dcs_excl_pr1_x on dcs_excl_promotions (promotion_id);
create index dcs_excl_pr2_x on dcs_excl_promotions (excl_promotion_id);

create table dcs_incl_promotions (
	promotion_id	varchar2(40)	not null,
	incl_promotion_id	varchar2(40)	not null
,constraint dcs_incl_pr1_d_f foreign key (promotion_id) references dcs_promotion (promotion_id)
,constraint dcs_incl_pr2_d_f foreign key (incl_promotion_id) references dcs_promotion (promotion_id));

create index dcs_incl_pr1_x on dcs_incl_promotions (promotion_id);
create index dcs_incl_pr2_x on dcs_incl_promotions (incl_promotion_id);



