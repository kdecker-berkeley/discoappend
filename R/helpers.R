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
from
cdw.d_bio_affiliation_mv
where affil_status_code = 'C'
group by entity_id
"

interests_query_template <-
  "
select
##entity_id##,
listagg(interest_desc, ', ') within group (order by interest_desc) as interests
from
cdw.d_bio_interest_mv
where stop_dt is null
group by entity_id
"

phil_interests_query_template <-
  "
select
##entity_id##,
listagg(affinity_type_desc, ', ') within group (order by affinity_type_desc) as philanthropic_interests
from
cdw.d_philanthropic_interest_mv
where stop_date is null
group by entity_id
"

phil_affinities_query_template <-
  "
select
##entity_id##,
listagg(other_affinity_type_desc, ', ') within group (order by other_affinity_type_desc) as philanthropic_affinities,
listagg(philanthropic_organization, ', ') within group (order by philanthropic_organization) as philanthropic_organizations
from
cdw.d_oth_phil_affinity_mv
where stop_date is null
group by entity_id
"

median_income_query_template <-
"
select
  ent.entity_id as ##entity_id##,
  acs.estimate as acs_median_income
from
  (select
    entity_id,
    sdo_geometry(2001, 4269,
                 sdo_point_type(prim_home_address_longitude,
                                prim_home_address_latitude, null),
                 null, null) as home_location
  from
    cdw.d_entity_mv
  where
    prim_home_address_latitude is not null
    and prim_home_address_longitude is not null
    and prim_home_address_latitude <> 0
    and prim_home_address_longitude <> 0) ent
inner join rdata.geo_tract on sdo_contains(geo_tract.geometry, ent.home_location) = 'TRUE'
inner join rdata.acs
  on acs.acs_version = '2012-2016'
  and variable_id = 'b19013001'
  and geo_tract.geo_id = acs.geo_id
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
