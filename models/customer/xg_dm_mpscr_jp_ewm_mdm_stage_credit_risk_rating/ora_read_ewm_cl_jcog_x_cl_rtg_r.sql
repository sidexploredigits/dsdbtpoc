
{{config(
  materialized='ephemeral'
)}}

WITH ora_read_ewm_cl_jcog_x_cl_rtg_r AS (
SELECT
            	SRC_DL,
            	SUBJ_CL_ID,
            	MSTR_SRC_STM_CD,
            	MSTR_SRC_STM_KEY,
            	VLD_FROM_TMS,
            	VLD_TO_TMS,
            	OBJ_CL_CD,
            	EFF_DT,
            	INR_RTG_MODL_CL_CD,
            	null AS rtg_st_tp_cl_cd,
            	GRP_CL_RLTNP_TP_CL_CD
        FROM
            {{ source('DM_MPSCR', 'EWM_CL_JCOG_X_CL_RTG_R') }}
        WHERE
            SRC_DL='{{var("xg_pm_src_dl")}}'
            AND VLD_FROM_TMS <= PARSE_TIMESTAMP(
                    '%Y%m%d%H%M%S',
                    "{{var('xg_pm_selection_date')}}{{var('xg_pm_business_tms')}}"
                )
            AND PARSE_TIMESTAMP(
                    '%Y%m%d%H%M%S',
                    "{{var('xg_pm_selection_date')}}{{var('xg_pm_business_tms')}}"
                ) < VLD_TO_TMS 
)

SELECT * FROM ora_read_ewm_cl_jcog_x_cl_rtg_r

