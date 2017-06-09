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
select
##entity_id##,
capacity_rating_code,
capacity_rating_desc,
inclination_rating_desc,
builder_of_berkeley_flg as builder_of_berkeley,
from cdw.d_entity_mv
"

imp_cap_template <-
  "
select distinct
##entity_id##,
first_value(to_number(weight)) over (partition by entity_id order by to_number(weight) desc) as implied_caacity_score,
first_value(dp_interest_desc) over (partition by entity_id order by to_number(weight) desc) as implied_capacity_desc
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
first_value(dp_interest_desc) over (partition by entity_id order by to_number(weight) desc) as major_gift_desc
from
cdw.d_bio_demographic_profile_mv
where
dp_rating_type_code = 'MGS'
"

giving_query_template <-
  "
select
##entity_id##,
total_raised_amt as lifetime_giving,
largest_raised_gf_amt as largest_gift,
largest_raised_gf_dt as largest_gift_date,
largest_raised_gf_area_desc as largest_gift_area,
last_raised_gf_amt as last_gift,
last_raised_gf_dt as last_gift_date,
last_raised_gf_area_desc as last_gift_area,
avg_raised_gf_amt as average_gift,
total_pledge_balance as outstanding_pledges
from cdw.sf_entity_summary_mv
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
##entity_id##,
emp_job_title as job_title,
position_level_desc as position_level,
fld_of_work_desc as field_of_work,
sic_code_desc as sic_code,
business_city,
business_state_code as business_state,
business_zipcode5 as business_zip
from cdw.d_entity_mv
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
event_count,
last_contact,
university_sig_flg as university_signataure
from cdw.sf_entity_based_prspct_smry_mv
"

modify <- discoveryengine:::modify

ReName <- function(strings) {
    s <- tolower(strings)
    gsub("(_|^)(.)", "\\U\\2\\E", s, perl = TRUE)
}
