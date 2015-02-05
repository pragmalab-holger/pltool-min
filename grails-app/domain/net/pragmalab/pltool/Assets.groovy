package net.pragmalab.pltool

class Assets {

    static hasMany = [assets_details: Assets_Details, assets_relations: Assets_Relations]

    static constraints = {
        acc_int_in_cf_till_date nullable: true
        cancellation_date nullable: true
        current_status_valid_from_date nullable: true
        default_date nullable: true
        original_contract_date nullable: true
        original_contract_maturity nullable: true
        takeover_date nullable: true
    }

    Date 	acc_int_in_cf_till_date
    Long 	bucket_id
    Long 	campaign_id
    Date 	cancellation_date
    String	contract_country
    String	contract_currency
    Long 	contract_currency_id
    Long 	contact_id
    Float 	current_collateral_value
    Float 	current_costs
    Long 	current_discount
    Float 	current_fair_value
    Float 	current_interest
    Float 	current_interest_rate
    String	current_interest_rate_formula
    Float 	current_outstanding_amount
    Float 	current_overall_exposure_amount
    Float 	current_principal
    Float 	current_recovery
    String	current_servicer
    String	current_status
    Long 	current_status_id
    Date 	current_status_valid_from_date
    Float 	default_collateral_value
    Date 	default_date
    Float 	default_outstanding_amount
    Float 	default_overall_exposure_amount
    Long 	division_id
    String	external_id
    Long 	asset_id
    Long 	file_status_id
    String	files_ext_id
    Long 	files_id
    Float 	insolvency_est_quota
    String	insolvency_file
    Float 	original_contract_amount
    Date 	original_contract_date
    Date 	original_contract_maturity
    Float 	original_interest_rate
    String	original_interest_rate_formula
    Long 	portfolio_id
    Long 	product_id
    String	product_type
    Float 	purchase_price
    String	reputational_risk
    Long 	residential_situation_id
    Float 	takeover_collateral_value
    Date 	takeover_date
    Float 	takeover_outstanding_amount
    Float 	takeover_overall_exposure_amount
    Float 	third_party_share
    Long 	original_contract_partner
    Long 	facility_id
    String	group_domain

}
