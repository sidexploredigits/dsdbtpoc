
{{ config(
 materialized='table',
 post_hook="
 INSERT INTO
            {{source('DM_MPSCR',var('xg_pm_tgttbl'))}}
        SELECT
             *
        FROM
            {{ ref('mov_mdm_credit_risk_rating') }} 
 "
)}}

SELECT 1 AS dummy_column

