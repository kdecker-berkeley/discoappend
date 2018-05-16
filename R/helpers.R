basic_bio_query_template <-
    "
select
##entity_id##,
last_name,
first_name,
spouse_entity_id,
spouse_last_name,
spouse_first_name,
record_types,
prim_home_city as home_city,
prim_home_state_code as home_state,
prim_home_zipcode5 as home_zip_code,
prim_home_county_desc as home_county,
prim_home_country_desc as home_country,
prim_home_geo_metro_area_desc as home_msa
from cdw.d_entity_mv
"

cap_template <-
  "
select distinct
##entity_id##,
first_value(rating_code_type_desc) over (partition by entity_id order by evaluation_date desc) as capacity_rating,
first_value(evaluation_date) over (partition by entity_id order by evaluation_date desc) as capacity_rating_date
from cdw.d_prospect_evaluation_mv
where
active_ind = 'Y'
and regexp_like(rating_code, '^[0-9]+')
"

inclination_template <-
  "
select distinct
##entity_id##,
first_value(rating_code_type_desc) over (partition by entity_id order by evaluation_date desc) as inclination_rating,
first_value(evaluation_date) over (partition by entity_id order by evaluation_date desc) as inclination_rating_date
from cdw.d_prospect_evaluation_mv
where
active_ind = 'Y'
and rating_code like 'I%'
"

imp_cap_template <-
  "
select distinct
##entity_id##,
first_value(to_number(weight)) over (partition by entity_id order by to_number(weight) desc) as implied_capacity_score,
first_value(dp_interest_desc) over (partition by entity_id order by to_number(weight) desc) as implied_capacity_desc,
dp_date as implied_capacity_date
from
cdw.d_bio_demographic_profile_mv
where
dp_rating_type_code = 'CAP'
"

mgs_template <-
  "
select distinct
##entity_id##,
first_value(to_number(weight)) over (partition by entity_id order by to_number(weight) desc) as major_gift_score,
first_value(dp_interest_desc) over (partition by entity_id order by to_number(weight) desc) as major_gift_score_desc,
dp_date as major_gift_score_date
from
cdw.d_bio_demographic_profile_mv
where
dp_rating_type_code = 'MGS'
"

cnr_model_template <-
  "
select distinct
##entity_id##,
first_value(to_number(weight)) over (partition by entity_id order by to_number(weight) desc) as cnr_score,
first_value(dp_interest_desc) over (partition by entity_id order by to_number(weight) desc) as cnr_score_desc,
dp_date as cnr_score_date
from
cdw.d_bio_demographic_profile_mv
where
dp_rating_type_code = 'CNR'
"

gp_template <-
  "
select distinct
##entity_id##,
first_value(to_number(weight)) over (partition by entity_id order by to_number(weight) desc) as gift_planning_score,
first_value(dp_interest_desc) over (partition by entity_id order by to_number(weight) desc) as gift_planning_score_desc,
dp_date as gift_planning_score_date
from
cdw.d_bio_demographic_profile_mv
where
dp_rating_type_code = 'GPS'
"

eng_model_template <-
  "
select distinct
##entity_id##,
first_value(to_number(weight)) over (partition by entity_id order by to_number(weight) desc) as engineering_score,
first_value(dp_interest_desc) over (partition by entity_id order by to_number(weight) desc) as engineering_score_desc,
dp_date as engineering_score_date
from
cdw.d_bio_demographic_profile_mv
where
dp_rating_type_code = 'ENG'
"

haas_model_template <-
  "
select distinct
##entity_id##,
first_value(to_number(weight)) over (partition by entity_id order by to_number(weight) desc) as haas_score,
first_value(dp_interest_desc) over (partition by entity_id order by to_number(weight) desc) as haas_score_desc,
dp_date as haas_score_date
from
cdw.d_bio_demographic_profile_mv
where
dp_rating_type_code = 'HSB'
"

giving_query_template <-
  "
select
ent.entity_id as ##entity_id##,
nvl(giv.total_raised_amt, 0) as lifetime_giving,
nvl(giv.largest_raised_gf_amt, 0) as largest_gift,
giv.largest_raised_gf_dt as largest_gift_date,
giv.largest_raised_gf_area_desc as largest_gift_area,
nvl(giv.last_raised_gf_amt, 0) as last_gift,
giv.last_raised_gf_dt as last_gift_date,
giv.last_raised_gf_area_desc as last_gift_area,
nvl(giv.avg_raised_gf_amt, 0) as average_gift,
nvl(giv.total_pledge_balance, 0) as outstanding_pledges
from
  cdw.d_entity_mv ent
  inner join cdw.sf_hh_corp_summary_mv giv
    on ent.primary_giving_entity_id = giv.primary_giving_entity_id
"

activities_query_template <-
  "
select
##entity_id##,
student_activities,
sports
from cdw.d_entity_mv
"

degrees_query_template <-
  "
select
##entity_id##,
ungrad_degree_holder_flg as undergrad_degree,
graduate_degree_holder_flg as graduate_degree,
degree_major_year as degrees,
pref_school_code as preferred_school_code,
pref_school_desc as preferred_school,
class_campaign_year,
spouse_ucb_undergraduate as spouse_undergrad_degree,
spouse_ucb_graduate as spouse_graduate_degree,
spouse_degree_major_year as spouse_degrees,
spouse_class_campaign_year
from cdw.d_entity_mv
"

emp_query_template <-
  "
select
entity.##entity_id##,
entity.employer_entity_id,
employ.report_name as employer_name,
entity.emp_job_title as job_title,
entity.position_level_desc as position_level,
entity.fld_of_work_desc as field_of_work,
entity.sic_code_desc as sic_code,
entity.business_city,
entity.business_state_code as business_state,
entity.business_zipcode5 as business_zip
from cdw.d_entity_mv entity
left join cdw.d_entity_mv employ on entity.employer_entity_id = employ.entity_id
"

prospect_query_template <-
  "
select
##entity_id##,
active_major_proposal_flg,
active_annual_proposal_flg,
proposal_summary_by_stage as proposals,
entitymanager as primary_manager,
primary_manager_office_desc as primary_manager_office,
last_3_events,
nvl(event_count, 0) as event_count,
last_contact,
university_sig_flg as university_signataure
from cdw.sf_entity_based_prspct_smry_mv
"

affiliations_query_template <-
  "
select
##entity_id##,
listagg(affil_code_desc, ', ') within group (order by affil_code_desc) as affiliations
from (
select distinct entity_id, affil_code_desc
from cdw.d_bio_affiliation_mv
where affil_status_code = 'C'
)
group by entity_id
"

interests_query_template <-
  "
select
##entity_id##,
listagg(interest_desc, ', ') within group (order by interest_desc) as interests
from (
select distinct entity_id, interest_desc
from cdw.d_bio_interest_mv
where stop_dt is null
)
group by entity_id
"

phil_interests_query_template <-
  "
select
##entity_id##,
listagg(affinity_type_desc, ', ') within group (order by affinity_type_desc) as philanthropic_interests
from (
select distinct entity_id, affinity_type_desc
from cdw.d_philanthropic_interest_mv
where stop_date is null
)
group by entity_id
"

phil_affinities_query_template <-
  "
select
##entity_id##,
listagg(philanthropic_affinities, ', ') within group (order by philanthropic_affinities) as philanthropic_affinities
from (
select distinct entity_id,
(other_affinity_type_desc || ' (' || philanthropic_organization || ')') as philanthropic_affinities
from
cdw.d_oth_phil_affinity_mv
where stop_date is null
)
group by entity_id
"

median_income_query_template <-
"
select
  ent.##entity_id##,
  acs.median_income
from
cdw.d_entity_mv ent
inner join rdata.pd_address_shapes shapes
  on ent.prim_home_address_latitude = shapes.latitude
  and ent.prim_home_address_longitude = shapes.longitude
inner join rdata.acs_pd_wealth_indicators_mv acs
  on shapes.tract_geo_id = acs.geo_id
  and acs.acs_version = '2012-2016'
"


fec_query_template <-
"
select
  ##entity_id##,
  sum(fec_matched_giving) as fec_matched_giving,
  sum(fec_matched_giving + spouse_fec_matched_giving) as hh_fec_matched_giving
from (
  select
    entity_id,
    sum(transaction_amt) as fec_matched_giving,
    sum(0) as spouse_fec_matched_giving
  from rdata.fec
  group by entity_id
  union all
  select
    ent.entity_id,
    sum(0) as fec_matched_giving,
    sum(transaction_amt) as spouse_fec_matched_giving
  from
    cdw.d_entity_mv ent
    inner join rdata.fec on ent.spouse_entity_id = fec.entity_id
  group by ent.entity_id
)
group by entity_id
"

ca_query_template <-
"
select
##entity_id##,
sum(ca_matched_giving) as ca_matched_giving,
sum(ca_matched_giving + spouse_ca_matched_giving) as hh_ca_matched_giving
from (
  select
  entity_id,
  sum(amount) as ca_matched_giving,
  sum(0) as spouse_ca_matched_giving
  from rdata.ca_campaign
  group by entity_id
  union all
  select
  ent.entity_id,
  sum(0) as ca_matched_giving,
  sum(ca.amount) as spouse_ca_matched_giving
  from
  cdw.d_entity_mv ent
  inner join rdata.ca_campaign ca on ent.spouse_entity_id = ca.entity_id
  group by ent.entity_id)
group by entity_id
"

sec_query_template <-
  "select
distinct dict.##entity_id##,
1 as has_sec,
max(hdr.is_director) as is_director,
max(hdr.is_officer) as is_officer,
max(hdr.is_ten_percenter) as is_ten_percenter
from rdata.sec_cik_dict dict
left join rdata.sec_hdr hdr
on dict.cik = hdr.cik
group by dict.entity_id"

sec_hh_template <-
  "select
##entity_id##,
greatest(has_sec, spouse_has_sec) as hh_has_sec,
greatest(is_director, spouse_is_director) as hh_is_director,
greatest(is_officer, spouse_is_officer) as hh_is_officer,
greatest(is_ten_percenter, spouse_is_ten_percenter) as hh_is_ten_percenter
from (
select
entity_id,
max(has_sec) as has_sec,
max(0) as spouse_has_sec,
max(is_director) as is_director,
max(0) as spouse_is_director,
max(is_officer) as is_officer,
max(0) as spouse_is_officer,
max(is_ten_percenter) as is_ten_percenter,
max(0) as spouse_is_ten_percenter
from (select
distinct dict.entity_id,
1 as has_sec,
max(hdr.is_director) as is_director,
max(hdr.is_officer) as is_officer,
max(hdr.is_ten_percenter) as is_ten_percenter
from rdata.sec_cik_dict dict
left join rdata.sec_hdr hdr
on dict.cik = hdr.cik
group by dict.entity_id)
group by entity_id
union all
select
ent.entity_id,
max(0) as has_sec,
max(has_sec) as spouse_has_sec,
max(0) as is_director,
max(is_director) as spouse_is_director,
max(0) as is_officer,
max(is_officer) as spouse_is_officer,
max(0) as is_ten_percenter,
max(is_ten_percenter) as spouse_is_ten_percenter
from
cdw.d_entity_mv ent
inner join ((select
distinct dict.entity_id,
1 as has_sec,
max(hdr.is_director) as is_director,
max(hdr.is_officer) as is_officer,
max(hdr.is_ten_percenter) as is_ten_percenter
from rdata.sec_cik_dict dict
left join rdata.sec_hdr hdr
on dict.cik = hdr.cik
group by dict.entity_id) sec) on ent.spouse_entity_id = sec.entity_id
group by ent.entity_id)"

cik_link_template <-
  "select
distinct ##entity_id##,
concat('https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=', cik) as sec_link
from rdata.sec_cik_dict"

hh_cik_link_template <-
  "select entity_id,
concat(sec_link, spouse_sec_link) as hh_sec_links
from (
  select
  ##entity_id##,
        concat('https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=', cik) as sec_link,
        NULL as spouse_sec_link
        from rdata.sec_cik_dict
        union all
        select
        ent.entity_id,
        NULL as sec_link,
        concat('https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=', cik) as spouse_sec_link
        from
        cdw.d_entity_mv ent
        inner join rdata.sec_cik_dict sec on ent.spouse_entity_id = sec.entity_id
  )"
