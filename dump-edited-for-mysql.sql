
CREATE TABLE account_analytic_account (
    id INT NOT NULL,
    plan_id INT NOT NULL,
    root_plan_id INT,
    company_id INT,
    partner_id INT,
    create_uid INT,
    write_uid INT,
    code VARCHAR(255),
    name json NOT NULL,
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);

CREATE TABLE account_analytic_applicability (
    id INT NOT NULL,
    analytic_plan_id INT,
    company_id INT,
    create_uid INT,
    write_uid INT,
    business_domain VARCHAR(255) NOT NULL,
    applicability VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);




CREATE TABLE account_analytic_distribution_model (
    id INT NOT NULL,
    partner_id INT,
    partner_category_id INT,
    company_id INT,
    create_uid INT,
    write_uid INT,
    analytic_distribution json,
    create_date timestamp ,
    write_date timestamp 
);




CREATE TABLE account_analytic_line (
    id INT NOT NULL,
    product_uom_id INT,
    account_id INT,
    partner_id INT,
    user_id INT,
    company_id INT NOT NULL,
    currency_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(255),
    date date NOT NULL,
    amount numeric NOT NULL,
    create_date timestamp ,
    write_date timestamp ,
    unit_amount double precision
);

CREATE TABLE account_analytic_plan (
    id INT NOT NULL,
    parent_id INT,
    color INT,
    sequence INT,
    create_uid INT,
    write_uid INT,
    parent_path VARCHAR(255),
    complete_name VARCHAR(255),
    name json NOT NULL,
    description text,
    create_date timestamp ,
    write_date timestamp 
);

CREATE TABLE activity_attachment_rel (
    activity_id INT NOT NULL,
    attachment_id INT NOT NULL
);

CREATE TABLE appointment_answer (
    id INT NOT NULL,
    question_id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);


CREATE TABLE appointment_answer_input (
    id INT NOT NULL,
    question_id INT NOT NULL,
    value_answer_id INT,
    appointment_type_id INT NOT NULL,
    calendar_event_id INT NOT NULL,
    partner_id INT,
    create_uid INT,
    write_uid INT,
    value_text_box text,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT appointment_answer_input_value_check CHECK (((value_answer_id IS NOT NULL) OR (COALESCE(value_text_box, ::text) <> ::text)))
);




CREATE TABLE appointment_booking_line (
    id INT NOT NULL,
    appointment_resource_id INT NOT NULL,
    appointment_type_id INT,
    capacity_reserved INT NOT NULL,
    capacity_used INT,
    calendar_event_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    event_start timestamp ,
    event_stop timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT appointment_booking_line_check_capacity_reserved CHECK ((capacity_reserved >= 0)),
    CONSTRAINT appointment_booking_line_check_capacity_used CHECK ((capacity_used >= capacity_reserved))
);

CREATE TABLE appointment_invite (
    id INT NOT NULL,
    appointment_type_count INT,
    create_uid INT,
    write_uid INT,
    access_token VARCHAR(255) NOT NULL,
    short_code VARCHAR(255) NOT NULL,
    resources_choice VARCHAR(255),
    create_date timestamp ,
    write_date timestamp ,
    website_id INT,
    is_published boolean
);

CREATE TABLE appointment_invite_appointment_resource_rel (
    appointment_invite_id INT NOT NULL,
    appointment_resource_id INT NOT NULL
);

CREATE TABLE appointment_invite_appointment_type_rel (
    appointment_invite_id INT NOT NULL,
    appointment_type_id INT NOT NULL
);

CREATE TABLE appointment_invite_res_users_rel (
    appointment_invite_id INT NOT NULL,
    res_users_id INT NOT NULL
);


CREATE TABLE appointment_manage_leaves (
    id INT NOT NULL,
    calendar_id INT,
    create_uid INT,
    write_uid INT,
    reason VARCHAR(255),
    leave_start_dt timestamp  NOT NULL,
    leave_end_dt timestamp  NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);


CREATE TABLE appointment_manage_leaves_appointment_resource_rel (
    appointment_manage_leaves_id INT NOT NULL,
    appointment_resource_id INT NOT NULL
);

CREATE TABLE appointment_question (
    id INT NOT NULL,
    sequence INT,
    appointment_type_id INT,
    create_uid INT,
    write_uid INT,
    question_type VARCHAR(255),
    name json NOT NULL,
    placeholder json,
    question_required boolean,
    create_date timestamp ,
    write_date timestamp 
);


CREATE TABLE appointment_resource (
    id INT NOT NULL,
    resource_id INT NOT NULL,
    company_id INT,
    resource_calendar_id INT,
    sequence INT NOT NULL,
    capacity INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    description json,
    active boolean,
    shareable boolean,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT appointment_resource_check_capacity CHECK ((capacity >= 1))
);

CREATE TABLE appointment_resource_appointment_slot_rel (
    appointment_slot_id INT NOT NULL,
    appointment_resource_id INT NOT NULL
);

CREATE TABLE appointment_resource_linked_appointment_resource (
    resource_id INT NOT NULL,
    linked_resource_id INT NOT NULL
);

CREATE TABLE appointment_slot (
    id INT NOT NULL,
    appointment_type_id INT,
    create_uid INT,
    write_uid INT,
    slot_type VARCHAR(255) NOT NULL,
    weekday VARCHAR(255) NOT NULL,
    allday boolean,
    start_datetime timestamp ,
    end_datetime timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    start_hour double precision NOT NULL,
    end_hour double precision NOT NULL,
    CONSTRAINT appointment_slot_check_start_and_end_hour CHECK (((((end_hour = (0)::double precision) AND ((start_hour >= (0)::double precision) AND (start_hour <= (23.99)::double precision))) OR ((start_hour >= (0)::double precision) AND (start_hour <= end_hour))) AND ((end_hour = (0)::double precision) OR ((end_hour >= start_hour) AND (end_hour <= (23.99)::double precision)))))
);


CREATE TABLE appointment_slot_res_users_rel (
    appointment_slot_id INT NOT NULL,
    res_users_id INT NOT NULL
);

CREATE TABLE appointment_type (
    id INT NOT NULL,
    sequence INT,
    location_id INT,
    booked_mail_template_id INT,
    canceled_mail_template_id INT,
    max_schedule_days INT NOT NULL,
    create_uid INT,
    write_uid INT,
    appointment_tz VARCHAR(255) NOT NULL,
    event_videocall_source VARCHAR(255),
    assign_method VARCHAR(255) NOT NULL,
    avatars_display VARCHAR(255),
    category VARCHAR(255),
    schedule_based_on VARCHAR(255) NOT NULL,
    name json NOT NULL,
    message_confirmation json,
    message_intro json,
    active boolean,
    allow_guests boolean,
    resource_manual_confirmation boolean,
    resource_manage_capacity boolean,
    is_published boolean,
    start_datetime timestamp ,
    end_datetime timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    appointment_duration double precision NOT NULL,
    min_cancellation_hours double precision NOT NULL,
    min_schedule_hours double precision NOT NULL,
    resource_manual_confirmation_percentage double precision,
    work_hours_activated boolean,
    website_id INT,
    website_meta_og_img VARCHAR(255),
    website_meta_title json,
    website_meta_description json,
    website_meta_keywords json,
    seo_name json,
    CONSTRAINT appointment_type_check_resource_manual_confirmation_percentage CHECK (((resource_manual_confirmation_percentage >= (0)::double precision) AND (resource_manual_confirmation_percentage <= (1)::double precision)))
);

CREATE TABLE appointment_type_appointment_resource_rel (
    appointment_resource_id INT NOT NULL,
    appointment_type_id INT NOT NULL
);

CREATE TABLE appointment_type_calendar_alarm_rel (
    appointment_type_id INT NOT NULL,
    calendar_alarm_id INT NOT NULL
);




CREATE TABLE appointment_type_country_rel (
    appointment_type_id INT NOT NULL,
    res_country_id INT NOT NULL
);


CREATE TABLE appointment_type_res_users_rel (
    appointment_type_id INT NOT NULL,
    res_users_id INT NOT NULL
);


CREATE TABLE auth_totp_device (
    id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    scope VARCHAR(255),
    index VARCHAR(255)(8),
    key VARCHAR(255),
    create_date timestamp  DEFAULT (now() AT TIME ZONE utc::text),
    CONSTRAINT auth_totp_device_index_check CHECK ((char_length((index)::text) = 8))
);

CREATE TABLE auth_totp_wizard (
    id INT NOT NULL,
    user_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    secret VARCHAR(255) NOT NULL,
    url VARCHAR(255),
    code VARCHAR(255)(7),
    create_date timestamp ,
    write_date timestamp ,
    qrcode bytea
);

CREATE TABLE badge_unlocked_definition_rel (
    gamification_badge_id INT NOT NULL,
    gamification_goal_definition_id INT NOT NULL
);

CREATE TABLE barcode_nomenclature (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    upc_ean_conv VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);

CREATE TABLE barcode_rule (
    id INT NOT NULL,
    barcode_nomenclature_id INT,
    sequence INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    encoding VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    pattern VARCHAR(255) NOT NULL,
    alias VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);

CREATE TABLE base_document_layout (
    id INT NOT NULL,
    company_id INT NOT NULL,
    report_layout_id INT,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);

CREATE TABLE base_enable_profiling_wizard (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    duration VARCHAR(255),
    expiration timestamp ,
    create_date timestamp ,
    write_date timestamp 
);


CREATE TABLE base_import_import (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    res_model VARCHAR(255),
    file_name VARCHAR(255),
    file_type VARCHAR(255),
    create_date timestamp ,
    write_date timestamp ,
    file bytea
);


CREATE TABLE base_import_mapping (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    res_model VARCHAR(255),
    column_name VARCHAR(255),
    field_name VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);





CREATE TABLE base_import_module (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    state VARCHAR(255),
    import_message text,
    modules_dependencies text,
    force boolean,
    with_demo boolean,
    create_date timestamp ,
    write_date timestamp ,
    module_file bytea NOT NULL
);

CREATE TABLE base_language_export (
    id INT NOT NULL,
    model_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    lang VARCHAR(255) NOT NULL,
    format VARCHAR(255) NOT NULL,
    export_type VARCHAR(255) NOT NULL,
    domain VARCHAR(255),
    state VARCHAR(255),
    create_date timestamp ,
    write_date timestamp ,
    data bytea
);

CREATE TABLE base_language_import (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(255)(6) NOT NULL,
    filename VARCHAR(255) NOT NULL,
    overwrite boolean,
    create_date timestamp ,
    write_date timestamp ,
    data bytea NOT NULL
);




CREATE TABLE base_language_install (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    overwrite boolean,
    create_date timestamp ,
    write_date timestamp 
);


CREATE TABLE base_language_install_website_rel (
    base_language_install_id INT NOT NULL,
    website_id INT NOT NULL
);







CREATE TABLE base_module_install_request (
    id INT NOT NULL,
    module_id INT NOT NULL,
    user_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    body_html text,
    create_date timestamp ,
    write_date timestamp 
);






CREATE TABLE base_module_install_review (
    id INT NOT NULL,
    module_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);

CREATE TABLE base_module_uninstall (
    id INT NOT NULL,
    module_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    show_all boolean,
    create_date timestamp ,
    write_date timestamp 
);











CREATE TABLE base_module_update (
    id INT NOT NULL,
    updated INT,
    added INT,
    create_uid INT,
    write_uid INT,
    state VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);








CREATE TABLE base_module_upgrade (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    module_info text,
    create_date timestamp ,
    write_date timestamp 
);

CREATE TABLE base_partner_merge_automatic_wizard (
    id INT NOT NULL,
    number_group INT,
    current_line_id INT,
    dst_partner_id INT,
    maximum_group INT,
    create_uid INT,
    write_uid INT,
    state VARCHAR(255) NOT NULL,
    group_by_email boolean,
    group_by_name boolean,
    group_by_is_company boolean,
    group_by_vat boolean,
    group_by_parent_id boolean,
    exclude_contact boolean,
    exclude_journal_item boolean,
    create_date timestamp ,
    write_date timestamp 
);








CREATE TABLE base_partner_merge_automatic_wizard_res_partner_rel (
    base_partner_merge_automatic_wizard_id INT NOT NULL,
    res_partner_id INT NOT NULL
);







CREATE TABLE base_partner_merge_line (
    id INT NOT NULL,
    wizard_id INT,
    min_id INT,
    create_uid INT,
    write_uid INT,
    aggr_ids VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);





























CREATE TABLE bus_bus (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    channel VARCHAR(255),
    message VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);
























CREATE TABLE bus_presence (
    id INT NOT NULL,
    user_id INT,
    status VARCHAR(255),
    last_poll timestamp ,
    last_presence timestamp ,
    guest_id INT,
    CONSTRAINT bus_presence_partner_or_guest_exists CHECK ((((user_id IS NOT NULL) AND (guest_id IS NULL)) OR ((user_id IS NULL) AND (guest_id IS NOT NULL))))
);









CREATE TABLE calendar_alarm (
    id INT NOT NULL,
    duration INT NOT NULL,
    duration_minutes INT,
    mail_template_id INT,
    create_uid INT,
    write_uid INT,
    alarm_type VARCHAR(255) NOT NULL,
    "interval" VARCHAR(255) NOT NULL,
    name json NOT NULL,
    body text,
    create_date timestamp ,
    write_date timestamp ,
    default_for_new_appointment_type boolean,
    sms_template_id INT,
    sms_notify_responsible boolean
);


CREATE TABLE crm_lead (
    id INT NOT NULL,
    campaign_id INT,
    source_id INT,
    medium_id INT,
    message_bounce INT,
    user_id INT,
    team_id INT,
    company_id INT,
    stage_id INT,
    color INT,
    recurring_plan INT,
    partner_id INT,
    title INT,
    lang_id INT,
    state_id INT,
    country_id INT,
    create_uid INT,
    write_uid INT,
    phone_sanitized VARCHAR(255),
    email_normalized VARCHAR(255),
    email_cc VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    referred VARCHAR(255),
    type VARCHAR(255) NOT NULL,
    priority VARCHAR(255),
    contact_name VARCHAR(255),
    partner_name VARCHAR(255),
    function_value VARCHAR(255),
    email_from VARCHAR(255),
    email_domain_criterion VARCHAR(255),
    phone VARCHAR(255),
    mobile VARCHAR(255),
    phone_state VARCHAR(255),
    email_state VARCHAR(255),
    website VARCHAR(255),
    street VARCHAR(255),
    street2 VARCHAR(255),
    zip VARCHAR(255),
    city VARCHAR(255),
    date_deadline DATE,
    lead_properties JSON,
    description TEXT,
    expected_revenue DECIMAL(19, 4),
    prorated_revenue DECIMAL(19, 4),
    recurring_revenue DECIMAL(19, 4),
    recurring_revenue_monthly DECIMAL(19, 4),
    recurring_revenue_monthly_prorated DECIMAL(19, 4),
    recurring_revenue_prorated DECIMAL(19, 4),
    active BOOLEAN,
    date_closed TIMESTAMP,
    date_automation_last TIMESTAMP,
    date_open TIMESTAMP,
    date_last_stage_update TIMESTAMP,
    date_conversion TIMESTAMP,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    day_open DOUBLE,
    day_close DOUBLE,
    probability DOUBLE,
    automated_probability DOUBLE,
    won_status VARCHAR(255),
    days_to_convert DOUBLE,
    days_exceeding_closing DOUBLE,
    reveal_id VARCHAR(255),
    iap_enrich_done BOOLEAN,
    lead_mining_request_id INT,
    event_lead_rule_id INT,
    event_id INT,
    x_property_id INT,
    CONSTRAINT crm_lead_check_probability CHECK (probability >= 0 AND probability <= 100),
    PRIMARY KEY (id)
);

















































CREATE TABLE calendar_alarm_calendar_event_rel (
    calendar_event_id INT NOT NULL,
    calendar_alarm_id INT NOT NULL
);







CREATE TABLE calendar_attendee (
    id INT NOT NULL,
    event_id INT NOT NULL,
    partner_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    common_name VARCHAR(255),
    access_token VARCHAR(255),
    state VARCHAR(255),
    availability VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);





CREATE TABLE calendar_event (
    id INT NOT NULL,
    user_id INT,
    videocall_channel_id INT,
    res_id INT,
    res_model_id INT,
    recurrence_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    videocall_location VARCHAR(255),
    access_token VARCHAR(255),
    privacy VARCHAR(255) NOT NULL,
    show_as VARCHAR(255) NOT NULL,
    res_model VARCHAR(255),
    start_date date,
    stop_date date,
    description text,
    active boolean,
    allday boolean,
    recurrency boolean,
    follow_recurrence boolean,
    start timestamp  NOT NULL,
    stop timestamp  NOT NULL,
    create_date timestamp ,
    write_date timestamp ,
    duration double precision,
    appointment_type_id INT,
    appointment_invite_id INT,
    appointment_booker_id INT,
    appointment_attended boolean
);




CREATE TABLE calendar_event_res_partner_rel (
    res_partner_id INT NOT NULL,
    calendar_event_id INT NOT NULL
);


CREATE TABLE calendar_event_type (
    id INT NOT NULL,
    color INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);







CREATE TABLE calendar_filters (
    id INT NOT NULL,
    user_id INT NOT NULL,
    partner_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    active boolean,
    partner_checked boolean,
    create_date timestamp ,
    write_date timestamp 
);






CREATE TABLE calendar_popover_delete_wizard (
    id INT NOT NULL,
    record INT,
    create_uid INT,
    write_uid INT,
    delete VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);








CREATE TABLE calendar_provider_config (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    external_calendar_provider VARCHAR(255),
    cal_client_id VARCHAR(255),
    cal_client_secret VARCHAR(255),
    microsoft_outlook_client_identifier VARCHAR(255),
    microsoft_outlook_client_secret VARCHAR(255),
    cal_sync_paused boolean,
    microsoft_outlook_sync_paused boolean,
    create_date timestamp ,
    write_date timestamp 
);









CREATE TABLE calendar_recurrence (
    id INT NOT NULL,
    base_event_id INT,
    "interval" INT,
    count INT,
    day INT,
    trigger_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    event_tz VARCHAR(255),
    rrule VARCHAR(255),
    rrule_type VARCHAR(255),
    end_type VARCHAR(255),
    month_by VARCHAR(255),
    weekday VARCHAR(255),
    byday VARCHAR(255),
    until date,
    mon boolean,
    tue boolean,
    wed boolean,
    thu boolean,
    fri boolean,
    sat boolean,
    sun boolean,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT calendar_recurrence_month_day CHECK ((((rrule_type)::text <> monthly::text) OR ((month_by)::text <> day::text) OR ((day >= 1) AND (day <= 31)) OR (((weekday)::text = ANY ((ARRAY[MON::VARCHAR(255), TUE::VARCHAR(255), WED::VARCHAR(255), THU::VARCHAR(255), FRI::VARCHAR(255), SAT::VARCHAR(255), SUN::VARCHAR(255)])::text[])) AND ((byday)::text = ANY ((ARRAY[1::VARCHAR(255), 2::VARCHAR(255), 3::VARCHAR(255), 4::VARCHAR(255), -1::VARCHAR(255)])::text[])))))
);




CREATE TABLE change_password_own (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    new_password VARCHAR(255),
    confirm_password VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);










CREATE TABLE change_password_user (
    id INT NOT NULL,
    wizard_id INT NOT NULL,
    user_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    user_login VARCHAR(255),
    new_passwd VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);































CREATE TABLE change_password_wizard (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);










CREATE TABLE decimal_precision (
    id INT NOT NULL,
    digits INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);




















CREATE TABLE digest_digest (
    id INT NOT NULL,
    company_id INT,
    create_uid INT,
    write_uid INT,
    periodicity VARCHAR(255) NOT NULL,
    state VARCHAR(255),
    next_run_date date,
    name json NOT NULL,
    kpi_res_users_connected boolean,
    kpi_mail_message_total boolean,
    create_date timestamp ,
    write_date timestamp ,
    kpi_project_task_opened boolean
);








CREATE TABLE digest_digest_res_users_rel (
    digest_digest_id INT NOT NULL,
    res_users_id INT NOT NULL
);







CREATE TABLE digest_tip (
    id INT NOT NULL,
    sequence INT,
    group_id INT,
    create_uid INT,
    write_uid INT,
    name json,
    tip_description json,
    create_date timestamp ,
    write_date timestamp 
);














CREATE TABLE digest_tip_res_users_rel (
    digest_tip_id INT NOT NULL,
    res_users_id INT NOT NULL
);







CREATE TABLE discuss_channel (
    id INT NOT NULL,
    group_public_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    channel_type VARCHAR(255) NOT NULL,
    default_display_mode VARCHAR(255),
    sfu_channel_uuid VARCHAR(255),
    sfu_server_url VARCHAR(255),
    uuid VARCHAR(255)(50),
    description text,
    active boolean,
    allow_public_upload boolean,
    last_interest_dt timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT discuss_channel_channel_type_not_null CHECK ((channel_type IS NOT NULL)),
    CONSTRAINT discuss_channel_group_public_id_check CHECK ((((channel_type)::text = channel::text) OR (group_public_id IS NULL)))
);








CREATE TABLE discuss_channel_hr_department_rel (
    discuss_channel_id INT NOT NULL,
    hr_department_id INT NOT NULL
);





CREATE TABLE discuss_channel_member (
    id INT NOT NULL,
    partner_id INT,
    guest_id INT,
    channel_id INT NOT NULL,
    fetched_message_id INT,
    seen_message_id INT,
    rtc_inviting_session_id INT,
    create_uid INT,
    write_uid INT,
    custom_channel_name VARCHAR(255),
    fold_state VARCHAR(255),
    custom_notifications VARCHAR(255),
    mute_until_dt timestamp ,
    unpin_dt timestamp ,
    last_interest_dt timestamp ,
    last_seen_dt timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT discuss_channel_member_partner_or_guest_exists CHECK ((((partner_id IS NOT NULL) AND (guest_id IS NULL)) OR ((partner_id IS NULL) AND (guest_id IS NOT NULL))))
);



















CREATE TABLE discuss_channel_res_groups_rel (
    discuss_channel_id INT NOT NULL,
    res_groups_id INT NOT NULL
);







CREATE TABLE discuss_channel_rtc_session (
    id INT NOT NULL,
    channel_member_id INT NOT NULL,
    channel_id INT,
    create_uid INT,
    write_uid INT,
    is_screen_sharing_on boolean,
    is_camera_on boolean,
    is_muted boolean,
    is_deaf boolean,
    write_date timestamp ,
    create_date timestamp 
);














CREATE TABLE discuss_gif_favorite (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    tenor_gif_id VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);








CREATE TABLE discuss_voice_metadata (
    id INT NOT NULL,
    attachment_id INT,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);





















CREATE TABLE email_template_attachment_rel (
    email_template_id INT NOT NULL,
    attachment_id INT NOT NULL
);







CREATE TABLE employee_category_rel (
    emp_id INT NOT NULL,
    category_id INT NOT NULL
);







CREATE TABLE event_event (
    id INT NOT NULL,
    user_id INT,
    company_id INT,
    organizer_id INT,
    event_type_id INT,
    stage_id INT,
    seats_max INT,
    address_id INT,
    country_id INT,
    create_uid INT,
    write_uid INT,
    kanban_state VARCHAR(255),
    kanban_state_label VARCHAR(255),
    date_tz VARCHAR(255) NOT NULL,
    lang VARCHAR(255),
    badge_format VARCHAR(255) NOT NULL,
    name json NOT NULL,
    description json,
    registration_properties_definition json,
    ticket_instructions json,
    note text,
    active boolean,
    seats_limited boolean NOT NULL,
    date_begin timestamp  NOT NULL,
    date_end timestamp  NOT NULL,
    create_date timestamp ,
    write_date timestamp ,
    website_id INT,
    menu_id INT,
    website_meta_og_img VARCHAR(255),
    website_visibility VARCHAR(255) NOT NULL,
    website_meta_title json,
    website_meta_description json,
    website_meta_keywords json,
    seo_name json,
    subtitle json,
    cover_properties text,
    is_published boolean,
    website_menu boolean,
    menu_register_cta boolean,
    introduction_menu boolean,
    location_menu boolean,
    register_menu boolean,
    community_menu boolean
);


CREATE TABLE event_event_event_tag_rel (
    event_event_id INT NOT NULL,
    event_tag_id INT NOT NULL
);






CREATE TABLE event_event_ticket (
    id INT NOT NULL,
    sequence INT,
    event_type_id INT,
    seats_max INT,
    create_uid INT,
    write_uid INT,
    event_id INT NOT NULL,
    color VARCHAR(255),
    name json NOT NULL,
    description json,
    seats_limited boolean,
    create_date timestamp ,
    write_date timestamp ,
    start_sale_datetime timestamp ,
    end_sale_datetime timestamp 
);











































CREATE TABLE event_mail (
    id INT NOT NULL,
    event_id INT NOT NULL,
    sequence INT,
    interval_nbr INT,
    mail_count_done INT,
    create_uid INT,
    write_uid INT,
    notification_type VARCHAR(255) NOT NULL,
    interval_unit VARCHAR(255) NOT NULL,
    interval_type VARCHAR(255) NOT NULL,
    template_ref VARCHAR(255) NOT NULL,
    mail_done boolean,
    scheduled_date timestamp ,
    create_date timestamp ,
    write_date timestamp 
);











































CREATE TABLE event_mail_registration (
    id INT NOT NULL,
    scheduler_id INT NOT NULL,
    registration_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    mail_sent boolean,
    scheduled_date timestamp ,
    create_date timestamp ,
    write_date timestamp 
);























CREATE TABLE event_question (
    id INT NOT NULL,
    event_type_id INT,
    event_id INT,
    sequence INT,
    create_uid INT,
    write_uid INT,
    question_type VARCHAR(255) NOT NULL,
    title json NOT NULL,
    once_per_order boolean,
    is_mandatory_answer boolean,
    create_date timestamp ,
    write_date timestamp 
);








































CREATE TABLE event_question_answer (
    id INT NOT NULL,
    question_id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);































CREATE TABLE event_registration (
    id INT NOT NULL,
    event_id INT NOT NULL,
    event_ticket_id INT,
    utm_campaign_id INT,
    utm_source_id INT,
    utm_medium_id INT,
    partner_id INT,
    company_id INT,
    create_uid INT,
    write_uid INT,
    barcode VARCHAR(255),
    name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255),
    company_name VARCHAR(255),
    state VARCHAR(255),
    registration_properties json,
    active boolean,
    date_closed timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    event_begin_date timestamp ,
    visitor_id INT
);




CREATE TABLE event_registration_answer (
    id INT NOT NULL,
    question_id INT NOT NULL,
    registration_id INT NOT NULL,
    value_answer_id INT,
    create_uid INT,
    write_uid INT,
    value_text_box text,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT event_registration_answer_value_check CHECK (((value_answer_id IS NOT NULL) OR (COALESCE(value_text_box, ::text) <> ::text)))
);
































CREATE TABLE event_stage (
    id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    description json,
    legend_blocked json NOT NULL,
    legend_done json NOT NULL,
    legend_normal json NOT NULL,
    fold boolean,
    pipe_end boolean,
    create_date timestamp ,
    write_date timestamp 
);







































CREATE TABLE event_tag (
    id INT NOT NULL,
    sequence INT,
    category_id INT NOT NULL,
    category_sequence INT,
    color INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp ,
    website_id INT,
    is_published boolean
);








































CREATE TABLE event_tag_category (
    id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp ,
    website_id INT,
    is_published boolean
);




























CREATE TABLE event_tag_event_type_rel (
    event_type_id INT NOT NULL,
    event_tag_id INT NOT NULL
);






CREATE TABLE event_type (
    id INT NOT NULL,
    sequence INT,
    seats_max INT,
    create_uid INT,
    write_uid INT,
    default_timezone VARCHAR(255),
    name json NOT NULL,
    ticket_instructions json,
    note text,
    has_seats_limitation boolean,
    create_date timestamp ,
    write_date timestamp ,
    website_menu boolean,
    community_menu boolean,
    menu_register_cta boolean
);


CREATE TABLE event_type_mail (
    id INT NOT NULL,
    event_type_id INT NOT NULL,
    interval_nbr INT,
    create_uid INT,
    write_uid INT,
    notification_type VARCHAR(255) NOT NULL,
    interval_unit VARCHAR(255) NOT NULL,
    interval_type VARCHAR(255) NOT NULL,
    template_ref VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);
































CREATE TABLE event_type_ticket (
    id INT NOT NULL,
    sequence INT,
    event_type_id INT NOT NULL,
    seats_max INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    description json,
    seats_limited boolean,
    create_date timestamp ,
    write_date timestamp 
);




























CREATE TABLE fetchmail_server (
    id INT NOT NULL,
    port INT,
    object_id INT,
    priority INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    state VARCHAR(255),
    server VARCHAR(255),
    server_type VARCHAR(255) NOT NULL,
    "user" VARCHAR(255),
    password VARCHAR(255),
    script VARCHAR(255),
    configuration text,
    active boolean,
    is_ssl boolean,
    attach boolean,
    original boolean,
    date timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    google_gmail_access_token_expiration INT,
    google_gmail_authorization_code VARCHAR(255),
    google_gmail_refresh_token VARCHAR(255),
    google_gmail_access_token VARCHAR(255)
);












































































CREATE TABLE gamification_badge (
    id INT NOT NULL,
    rule_max_number INT,
    create_uid INT,
    write_uid INT,
    level VARCHAR(255),
    rule_auth VARCHAR(255) NOT NULL,
    name json NOT NULL,
    description json,
    active boolean,
    rule_max boolean,
    create_date timestamp ,
    write_date timestamp ,
    survey_id INT
);











































CREATE TABLE gamification_badge_rule_badge_rel (
    badge1_id INT NOT NULL,
    badge2_id INT NOT NULL
);







CREATE TABLE gamification_badge_user (
    id INT NOT NULL,
    user_id INT NOT NULL,
    sender_id INT,
    badge_id INT NOT NULL,
    challenge_id INT,
    create_uid INT,
    write_uid INT,
    level VARCHAR(255),
    comment text,
    create_date timestamp ,
    write_date timestamp ,
    employee_id INT
);


































CREATE TABLE gamification_badge_user_wizard (
    id INT NOT NULL,
    user_id INT NOT NULL,
    badge_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    comment text,
    create_date timestamp ,
    write_date timestamp ,
    employee_id INT
);






CREATE TABLE gamification_challenge (
    id INT NOT NULL,
    manager_id INT,
    reward_id INT,
    reward_first_id INT,
    reward_second_id INT,
    reward_third_id INT,
    report_message_group_id INT,
    report_template_id INT NOT NULL,
    remind_update_delay INT,
    create_uid INT,
    write_uid INT,
    state VARCHAR(255) NOT NULL,
    user_domain VARCHAR(255),
    period VARCHAR(255) NOT NULL,
    visibility_mode VARCHAR(255) NOT NULL,
    report_message_frequency VARCHAR(255) NOT NULL,
    challenge_category VARCHAR(255) NOT NULL,
    start_date date,
    end_date date,
    last_report_date date,
    next_report_date date,
    name json NOT NULL,
    description json,
    reward_failure boolean,
    reward_realtime boolean,
    create_date timestamp ,
    write_date timestamp 
);


































CREATE TABLE gamification_challenge_line (
    id INT NOT NULL,
    challenge_id INT NOT NULL,
    definition_id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp ,
    target_goal double precision NOT NULL
);




CREATE TABLE gamification_challenge_users_rel (
    gamification_challenge_id INT NOT NULL,
    res_users_id INT NOT NULL
);







CREATE TABLE gamification_goal (
    id INT NOT NULL,
    definition_id INT NOT NULL,
    user_id INT NOT NULL,
    line_id INT,
    challenge_id INT,
    remind_update_delay INT,
    create_uid INT,
    write_uid INT,
    state VARCHAR(255) NOT NULL,
    start_date date,
    end_date date,
    last_update date,
    to_update boolean,
    closed boolean,
    create_date timestamp ,
    write_date timestamp ,
    target_goal double precision NOT NULL,
    current double precision NOT NULL
);


























































CREATE TABLE gamification_goal_definition (
    id INT NOT NULL,
    model_id INT,
    field_id INT,
    field_date_id INT,
    batch_distinctive_field INT,
    action_id INT,
    create_uid INT,
    write_uid INT,
    computation_mode VARCHAR(255) NOT NULL,
    display_mode VARCHAR(255) NOT NULL,
    domain VARCHAR(255) NOT NULL,
    batch_user_expression VARCHAR(255),
    condition VARCHAR(255) NOT NULL,
    res_id_field VARCHAR(255),
    name json NOT NULL,
    suffix json,
    description text,
    compute_code text,
    monetary boolean,
    batch_mode boolean,
    create_date timestamp ,
    write_date timestamp 
);










































CREATE TABLE gamification_goal_wizard (
    id INT NOT NULL,
    goal_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp ,
    current double precision
);
























CREATE TABLE gamification_invited_user_ids_rel (
    gamification_challenge_id INT NOT NULL,
    res_users_id INT NOT NULL
);







CREATE TABLE gamification_karma_rank (
    id INT NOT NULL,
    karma_min INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    description json,
    description_motivational json,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT gamification_karma_rank_karma_min_check CHECK ((karma_min > 0))
);


















CREATE TABLE gamification_karma_tracking (
    id INT NOT NULL,
    user_id INT NOT NULL,
    old_value INT,
    new_value INT NOT NULL,
    create_uid INT,
    write_uid INT,
    origin_ref VARCHAR(255),
    origin_ref_model_name VARCHAR(255),
    reason text,
    consolidated boolean,
    tracking_date timestamp ,
    create_date timestamp ,
    write_date timestamp 
);



















CREATE TABLE hr_contract_sign_document_wizard (
    id INT NOT NULL,
    contract_id INT,
    responsible_id INT,
    employee_role_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    subject VARCHAR(255) NOT NULL,
    mail_to VARCHAR(255),
    message TEXT,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    PRIMARY KEY (id)
);



CREATE TABLE hr_contract_sign_document_wizard_ir_attachment_rel (
    hr_contract_sign_document_wizard_id INT NOT NULL,
    ir_attachment_id INT NOT NULL,
    PRIMARY KEY (hr_contract_sign_document_wizard_id, ir_attachment_id)
);



CREATE TABLE hr_contract_sign_document_wizard_res_partner_rel (
    hr_contract_sign_document_wizard_id INT NOT NULL,
    res_partner_id INT NOT NULL,
    PRIMARY KEY (hr_contract_sign_document_wizard_id, res_partner_id)
);




CREATE TABLE hr_contract_sign_document_wizard_sign_template_rel (
    hr_contract_sign_document_wizard_id INT NOT NULL,
    sign_template_id INT NOT NULL,
    PRIMARY KEY (hr_contract_sign_document_wizard_id, sign_template_id)
);



CREATE TABLE hr_contract_sign_request_rel (
    hr_contract_id INT NOT NULL,
    sign_request_id INT NOT NULL,
    PRIMARY KEY (hr_contract_id, sign_request_id)
);



CREATE TABLE hr_contract_type (
    id INT NOT NULL,
    sequence INT,
    country_id INT,
    create_uid INT,
    write_uid INT,
    code VARCHAR(255),
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);













CREATE TABLE hr_department (
    id INT NOT NULL,
    company_id INT,
    parent_id INT,
    manager_id INT,
    color INT,
    master_department_id INT,
    create_uid INT,
    write_uid INT,
    complete_name VARCHAR(255),
    parent_path VARCHAR(255),
    name json NOT NULL,
    note text,
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);












































CREATE TABLE hr_departure_reason (
    id INT NOT NULL,
    sequence INT,
    reason_code INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);















CREATE TABLE hr_departure_wizard (
    id INT NOT NULL,
    departure_reason_id INT NOT NULL,
    employee_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    departure_date date NOT NULL,
    departure_description text,
    create_date timestamp ,
    write_date timestamp 
);




























CREATE TABLE hr_employee (
    id INT NOT NULL,
    resource_id INT NOT NULL,
    company_id INT NOT NULL,
    resource_calendar_id INT,
    message_main_attachment_id INT,
    color INT,
    department_id INT,
    job_id INT,
    address_id INT,
    work_contact_id INT,
    work_location_id INT,
    user_id INT,
    parent_id INT,
    coach_id INT,
    private_state_id INT,
    private_country_id INT,
    country_id INT,
    children INT,
    country_of_birth INT,
    bank_account_id INT,
    km_home_work INT,
    departure_reason_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    job_title VARCHAR(255),
    work_phone VARCHAR(255),
    mobile_phone VARCHAR(255),
    work_email VARCHAR(255),
    private_street VARCHAR(255),
    private_street2 VARCHAR(255),
    private_city VARCHAR(255),
    private_zip VARCHAR(255),
    private_phone VARCHAR(255),
    private_email VARCHAR(255),
    lang VARCHAR(255),
    gender VARCHAR(255),
    marital VARCHAR(255) NOT NULL,
    spouse_complete_name VARCHAR(255),
    place_of_birth VARCHAR(255),
    ssnid VARCHAR(255),
    sinid VARCHAR(255),
    identification_id VARCHAR(255),
    passport_id VARCHAR(255),
    permit_no VARCHAR(255),
    visa_no VARCHAR(255),
    certificate VARCHAR(255),
    study_field VARCHAR(255),
    study_school VARCHAR(255),
    emergency_contact VARCHAR(255),
    emergency_phone VARCHAR(255),
    employee_type VARCHAR(255) NOT NULL,
    barcode VARCHAR(255),
    pin VARCHAR(255),
    private_car_plate VARCHAR(255),
    spouse_birthdate date,
    birthday date,
    visa_expire date,
    work_permit_expiration_date date,
    departure_date date,
    employee_properties json,
    additional_note text,
    notes text,
    departure_description text,
    active boolean,
    work_permit_scheduled_activity boolean,
    create_date timestamp ,
    write_date timestamp ,
    hourly_cost numeric,
    employee_token VARCHAR(255)
);







CREATE TABLE hr_employee_category (
    id INT NOT NULL,
    color INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);



















CREATE TABLE hr_employee_cv_wizard (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    color_primary VARCHAR(255) NOT NULL,
    color_secondary VARCHAR(255) NOT NULL,
    show_skills boolean,
    show_contact boolean,
    show_others boolean,
    create_date timestamp ,
    write_date timestamp 
);






























CREATE TABLE hr_employee_hr_employee_cv_wizard_rel (
    hr_employee_cv_wizard_id INT NOT NULL,
    hr_employee_id INT NOT NULL
);







CREATE TABLE hr_employee_hr_skill_rel (
    hr_employee_id INT NOT NULL,
    hr_skill_id INT NOT NULL
);









CREATE TABLE hr_employee_planning_send_rel (
    planning_send_id INT NOT NULL,
    hr_employee_id INT NOT NULL
);







CREATE VIEW hr_employee_public AS
 SELECT emp.name,
    emp.active,
    emp.color,
    emp.department_id,
    emp.job_id,
    emp.job_title,
    emp.company_id,
    emp.address_id,
    emp.work_phone,
    emp.mobile_phone,
    emp.work_email,
    emp.work_contact_id,
    emp.work_location_id,
    emp.user_id,
    emp.resource_id,
    emp.resource_calendar_id,
    emp.parent_id,
    emp.coach_id,
    emp.create_date,
    emp.id,
    emp.create_uid,
    emp.write_uid,
    emp.write_date
   FROM hr_employee emp;




CREATE TABLE hr_employee_skill (
    id INT NOT NULL,
    employee_id INT NOT NULL,
    skill_id INT NOT NULL,
    skill_level_id INT NOT NULL,
    skill_type_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);

CREATE TABLE hr_employee_skill_log (
    id INT NOT NULL,
    employee_id INT NOT NULL,
    department_id INT,
    skill_id INT NOT NULL,
    skill_level_id INT NOT NULL,
    skill_type_id INT NOT NULL,
    level_progress INT,
    create_uid INT,
    write_uid INT,
    date date,
    create_date timestamp ,
    write_date timestamp 
);




























CREATE TABLE hr_skill_level (
    id INT NOT NULL,
    skill_type_id INT,
    level_progress INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    default_level boolean,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT hr_skill_level_check_level_progress CHECK (((level_progress >= 0) AND (level_progress <= 100)))
);


































CREATE TABLE hr_skill_type (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);

























CREATE VIEW hr_employee_skill_report AS
 SELECT row_number() OVER () AS id,
    e.id AS employee_id,
    e.company_id,
    e.department_id,
    s.skill_id,
    s.skill_type_id,
    ((sl.level_progress)::numeric / 100.0) AS level_progress,
    sl.name AS skill_level
   FROM (((hr_employee e
     LEFT JOIN hr_employee_skill s ON ((e.id = s.employee_id)))
     LEFT JOIN hr_skill_level sl ON ((sl.id = s.skill_level_id)))
     LEFT JOIN hr_skill_type st ON ((st.id = sl.skill_type_id)))
  WHERE (st.active IS TRUE);




CREATE TABLE hr_job (
    id INT NOT NULL,
    sequence INT,
    expected_employees INT,
    no_of_employee INT,
    no_of_recruitment INT,
    department_id INT,
    company_id INT,
    contract_type_id INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    description text,
    requirements text,
    active boolean,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT hr_job_no_of_recruitment_positive CHECK ((no_of_recruitment >= 0))
);































CREATE TABLE hr_resume_line (
    id INT NOT NULL,
    employee_id INT NOT NULL,
    line_type_id INT,
    create_uid INT,
    write_uid INT,
    display_type VARCHAR(255),
    date_start date NOT NULL,
    date_end date,
    name json NOT NULL,
    description json,
    create_date timestamp ,
    write_date timestamp ,
    department_id INT,
    survey_id INT,
    expiration_status VARCHAR(255),
    CONSTRAINT hr_resume_line_date_check CHECK (((date_start <= date_end) OR (date_end IS NULL)))
);














































CREATE TABLE hr_resume_line_type (
    id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);








CREATE TABLE hr_skill (
    id INT NOT NULL,
    sequence INT,
    skill_type_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);












CREATE TABLE hr_work_location (
    id INT NOT NULL,
    company_id INT NOT NULL,
    address_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    location_type VARCHAR(255) NOT NULL,
    location_number VARCHAR(255),
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);
































CREATE TABLE iap_account (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    service_name VARCHAR(255),
    account_token VARCHAR(255)(43),
    show_token boolean,
    create_date timestamp ,
    write_date timestamp 
);























CREATE TABLE iap_account_info (
    id INT NOT NULL,
    account_id INT,
    create_uid INT,
    write_uid INT,
    account_token VARCHAR(255),
    account_uuid_hashed VARCHAR(255),
    service_name VARCHAR(255),
    description VARCHAR(255),
    warning_email VARCHAR(255),
    unit_name VARCHAR(255),
    balance numeric,
    warn_me boolean,
    create_date timestamp ,
    write_date timestamp ,
    warning_threshold double precision
);
















































CREATE TABLE iap_account_res_company_rel (
    iap_account_id INT NOT NULL,
    res_company_id INT NOT NULL
);







CREATE TABLE ir_actions (
    id INT NOT NULL,
    binding_model_id INT,
    create_uid INT,
    write_uid INT,
    type VARCHAR(255) NOT NULL,
    path VARCHAR(255),
    binding_type VARCHAR(255) NOT NULL,
    binding_view_types VARCHAR(255),
    name json NOT NULL,
    help json,
    create_date timestamp ,
    write_date timestamp 
);





































CREATE TABLE ir_act_client (
    tag VARCHAR(255) NOT NULL,
    target VARCHAR(255),
    res_model VARCHAR(255),
    context VARCHAR(255) NOT NULL,
    params_store bytea
)
INHERITS (ir_actions);



















CREATE TABLE ir_act_report_xml (
    paperformat_id INT,
    model VARCHAR(255) NOT NULL,
    report_type VARCHAR(255) NOT NULL,
    report_name VARCHAR(255) NOT NULL,
    report_file VARCHAR(255),
    attachment VARCHAR(255),
    print_report_name json,
    multi boolean,
    attachment_use boolean
)
INHERITS (ir_actions);































CREATE TABLE ir_act_server (
    sequence INT,
    model_id INT NOT NULL,
    crud_model_id INT,
    link_field_id INT,
    update_field_id INT,
    update_related_model_id INT,
    selection_value INT,
    usage VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    model_name VARCHAR(255),
    update_path VARCHAR(255),
    update_m2m_operation VARCHAR(255),
    update_boolean_value VARCHAR(255),
    evaluation_type VARCHAR(255),
    resource_ref VARCHAR(255),
    webhook_url VARCHAR(255),
    code text,
    value text,
    template_id INT,
    activity_type_id INT,
    activity_date_deadline_range INT,
    activity_user_id INT,
    mail_post_method VARCHAR(255),
    activity_summary VARCHAR(255),
    activity_date_deadline_range_type VARCHAR(255),
    activity_user_type VARCHAR(255),
    activity_user_field_name VARCHAR(255),
    activity_note text,
    mail_post_autofollow boolean,
    sms_template_id INT,
    sms_method VARCHAR(255),
    website_path VARCHAR(255),
    website_published boolean
)
INHERITS (ir_actions);







































































































CREATE TABLE ir_act_server_group_rel (
    act_id INT NOT NULL,
    gid INT NOT NULL
);







CREATE TABLE ir_act_server_res_partner_rel (
    ir_act_server_id INT NOT NULL,
    res_partner_id INT NOT NULL
);







CREATE TABLE ir_act_server_webhook_field_rel (
    server_id INT NOT NULL,
    field_id INT NOT NULL
);







CREATE TABLE ir_act_url (
    target VARCHAR(255) NOT NULL,
    url text NOT NULL
)
INHERITS (ir_actions);










CREATE TABLE ir_act_window (
    view_id INT,
    res_id INT,
    "limit" INT,
    search_view_id INT,
    domain VARCHAR(255),
    context VARCHAR(255) NOT NULL,
    res_model VARCHAR(255) NOT NULL,
    target VARCHAR(255),
    view_mode VARCHAR(255) NOT NULL,
    mobile_view_mode VARCHAR(255),
    usage VARCHAR(255),
    filter boolean
)
INHERITS (ir_actions);








































CREATE TABLE ir_act_window_group_rel (
    act_id INT NOT NULL,
    gid INT NOT NULL
);







CREATE TABLE ir_act_window_view (
    id INT NOT NULL,
    sequence INT,
    view_id INT,
    act_window_id INT,
    create_uid INT,
    write_uid INT,
    view_mode VARCHAR(255) NOT NULL,
    multi boolean,
    create_date timestamp ,
    write_date timestamp 
);

































CREATE TABLE ir_actions_todo (
    id INT NOT NULL,
    action_id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    state VARCHAR(255) NOT NULL,
    name VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);

























CREATE TABLE ir_asset (
    id INT NOT NULL,
    sequence INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    bundle VARCHAR(255) NOT NULL,
    directive VARCHAR(255),
    path VARCHAR(255) NOT NULL,
    target VARCHAR(255),
    active boolean,
    create_date timestamp ,
    write_date timestamp ,
    website_id INT,
    theme_template_id INT,
    key VARCHAR(255)
);









































CREATE TABLE ir_attachment (
    id INT NOT NULL,
    res_id INT,
    company_id INT,
    file_size INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    res_model VARCHAR(255),
    res_field VARCHAR(255),
    type VARCHAR(255) NOT NULL,
    url VARCHAR(255)(1024),
    access_token VARCHAR(255),
    store_fname VARCHAR(255),
    checksum VARCHAR(255)(40),
    mimetype VARCHAR(255),
    description text,
    index_content text,
    public boolean,
    create_date timestamp ,
    write_date timestamp ,
    db_datas bytea,
    original_id INT,
    website_id INT,
    theme_template_id INT,
    key VARCHAR(255)
);



















































CREATE TABLE ir_attachment_sign_request_rel (
    sign_request_id INT NOT NULL,
    ir_attachment_id INT NOT NULL
);







CREATE TABLE ir_attachment_sign_send_request_rel (
    sign_send_request_id INT NOT NULL,
    ir_attachment_id INT NOT NULL
);







CREATE TABLE ir_attachment_social_post_rel (
    social_post_id INT NOT NULL,
    ir_attachment_id INT NOT NULL
);







CREATE TABLE ir_attachment_social_post_template_rel (
    social_post_template_id INT NOT NULL,
    ir_attachment_id INT NOT NULL
);







CREATE TABLE ir_config_parameter (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    key VARCHAR(255) NOT NULL,
    value text NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);

















CREATE TABLE ir_cron (
    id INT NOT NULL,
    ir_actions_server_id INT NOT NULL,
    user_id INT NOT NULL,
    interval_number INT,
    numbercall INT,
    priority INT,
    create_uid INT,
    write_uid INT,
    cron_name VARCHAR(255),
    interval_type VARCHAR(255),
    active boolean,
    doall boolean,
    nextcall timestamp  NOT NULL,
    lastcall timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT ir_cron_check_strictly_positive_interval CHECK ((interval_number > 0))
);














































CREATE TABLE ir_cron_trigger (
    id INT NOT NULL,
    cron_id INT,
    create_uid INT,
    write_uid INT,
    call_at timestamp ,
    create_date timestamp ,
    write_date timestamp 
);
















CREATE TABLE ir_default (
    id INT NOT NULL,
    field_id INT NOT NULL,
    user_id INT,
    company_id INT,
    create_uid INT,
    write_uid INT,
    condition VARCHAR(255),
    json_value VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);






























CREATE TABLE ir_demo (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);



















CREATE TABLE ir_demo_failure (
    id INT NOT NULL,
    module_id INT NOT NULL,
    wizard_id INT,
    create_uid INT,
    write_uid INT,
    error VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);



























CREATE TABLE ir_demo_failure_wizard (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);



















CREATE TABLE ir_exports (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    resource VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);
























CREATE TABLE ir_exports_line (
    id INT NOT NULL,
    export_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);





















CREATE TABLE ir_filters (
    id INT NOT NULL,
    user_id INT,
    action_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    model_id VARCHAR(255) NOT NULL,
    domain text NOT NULL,
    context text NOT NULL,
    sort text NOT NULL,
    is_default boolean,
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);











































CREATE TABLE ir_logging (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    dbname VARCHAR(255),
    level VARCHAR(255),
    path VARCHAR(255) NOT NULL,
    func VARCHAR(255) NOT NULL,
    line VARCHAR(255) NOT NULL,
    message text NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);












































CREATE TABLE ir_mail_server (
    id INT NOT NULL,
    smtp_port INT,
    sequence INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    from_filter VARCHAR(255),
    smtp_host VARCHAR(255),
    smtp_authentication VARCHAR(255) NOT NULL,
    smtp_user VARCHAR(255),
    smtp_pass VARCHAR(255),
    smtp_encryption VARCHAR(255) NOT NULL,
    smtp_debug boolean,
    active boolean,
    create_date timestamp ,
    write_date timestamp ,
    smtp_ssl_certificate bytea,
    smtp_ssl_private_key bytea,
    google_gmail_access_token_expiration INT,
    google_gmail_authorization_code VARCHAR(255),
    google_gmail_refresh_token VARCHAR(255),
    google_gmail_access_token VARCHAR(255)
);


































































CREATE TABLE ir_model (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    model VARCHAR(255) NOT NULL,
    "order" VARCHAR(255) NOT NULL,
    state VARCHAR(255),
    name json NOT NULL,
    info text,
    transient boolean,
    create_date timestamp ,
    write_date timestamp ,
    is_mail_thread boolean,
    is_mail_activity boolean,
    is_mail_blacklist boolean,
    website_form_default_field_id INT,
    website_form_label VARCHAR(255),
    website_form_key VARCHAR(255),
    website_form_access boolean
);


























































CREATE TABLE ir_model_access (
    id INT NOT NULL,
    model_id INT NOT NULL,
    group_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    active boolean,
    perm_read boolean,
    perm_write boolean,
    perm_create boolean,
    perm_unlink boolean,
    create_date timestamp ,
    write_date timestamp 
);







































CREATE TABLE ir_model_constraint (
    id INT NOT NULL,
    model INT NOT NULL,
    module INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    definition VARCHAR(255),
    type VARCHAR(255)(1) NOT NULL,
    message json,
    write_date timestamp ,
    create_date timestamp 
);






































CREATE TABLE ir_model_data (
    id INT NOT NULL,
    create_uid INT,
    create_date timestamp  DEFAULT (now() AT TIME ZONE UTC::text),
    write_date timestamp  DEFAULT (now() AT TIME ZONE UTC::text),
    write_uid INT,
    res_id INT,
    noupdate boolean DEFAULT false,
    name VARCHAR(255) NOT NULL,
    module VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    CONSTRAINT ir_model_data_name_nospaces CHECK (((name)::text !~~ %% %%::text))
);







CREATE TABLE ir_model_fields (
    id INT NOT NULL,
    relation_field_id INT,
    model_id INT NOT NULL,
    related_field_id INT,
    size INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    complete_name VARCHAR(255),
    model VARCHAR(255) NOT NULL,
    relation VARCHAR(255),
    relation_field VARCHAR(255),
    ttype VARCHAR(255) NOT NULL,
    related VARCHAR(255),
    state VARCHAR(255) NOT NULL,
    on_delete VARCHAR(255),
    domain VARCHAR(255),
    relation_table VARCHAR(255),
    column1 VARCHAR(255),
    column2 VARCHAR(255),
    depends VARCHAR(255),
    currency_field VARCHAR(255),
    field_description json NOT NULL,
    help json,
    compute text,
    copied boolean,
    required boolean,
    readonly boolean,
    index boolean,
    translate boolean,
    group_expand boolean,
    selectable boolean,
    store boolean,
    sanitize boolean,
    sanitize_overridable boolean,
    sanitize_tags boolean,
    sanitize_attributes boolean,
    sanitize_style boolean,
    sanitize_form boolean,
    strip_style boolean,
    strip_classes boolean,
    create_date timestamp ,
    write_date timestamp ,
    tracking INT,
    website_form_blacklisted boolean DEFAULT true,
    CONSTRAINT ir_model_fields_name_manual_field CHECK ((((state)::text <> manual::text) OR ((name)::text ~~ x\_%%::text))),
    CONSTRAINT ir_model_fields_size_gt_zero CHECK ((size >= 0))
);

















































































































































CREATE TABLE ir_model_fields_group_rel (
    field_id INT NOT NULL,
    group_id INT NOT NULL
);








CREATE TABLE ir_model_fields_selection (
    id INT NOT NULL,
    field_id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    value VARCHAR(255) NOT NULL,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);






















CREATE TABLE ir_model_inherit (
    id INT NOT NULL,
    model_id INT NOT NULL,
    parent_id INT NOT NULL,
    parent_field_id INT
);













CREATE TABLE ir_model_relation (
    id INT NOT NULL,
    model INT NOT NULL,
    module INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    write_date timestamp ,
    create_date timestamp 
);

























CREATE TABLE ir_module_category (
    id INT NOT NULL,
    create_uid INT,
    create_date timestamp ,
    write_date timestamp ,
    write_uid INT,
    parent_id INT,
    name json NOT NULL,
    sequence INT,
    description json,
    visible boolean,
    exclusive boolean
);












CREATE TABLE ir_module_module (
    id INT NOT NULL,
    create_uid INT,
    create_date timestamp ,
    write_date timestamp ,
    write_uid INT,
    website VARCHAR(255),
    summary json,
    name VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    icon VARCHAR(255),
    state VARCHAR(255)(16),
    latest_version VARCHAR(255),
    shortdesc json,
    category_id INT,
    description json,
    application boolean DEFAULT false,
    demo boolean DEFAULT false,
    web boolean DEFAULT false,
    license VARCHAR(255)(32),
    sequence INT DEFAULT 100,
    auto_install boolean DEFAULT false,
    to_buy boolean DEFAULT false,
    maintainer VARCHAR(255),
    published_version VARCHAR(255),
    url VARCHAR(255),
    contributors text,
    menus_by_module text,
    reports_by_module text,
    views_by_module text,
    module_type VARCHAR(255),
    imported boolean
);































CREATE TABLE ir_module_module_dependency (
    id INT NOT NULL,
    name VARCHAR(255),
    module_id INT,
    auto_install_required boolean DEFAULT true
);

CREATE TABLE ir_module_module_exclusion (
    id INT NOT NULL,
    module_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);


















CREATE TABLE ir_profile (
    id INT NOT NULL,
    sql_count INT,
    entry_count INT,
    session VARCHAR(255),
    name VARCHAR(255),
    init_stack_trace text,
    sql text,
    traces_async text,
    traces_sync text,
    qweb text,
    create_date timestamp ,
    duration double precision
);












































CREATE TABLE ir_property (
    id INT NOT NULL,
    company_id INT,
    fields_id INT NOT NULL,
    value_INT INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    res_id VARCHAR(255),
    value_reference VARCHAR(255),
    type VARCHAR(255) NOT NULL,
    value_text text,
    value_datetime timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    value_float double precision,
    value_binary bytea
);



















































CREATE TABLE ir_rule (
    id INT NOT NULL,
    model_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    domain_force text,
    active boolean,
    perm_read boolean,
    perm_write boolean,
    perm_create boolean,
    perm_unlink boolean,
    global boolean,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT ir_rule_no_access_rights CHECK (((perm_read <> false) OR (perm_write <> false) OR (perm_create <> false) OR (perm_unlink <> false)))
);









































CREATE TABLE ir_sequence (
    id INT NOT NULL,
    number_next INT NOT NULL,
    number_increment INT NOT NULL,
    padding INT NOT NULL,
    company_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(255),
    implementation VARCHAR(255) NOT NULL,
    prefix VARCHAR(255),
    suffix VARCHAR(255),
    active boolean,
    use_date_range boolean,
    create_date timestamp ,
    write_date timestamp 
);




















































CREATE TABLE ir_sequence_date_range (
    id INT NOT NULL,
    sequence_id INT NOT NULL,
    number_next INT NOT NULL,
    create_uid INT,
    write_uid INT,
    date_from date NOT NULL,
    date_to date NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);





























CREATE TABLE ir_ui_menu (
    id INT NOT NULL,
    sequence INT,
    parent_id INT,
    create_uid INT,
    write_uid INT,
    parent_path VARCHAR(255),
    web_icon VARCHAR(255),
    action VARCHAR(255),
    name json NOT NULL,
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);








































CREATE TABLE ir_ui_menu_group_rel (
    menu_id INT NOT NULL,
    gid INT NOT NULL
);









CREATE TABLE ir_ui_view (
    id INT NOT NULL,
    priority INT NOT NULL,
    inherit_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    model VARCHAR(255),
    key VARCHAR(255),
    type VARCHAR(255),
    arch_fs VARCHAR(255),
    mode VARCHAR(255) NOT NULL,
    arch_db json,
    arch_prev text,
    arch_updated boolean,
    active boolean,
    create_date timestamp ,
    write_date timestamp ,
    customize_show boolean,
    website_id INT,
    theme_template_id INT,
    website_meta_og_img VARCHAR(255),
    visibility VARCHAR(255),
    visibility_password VARCHAR(255),
    website_meta_title json,
    website_meta_description json,
    website_meta_keywords json,
    seo_name json,
    track boolean,
    CONSTRAINT ir_ui_view_inheritance_mode CHECK ((((mode)::text <> extension::text) OR (inherit_id IS NOT NULL))),
    CONSTRAINT ir_ui_view_qweb_required_key CHECK ((((type)::text <> qweb::text) OR (key IS NOT NULL)))
);



















































































CREATE TABLE ir_ui_view_custom (
    id INT NOT NULL,
    ref_id INT NOT NULL,
    user_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    arch text NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);

























CREATE TABLE ir_ui_view_group_rel (
    view_id INT NOT NULL,
    group_id INT NOT NULL
);






CREATE TABLE knowledge_article (
    id INT NOT NULL,
    cover_image_id INT,
    inherited_permission_parent_id INT,
    parent_id INT,
    sequence INT,
    root_article_id INT,
    stage_id INT,
    last_edition_uid INT,
    favorite_count INT,
    template_category_id INT,
    template_sequence INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    icon VARCHAR(255),
    internal_permission VARCHAR(255),
    inherited_permission VARCHAR(255),
    parent_path VARCHAR(255),
    category VARCHAR(255),
    html_field_history json,
    article_properties_definition json,
    article_properties json,
    template_body json,
    template_description json,
    template_name json,
    body text,
    active boolean,
    is_locked boolean,
    full_width boolean,
    is_desynchronized boolean,
    is_article_item boolean,
    is_article_visible_by_everyone boolean,
    to_delete boolean,
    is_template boolean,
    last_edition_date timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    cover_image_position double precision,
    is_published boolean,
    CONSTRAINT knowledge_article_check_article_item_parent CHECK (((is_article_item IS NOT TRUE) OR (parent_id IS NOT NULL))),
    CONSTRAINT knowledge_article_check_desync_on_root CHECK (((parent_id IS NOT NULL) OR (is_desynchronized IS NOT TRUE))),
    CONSTRAINT knowledge_article_check_permission_on_desync CHECK (((is_desynchronized IS NOT TRUE) OR (internal_permission IS NOT NULL))),
    CONSTRAINT knowledge_article_check_permission_on_root CHECK (((parent_id IS NOT NULL) OR (internal_permission IS NOT NULL))),
    CONSTRAINT knowledge_article_check_template_category_on_root CHECK (((is_template IS NOT TRUE) OR (parent_id IS NOT NULL) OR (template_category_id IS NOT NULL))),
    CONSTRAINT knowledge_article_check_template_name_required CHECK (((is_template IS NOT TRUE) OR (template_name IS NOT NULL))),
    CONSTRAINT knowledge_article_check_trash CHECK (((to_delete IS NOT TRUE) OR (active IS NOT TRUE)))
);














































































































































CREATE TABLE knowledge_article_favorite (
    id INT NOT NULL,
    article_id INT NOT NULL,
    user_id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    is_article_active boolean,
    create_date timestamp ,
    write_date timestamp 
);




























CREATE TABLE knowledge_article_member (
    id INT NOT NULL,
    article_id INT NOT NULL,
    partner_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    permission VARCHAR(255) NOT NULL,
    article_permission VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);




























CREATE TABLE knowledge_article_stage (
    id INT NOT NULL,
    sequence INT,
    parent_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    fold boolean,
    create_date timestamp ,
    write_date timestamp 
);

































CREATE TABLE knowledge_article_template_category (
    id INT NOT NULL,
    sequence INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);



















CREATE TABLE knowledge_article_thread (
    id INT NOT NULL,
    article_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    is_resolved boolean,
    create_date timestamp ,
    write_date timestamp 
);














CREATE TABLE knowledge_cover (
    id INT NOT NULL,
    attachment_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    attachment_url VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);


























CREATE TABLE knowledge_invite (
    id INT NOT NULL,
    article_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    permission VARCHAR(255) NOT NULL,
    message text,
    create_date timestamp ,
    write_date timestamp 
);



























CREATE TABLE knowledge_invite_res_partner_rel (
    knowledge_invite_id INT NOT NULL,
    res_partner_id INT NOT NULL
);







CREATE TABLE link_tracker (
    id INT NOT NULL,
    campaign_id INT,
    source_id INT,
    medium_id INT,
    count INT,
    create_uid INT,
    write_uid INT,
    url VARCHAR(255) NOT NULL,
    title VARCHAR(255),
    label VARCHAR(255),
    create_date timestamp ,
    write_date timestamp ,
    mass_mailing_id INT
);











































CREATE TABLE link_tracker_click (
    id INT NOT NULL,
    campaign_id INT,
    link_id INT NOT NULL,
    country_id INT,
    create_uid INT,
    write_uid INT,
    ip VARCHAR(255),
    create_date timestamp ,
    write_date timestamp ,
    mailing_trace_id INT,
    mass_mailing_id INT
);
































CREATE TABLE link_tracker_code (
    id INT NOT NULL,
    link_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    code VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);

















CREATE TABLE mail_activity (
    id INT NOT NULL,
    res_model_id INT NOT NULL,
    res_id INT,
    activity_type_id INT,
    user_id INT NOT NULL,
    request_partner_id INT,
    recommended_activity_type_id INT,
    previous_activity_type_id INT,
    create_uid INT,
    write_uid INT,
    res_model VARCHAR(255),
    res_name VARCHAR(255),
    summary VARCHAR(255),
    date_deadline date NOT NULL,
    date_done date,
    note text,
    automated boolean,
    active boolean,
    create_date timestamp ,
    write_date timestamp ,
    calendar_event_id INT,
    CONSTRAINT mail_activity_check_res_id_is_set CHECK (((res_id IS NOT NULL) AND (res_id <> 0)))
);


























































CREATE TABLE mail_activity_plan (
    id INT NOT NULL,
    company_id INT,
    res_model_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    res_model VARCHAR(255) NOT NULL,
    active boolean,
    create_date timestamp ,
    write_date timestamp ,
    department_id INT
);

































CREATE TABLE mail_activity_plan_mail_activity_schedule_rel (
    mail_activity_schedule_id INT NOT NULL,
    mail_activity_plan_id INT NOT NULL
);







CREATE TABLE mail_activity_plan_template (
    id INT NOT NULL,
    plan_id INT NOT NULL,
    sequence INT,
    activity_type_id INT NOT NULL,
    delay_count INT,
    responsible_id INT,
    create_uid INT,
    write_uid INT,
    delay_unit VARCHAR(255) NOT NULL,
    delay_from VARCHAR(255) NOT NULL,
    summary VARCHAR(255),
    responsible_type VARCHAR(255) NOT NULL,
    note text,
    create_date timestamp ,
    write_date timestamp 
);

















































CREATE TABLE mail_activity_rel (
    activity_id INT NOT NULL,
    recommended_id INT NOT NULL
);







CREATE TABLE mail_activity_schedule (
    id INT NOT NULL,
    res_model_id INT NOT NULL,
    plan_id INT,
    plan_on_demand_user_id INT,
    activity_type_id INT,
    activity_user_id INT,
    create_uid INT,
    write_uid INT,
    res_model VARCHAR(255) NOT NULL,
    summary VARCHAR(255),
    plan_date date,
    date_deadline date,
    res_ids text,
    note text,
    create_date timestamp ,
    write_date timestamp 
);













































CREATE TABLE mail_activity_todo_create (
    id INT NOT NULL,
    user_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    summary VARCHAR(255),
    date_deadline date NOT NULL,
    note text,
    create_date timestamp ,
    write_date timestamp 
);



































CREATE TABLE mail_activity_type (
    id INT NOT NULL,
    sequence INT,
    create_uid INT,
    delay_count INT,
    triggered_next_type_id INT,
    default_user_id INT,
    write_uid INT,
    delay_unit VARCHAR(255) NOT NULL,
    delay_from VARCHAR(255) NOT NULL,
    icon VARCHAR(255),
    decoration_type VARCHAR(255),
    res_model VARCHAR(255),
    chaining_type VARCHAR(255) NOT NULL,
    category VARCHAR(255),
    name json NOT NULL,
    summary json,
    default_note json,
    active boolean,
    keep_done boolean,
    create_date timestamp ,
    write_date timestamp ,
    dashboard_visibility VARCHAR(255)
);































































CREATE TABLE mail_activity_type_mail_template_rel (
    mail_activity_type_id INT NOT NULL,
    mail_template_id INT NOT NULL
);







CREATE TABLE mail_alias (
    id INT NOT NULL,
    alias_domain_id INT,
    alias_model_id INT NOT NULL,
    alias_force_thread_id INT,
    alias_parent_model_id INT,
    alias_parent_thread_id INT,
    create_uid INT,
    write_uid INT,
    alias_name VARCHAR(255),
    alias_full_name VARCHAR(255),
    alias_contact VARCHAR(255) NOT NULL,
    alias_status VARCHAR(255),
    alias_bounced_content json,
    alias_defaults text NOT NULL,
    alias_incoming_local boolean,
    create_date timestamp ,
    write_date timestamp 
);























































CREATE TABLE mail_alias_domain (
    id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    bounce_alias VARCHAR(255) NOT NULL,
    catchall_alias VARCHAR(255) NOT NULL,
    default_from VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);





































CREATE TABLE mail_blacklist (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    email VARCHAR(255) NOT NULL,
    active boolean,
    create_date timestamp ,
    write_date timestamp ,
    opt_out_reason_id INT
);






























CREATE TABLE mail_blacklist_remove (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    email VARCHAR(255) NOT NULL,
    reason VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);





















CREATE TABLE mail_canned_response (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    source VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    substitution text NOT NULL,
    is_shared boolean,
    last_used timestamp ,
    create_date timestamp ,
    write_date timestamp 
);



































CREATE TABLE mail_canned_response_res_groups_rel (
    mail_canned_response_id INT NOT NULL,
    res_groups_id INT NOT NULL
);







CREATE TABLE mail_compose_message (
    id INT NOT NULL,
    template_id INT,
    parent_id INT,
    author_id INT,
    res_domain_user_id INT,
    record_alias_domain_id INT,
    record_company_id INT,
    subtype_id INT,
    mail_activity_type_id INT,
    mail_server_id INT,
    create_uid INT,
    write_uid INT,
    lang VARCHAR(255),
    subject VARCHAR(255),
    email_layout_xmlid VARCHAR(255),
    email_from VARCHAR(255),
    composition_mode VARCHAR(255),
    model VARCHAR(255),
    record_name VARCHAR(255),
    message_type VARCHAR(255) NOT NULL,
    reply_to VARCHAR(255),
    scheduled_date VARCHAR(255),
    body text,
    res_ids text,
    res_domain text,
    email_add_signature boolean,
    reply_to_force_new boolean,
    auto_delete boolean,
    auto_delete_keep_log boolean,
    force_send boolean,
    use_exclusion_list boolean,
    create_date timestamp ,
    write_date timestamp ,
    mass_mailing_id INT,
    campaign_id INT,
    mass_mailing_name VARCHAR(255),
    marketing_activity_id INT
);
















































































































CREATE TABLE mail_compose_message_ir_attachments_rel (
    wizard_id INT NOT NULL,
    attachment_id INT NOT NULL
);







CREATE TABLE mail_compose_message_mailing_list_rel (
    mail_compose_message_id INT NOT NULL,
    mailing_list_id INT NOT NULL
);







CREATE TABLE mail_compose_message_res_partner_rel (
    wizard_id INT NOT NULL,
    partner_id INT NOT NULL
);







CREATE TABLE mail_followers (
    id INT NOT NULL,
    res_id INT,
    partner_id INT NOT NULL,
    res_model VARCHAR(255) NOT NULL
);








CREATE TABLE mail_followers_mail_message_subtype_rel (
    mail_followers_id INT NOT NULL,
    mail_message_subtype_id INT NOT NULL
);







CREATE TABLE mail_gateway_allowed (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    email VARCHAR(255) NOT NULL,
    email_normalized VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);
























CREATE TABLE mail_guest (
    id INT NOT NULL,
    country_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    access_token VARCHAR(255) NOT NULL,
    lang VARCHAR(255),
    timezone VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);

































CREATE TABLE mail_ice_server (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    server_type VARCHAR(255) NOT NULL,
    uri VARCHAR(255) NOT NULL,
    username VARCHAR(255),
    credential VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);

































CREATE TABLE mail_link_preview (
    id INT NOT NULL,
    message_id INT,
    create_uid INT,
    write_uid INT,
    source_url VARCHAR(255) NOT NULL,
    og_type VARCHAR(255),
    og_title VARCHAR(255),
    og_site_name VARCHAR(255),
    og_image VARCHAR(255),
    og_mimetype VARCHAR(255),
    image_mimetype VARCHAR(255),
    og_description text,
    is_hidden boolean,
    create_date timestamp ,
    write_date timestamp 
);

















































CREATE TABLE mail_mail (
    id INT NOT NULL,
    mail_message_id INT NOT NULL,
    fetchmail_server_id INT,
    create_uid INT,
    write_uid INT,
    email_cc VARCHAR(255),
    state VARCHAR(255),
    failure_type VARCHAR(255),
    body_html text,
    "references" text,
    headers text,
    email_to text,
    failure_reason text,
    is_notification boolean,
    auto_delete boolean,
    scheduled_date timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    mailing_id INT
);

























































CREATE TABLE mail_mail_res_partner_rel (
    mail_mail_id INT NOT NULL,
    res_partner_id INT NOT NULL
);







CREATE TABLE mail_mass_mailing_list_rel (
    mailing_list_id INT NOT NULL,
    mailing_mailing_id INT NOT NULL
);







CREATE TABLE mail_message (
    id INT NOT NULL,
    parent_id INT,
    res_id INT,
    record_alias_domain_id INT,
    record_company_id INT,
    subtype_id INT,
    mail_activity_type_id INT,
    author_id INT,
    author_guest_id INT,
    mail_server_id INT,
    create_uid INT,
    write_uid INT,
    subject VARCHAR(255),
    model VARCHAR(255),
    record_name VARCHAR(255),
    message_type VARCHAR(255) NOT NULL,
    email_from VARCHAR(255),
    message_id VARCHAR(255),
    reply_to VARCHAR(255),
    email_layout_xmlid VARCHAR(255),
    body text,
    is_internal boolean,
    reply_to_force_new boolean,
    email_add_signature boolean,
    date timestamp ,
    pinned_at timestamp ,
    create_date timestamp ,
    write_date timestamp 
);





















































































CREATE TABLE mail_message_reaction (
    id INT NOT NULL,
    message_id INT NOT NULL,
    partner_id INT,
    guest_id INT,
    content VARCHAR(255) NOT NULL,
    CONSTRAINT mail_message_reaction_partner_or_guest_exists CHECK ((((partner_id IS NOT NULL) AND (guest_id IS NULL)) OR ((partner_id IS NULL) AND (guest_id IS NOT NULL))))
);





















CREATE TABLE mail_message_res_partner_rel (
    mail_message_id INT NOT NULL,
    res_partner_id INT NOT NULL
);







CREATE TABLE mail_message_res_partner_starred_rel (
    mail_message_id INT NOT NULL,
    res_partner_id INT NOT NULL
);







CREATE TABLE mail_message_schedule (
    id INT NOT NULL,
    mail_message_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    notification_parameters text,
    scheduled_datetime timestamp  NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);































CREATE TABLE mail_message_subtype (
    id INT NOT NULL,
    parent_id INT,
    sequence INT,
    create_uid INT,
    write_uid INT,
    relation_field VARCHAR(255),
    res_model VARCHAR(255),
    name json NOT NULL,
    description json,
    internal boolean,
    "default" boolean,
    hidden boolean,
    track_recipients boolean,
    create_date timestamp ,
    write_date timestamp 
);














































CREATE TABLE mail_message_translation (
    id INT NOT NULL,
    message_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    source_lang VARCHAR(255) NOT NULL,
    target_lang VARCHAR(255) NOT NULL,
    body text NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);























CREATE TABLE mail_notification (
    id INT NOT NULL,
    author_id INT,
    mail_message_id INT NOT NULL,
    mail_mail_id INT,
    res_partner_id INT,
    notification_type VARCHAR(255) NOT NULL,
    notification_status VARCHAR(255),
    failure_type VARCHAR(255),
    failure_reason text,
    is_read boolean,
    read_date timestamp ,
    sms_id_int INT,
    sms_number VARCHAR(255),
    letter_id INT,
    CONSTRAINT mail_notification_notification_partner_required CHECK ((((notification_type)::text <> ALL ((ARRAY[email::VARCHAR(255), inbox::VARCHAR(255)])::text[])) OR (res_partner_id IS NOT NULL)))
);










































CREATE TABLE mail_notification_mail_resend_message_rel (
    mail_resend_message_id INT NOT NULL,
    mail_notification_id INT NOT NULL
);







CREATE TABLE mail_push (
    id INT NOT NULL,
    mail_push_device_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    payload text,
    create_date timestamp ,
    write_date timestamp 
);

























CREATE TABLE mail_push_device (
    id INT NOT NULL,
    partner_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    endpoint VARCHAR(255) NOT NULL,
    keys VARCHAR(255) NOT NULL,
    expiration_time timestamp ,
    create_date timestamp ,
    write_date timestamp 
);





























CREATE TABLE mail_resend_message (
    id INT NOT NULL,
    mail_message_id INT,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);






















CREATE TABLE mail_resend_partner (
    id INT NOT NULL,
    notification_id INT NOT NULL,
    resend_wizard_id INT,
    create_uid INT,
    write_uid INT,
    message VARCHAR(255),
    resend boolean,
    create_date timestamp ,
    write_date timestamp 
);





















CREATE TABLE mail_template (
    id INT NOT NULL,
    model_id INT,
    user_id INT,
    mail_server_id INT,
    ref_ir_act_window INT,
    create_uid INT,
    write_uid INT,
    template_fs VARCHAR(255),
    lang VARCHAR(255),
    model VARCHAR(255),
    email_from VARCHAR(255),
    email_to VARCHAR(255),
    partner_to VARCHAR(255),
    email_cc VARCHAR(255),
    reply_to VARCHAR(255),
    email_layout_xmlid VARCHAR(255),
    scheduled_date VARCHAR(255),
    name json,
    description json,
    subject json,
    body_html json,
    active boolean,
    use_default_to boolean,
    auto_delete boolean,
    create_date timestamp ,
    write_date timestamp 
);



































































CREATE TABLE mail_template_ir_actions_report_rel (
    mail_template_id INT NOT NULL,
    ir_actions_report_id INT NOT NULL
);







CREATE TABLE mail_template_mail_template_reset_rel (
    mail_template_reset_id INT NOT NULL,
    mail_template_id INT NOT NULL
);







CREATE TABLE mail_template_preview (
    id INT NOT NULL,
    mail_template_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    resource_ref VARCHAR(255),
    lang VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);



















CREATE TABLE mail_template_reset (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);






















CREATE TABLE mail_tracking_value (
    id INT NOT NULL,
    field_id INT,
    old_value_INT INT,
    new_value_INT INT,
    currency_id INT,
    mail_message_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    old_value_char VARCHAR(255),
    new_value_char VARCHAR(255),
    field_info json,
    old_value_text text,
    new_value_text text,
    old_value_datetime timestamp ,
    new_value_datetime timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    old_value_float double precision,
    new_value_float double precision
);

















CREATE TABLE mail_wizard_invite (
    id INT NOT NULL,
    res_id INT,
    create_uid INT,
    write_uid INT,
    res_model VARCHAR(255) NOT NULL,
    message text,
    notify boolean,
    create_date timestamp ,
    write_date timestamp 
);



















CREATE TABLE mail_wizard_invite_res_partner_rel (
    mail_wizard_invite_id INT NOT NULL,
    res_partner_id INT NOT NULL
);







CREATE TABLE mailing_contact (
    id INT NOT NULL,
    message_bounce INT,
    title_id INT,
    country_id INT,
    create_uid INT,
    write_uid INT,
    email_normalized VARCHAR(255),
    name VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    company_name VARCHAR(255),
    email VARCHAR(255),
    create_date timestamp ,
    write_date timestamp ,
    phone_sanitized VARCHAR(255),
    mobile VARCHAR(255)
);

























































CREATE TABLE mailing_contact_import (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    contact_list text,
    create_date timestamp ,
    write_date timestamp 
);











CREATE TABLE mailing_contact_import_mailing_list_rel (
    mailing_contact_import_id INT NOT NULL,
    mailing_list_id INT NOT NULL
);







CREATE TABLE mailing_contact_mailing_contact_to_list_rel (
    mailing_contact_to_list_id INT NOT NULL,
    mailing_contact_id INT NOT NULL
);







CREATE TABLE mailing_contact_res_partner_category_rel (
    mailing_contact_id INT NOT NULL,
    res_partner_category_id INT NOT NULL
);







CREATE TABLE mailing_contact_to_list (
    id INT NOT NULL,
    mailing_list_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);























CREATE TABLE mailing_filter (
    id INT NOT NULL,
    create_uid INT,
    mailing_model_id INT NOT NULL,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    mailing_domain VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);
































CREATE TABLE mailing_list (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    active boolean,
    is_public boolean,
    create_date timestamp ,
    write_date timestamp 
);




























CREATE TABLE mailing_list_mailing_list_merge_rel (
    mailing_list_merge_id INT NOT NULL,
    mailing_list_id INT NOT NULL
);







CREATE TABLE mailing_list_merge (
    id INT NOT NULL,
    dest_list_id INT,
    create_uid INT,
    write_uid INT,
    merge_options VARCHAR(255) NOT NULL,
    new_list_name VARCHAR(255),
    archive_src_lists boolean,
    create_date timestamp ,
    write_date timestamp 
);

































CREATE TABLE mailing_mailing (
    id INT NOT NULL,
    source_id INT NOT NULL,
    campaign_id INT,
    medium_id INT,
    color INT,
    user_id INT,
    mailing_model_id INT NOT NULL,
    mail_server_id INT,
    mailing_filter_id INT,
    ab_testing_pc INT,
    create_uid INT,
    write_uid INT,
    lang VARCHAR(255),
    subject VARCHAR(255) NOT NULL,
    preview VARCHAR(255),
    email_from VARCHAR(255) NOT NULL,
    schedule_type VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    mailing_type VARCHAR(255) NOT NULL,
    reply_to_mode VARCHAR(255),
    reply_to VARCHAR(255),
    mailing_domain VARCHAR(255),
    body_arch text,
    body_html text,
    active boolean,
    favorite boolean,
    keep_archives boolean,
    ab_testing_enabled boolean,
    kpi_mail_required boolean,
    favorite_date timestamp ,
    sent_date timestamp ,
    schedule_date timestamp ,
    calendar_date timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    use_in_marketing_automation boolean,
    sms_template_id INT,
    body_plaintext text,
    sms_force_send boolean,
    sms_allow_unsubscribe boolean,
    CONSTRAINT mailing_mailing_percentage_valid CHECK (((ab_testing_pc >= 0) AND (ab_testing_pc <= 100)))
);






























































































































CREATE TABLE mailing_mailing_schedule_date (
    id INT NOT NULL,
    mass_mailing_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    schedule_date timestamp ,
    create_date timestamp ,
    write_date timestamp 
);






















CREATE TABLE mailing_mailing_test (
    id INT NOT NULL,
    mass_mailing_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    email_to text NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);
























CREATE TABLE mailing_sms_test (
    id INT NOT NULL,
    mailing_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    numbers text NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);




















CREATE TABLE mailing_subscription (
    id INT NOT NULL,
    contact_id INT NOT NULL,
    list_id INT NOT NULL,
    opt_out_reason_id INT,
    create_uid INT,
    write_uid INT,
    opt_out boolean,
    opt_out_datetime timestamp ,
    create_date timestamp ,
    write_date timestamp 
);


































CREATE TABLE mailing_subscription_optout (
    id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    name json,
    is_feedback boolean,
    create_date timestamp ,
    write_date timestamp 
);






















CREATE TABLE mailing_trace (
    id INT NOT NULL,
    mail_mail_id INT,
    mail_mail_id_int INT,
    res_id INT,
    mass_mailing_id INT,
    campaign_id INT,
    create_uid INT,
    write_uid INT,
    trace_type VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    message_id VARCHAR(255),
    model VARCHAR(255) NOT NULL,
    trace_status VARCHAR(255),
    failure_type VARCHAR(255),
    failure_reason text,
    sent_datetime timestamp ,
    open_datetime timestamp ,
    reply_datetime timestamp ,
    links_click_datetime timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    marketing_trace_id INT,
    sms_id_int INT,
    sms_number VARCHAR(255),
    sms_code VARCHAR(255),
    CONSTRAINT mailing_trace_check_res_id_is_set CHECK (((res_id IS NOT NULL) AND (res_id <> 0)))
);













































































CREATE TABLE utm_campaign (
    id INT NOT NULL,
    user_id INT NOT NULL,
    stage_id INT NOT NULL,
    color INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    title json NOT NULL,
    active boolean,
    is_auto_campaign boolean,
    create_date timestamp ,
    write_date timestamp ,
    ab_testing_winner_mailing_id INT,
    ab_testing_winner_selection VARCHAR(255),
    ab_testing_completed boolean,
    ab_testing_schedule_datetime timestamp ,
    ab_testing_sms_winner_selection VARCHAR(255)
);























































CREATE TABLE utm_source (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);






















CREATE VIEW mailing_trace_report AS
 SELECT min(trace.id) AS id,
    utm_source.name,
    mailing.mailing_type,
    utm_campaign.name AS campaign,
    trace.create_date AS scheduled_date,
    mailing.state,
    mailing.email_from,
    count(trace.id) AS scheduled,
    count(trace.sent_datetime) AS sent,
    (count(trace.id) - count(trace.trace_status) FILTER (WHERE ((trace.trace_status)::text = ANY ((ARRAY[outgoing::VARCHAR(255), pending::VARCHAR(255), process::VARCHAR(255), error::VARCHAR(255), bounce::VARCHAR(255), cancel::VARCHAR(255)])::text[])))) AS delivered,
    count(trace.trace_status) FILTER (WHERE ((trace.trace_status)::text = process::text)) AS processing,
    count(trace.trace_status) FILTER (WHERE ((trace.trace_status)::text = pending::text)) AS pending,
    count(trace.trace_status) FILTER (WHERE ((trace.trace_status)::text = error::text)) AS error,
    count(trace.trace_status) FILTER (WHERE ((trace.trace_status)::text = bounce::text)) AS bounced,
    count(trace.trace_status) FILTER (WHERE ((trace.trace_status)::text = cancel::text)) AS canceled,
    count(trace.trace_status) FILTER (WHERE ((trace.trace_status)::text = open::text)) AS opened,
    count(trace.trace_status) FILTER (WHERE ((trace.trace_status)::text = reply::text)) AS replied,
    count(trace.links_click_datetime) AS clicked
   FROM (((mailing_trace trace
     LEFT JOIN mailing_mailing mailing ON ((trace.mass_mailing_id = mailing.id)))
     LEFT JOIN utm_campaign utm_campaign ON ((mailing.campaign_id = utm_campaign.id)))
     LEFT JOIN utm_source utm_source ON ((mailing.source_id = utm_source.id)))
  WHERE (mailing.use_in_marketing_automation IS NOT TRUE)
  GROUP BY trace.create_date, utm_source.name, utm_campaign.name, mailing.mailing_type, mailing.state, mailing.email_from;




CREATE TABLE marketing_activity (
    id INT NOT NULL,
    source_id INT NOT NULL,
    mass_mailing_id INT,
    server_action_id INT,
    campaign_id INT NOT NULL,
    interval_number INT,
    interval_standardized INT,
    validity_duration_number INT,
    parent_id INT,
    create_uid INT,
    write_uid INT,
    activity_type VARCHAR(255) NOT NULL,
    mass_mailing_id_mailing_type VARCHAR(255),
    interval_type VARCHAR(255) NOT NULL,
    validity_duration_type VARCHAR(255) NOT NULL,
    domain VARCHAR(255),
    activity_domain VARCHAR(255),
    trigger_type VARCHAR(255) NOT NULL,
    validity_duration boolean,
    require_sync boolean,
    create_date timestamp ,
    write_date timestamp 
);











































































CREATE TABLE marketing_campaign (
    id INT NOT NULL,
    utm_campaign_id INT NOT NULL,
    model_id INT NOT NULL,
    unique_field_id INT,
    mailing_filter_id INT,
    create_uid INT,
    write_uid INT,
    state VARCHAR(255),
    model_name VARCHAR(255),
    domain VARCHAR(255),
    active boolean,
    last_sync_date timestamp ,
    create_date timestamp ,
    write_date timestamp 
);


































CREATE TABLE marketing_campaign_test (
    id INT NOT NULL,
    campaign_id INT NOT NULL,
    res_id INT,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);
























CREATE TABLE marketing_participant (
    id INT NOT NULL,
    campaign_id INT NOT NULL,
    model_id INT,
    res_id INT,
    create_uid INT,
    write_uid INT,
    model_name VARCHAR(255),
    state VARCHAR(255) NOT NULL,
    is_test boolean,
    create_date timestamp ,
    write_date timestamp 
);





































CREATE TABLE marketing_trace (
    id INT NOT NULL,
    participant_id INT NOT NULL,
    res_id INT,
    activity_id INT NOT NULL,
    parent_id INT,
    create_uid INT,
    write_uid INT,
    state VARCHAR(255) NOT NULL,
    state_msg VARCHAR(255),
    is_test boolean,
    schedule_date timestamp ,
    create_date timestamp ,
    write_date timestamp 
);












































CREATE TABLE mass_mailing_ir_attachments_rel (
    mass_mailing_id INT NOT NULL,
    attachment_id INT NOT NULL
);







CREATE TABLE meeting_category_rel (
    event_id INT NOT NULL,
    type_id INT NOT NULL
);







CREATE TABLE message_attachment_rel (
    message_id INT NOT NULL,
    attachment_id INT NOT NULL
);







CREATE TABLE module_country (
    module_id INT NOT NULL,
    country_id INT NOT NULL
);







CREATE TABLE phone_blacklist (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    number VARCHAR(255) NOT NULL,
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);






















CREATE TABLE phone_blacklist_remove (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    phone VARCHAR(255) NOT NULL,
    reason VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);




















CREATE VIEW planning_analysis_report AS
SELECT
    NULL::INT AS id,
    NULL::INT AS slot_id,
    NULL::double precision AS allocated_hours,
    NULL::double precision AS allocated_percentage,
    NULL::INT AS company_id,
    NULL::INT AS department_id,
    NULL::INT AS employee_id,
    NULL::timestamp  AS end_datetime,
    NULL::VARCHAR(255) AS job_title,
    NULL::INT AS manager_id,
    NULL::text AS name,
    NULL::boolean AS publication_warning,
    NULL::boolean AS request_to_switch,
    NULL::INT AS resource_id,
    NULL::VARCHAR(255) AS resource_type,
    NULL::INT AS role_id,
    NULL::INT AS recurrency_id,
    NULL::timestamp  AS start_datetime,
    NULL::VARCHAR(255) AS state,
    NULL::INT AS user_id,
    NULL::double precision AS working_days_count;




CREATE TABLE planning_planning (
    id INT NOT NULL,
    company_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    access_token VARCHAR(255) NOT NULL,
    include_unassigned boolean,
    start_datetime timestamp  NOT NULL,
    end_datetime timestamp  NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);





































CREATE TABLE planning_recurrency (
    id INT NOT NULL,
    repeat_interval INT NOT NULL,
    repeat_number INT,
    company_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    repeat_unit VARCHAR(255) NOT NULL,
    repeat_type VARCHAR(255),
    repeat_until timestamp ,
    last_generated_end_datetime timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT planning_recurrency_check_repeat_interval_positive CHECK ((repeat_interval >= 1)),
    CONSTRAINT planning_recurrency_check_until_limit CHECK (((((repeat_type)::text = until::text) AND (repeat_until IS NOT NULL)) OR ((repeat_type)::text <> until::text)))
);















































CREATE TABLE planning_role (
    id INT NOT NULL,
    color INT,
    sequence INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    slot_properties_definition json,
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);




























CREATE TABLE planning_send (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    note text,
    include_unassigned boolean,
    start_datetime timestamp  NOT NULL,
    end_datetime timestamp  NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);




























CREATE TABLE planning_send_planning_slot_rel (
    planning_send_id INT NOT NULL,
    planning_slot_id INT NOT NULL
);







CREATE TABLE planning_slot (
    id INT NOT NULL,
    resource_id INT,
    employee_id INT,
    department_id INT,
    user_id INT,
    manager_id INT,
    company_id INT NOT NULL,
    role_id INT,
    template_id INT,
    previous_template_id INT,
    recurrency_id INT,
    create_uid INT,
    write_uid INT,
    access_token VARCHAR(255) NOT NULL,
    state VARCHAR(255),
    slot_properties json,
    name text,
    was_copied boolean,
    request_to_switch boolean,
    publication_warning boolean,
    template_reset boolean,
    start_datetime timestamp  NOT NULL,
    end_datetime timestamp  NOT NULL,
    create_date timestamp ,
    write_date timestamp ,
    allocated_hours double precision,
    allocated_percentage double precision,
    working_days_count double precision,
    CONSTRAINT planning_slot_check_allocated_hours_positive CHECK ((allocated_hours >= (0)::double precision)),
    CONSTRAINT planning_slot_check_start_date_lower_end_date CHECK ((end_datetime > start_datetime))
);
















































CREATE TABLE planning_slot_template (
    id INT NOT NULL,
    sequence INT,
    role_id INT,
    create_uid INT,
    write_uid INT,
    active boolean,
    create_date timestamp ,
    write_date timestamp ,
    start_time double precision,
    duration double precision,
    CONSTRAINT planning_slot_template_check_duration_positive CHECK ((duration >= (0)::double precision)),
    CONSTRAINT planning_slot_template_check_start_time_lower_than_24 CHECK ((start_time < (24)::double precision)),
    CONSTRAINT planning_slot_template_check_start_time_positive CHECK ((start_time >= (0)::double precision))
);





















CREATE TABLE portal_share (
    id INT NOT NULL,
    res_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    res_model VARCHAR(255) NOT NULL,
    note text,
    create_date timestamp ,
    write_date timestamp 
);



















CREATE TABLE portal_share_res_partner_rel (
    portal_share_id INT NOT NULL,
    res_partner_id INT NOT NULL
);







CREATE TABLE portal_wizard (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    welcome_message text,
    create_date timestamp ,
    write_date timestamp 
);















CREATE TABLE portal_wizard_res_partner_rel (
    portal_wizard_id INT NOT NULL,
    res_partner_id INT NOT NULL
);







CREATE TABLE portal_wizard_user (
    id INT NOT NULL,
    wizard_id INT NOT NULL,
    partner_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    email VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);


























CREATE TABLE privacy_log (
    id INT NOT NULL,
    user_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    anonymized_name VARCHAR(255) NOT NULL,
    anonymized_email VARCHAR(255) NOT NULL,
    execution_details text,
    records_description text,
    additional_note text,
    date timestamp  NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);













CREATE TABLE privacy_lookup_wizard (
    id INT NOT NULL,
    log_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    execution_details text,
    create_date timestamp ,
    write_date timestamp 
);


















CREATE TABLE privacy_lookup_wizard_line (
    id INT NOT NULL,
    wizard_id INT,
    res_id INT NOT NULL,
    res_model_id INT,
    create_uid INT,
    write_uid INT,
    res_name VARCHAR(255),
    res_model VARCHAR(255),
    execution_details VARCHAR(255),
    has_active boolean,
    is_active boolean,
    is_unlinked boolean,
    create_date timestamp ,
    write_date timestamp 
);


























CREATE TABLE project_collaborator (
    id INT NOT NULL,
    project_id INT NOT NULL,
    partner_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);




















CREATE TABLE project_favorite_user_rel (
    project_id INT NOT NULL,
    user_id INT NOT NULL
);







CREATE TABLE project_milestone (
    id INT NOT NULL,
    project_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    deadline date,
    reached_date date,
    is_reached boolean,
    create_date timestamp ,
    write_date timestamp 
);


































CREATE TABLE project_project (
    id INT NOT NULL,
    alias_id INT NOT NULL,
    sequence INT,
    partner_id INT,
    company_id INT,
    analytic_account_id INT,
    color INT,
    user_id INT,
    stage_id INT,
    last_update_id INT,
    create_uid INT,
    write_uid INT,
    access_token VARCHAR(255),
    privacy_visibility VARCHAR(255) NOT NULL,
    rating_status VARCHAR(255) NOT NULL,
    rating_status_period VARCHAR(255) NOT NULL,
    last_update_status VARCHAR(255) NOT NULL,
    date_start date,
    date date,
    name json NOT NULL,
    label_tasks json,
    task_properties_definition json,
    description text,
    active boolean,
    allow_task_dependencies boolean,
    allow_milestones boolean,
    rating_active boolean,
    rating_request_deadline timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT project_project_project_date_greater CHECK ((date >= date_start))
);










CREATE TABLE project_project_project_tags_rel (
    project_project_id INT NOT NULL,
    project_tags_id INT NOT NULL
);







CREATE TABLE project_project_project_task_type_delete_wizard_rel (
    project_task_type_delete_wizard_id INT NOT NULL,
    project_project_id INT NOT NULL
);







CREATE TABLE project_project_stage (
    id INT NOT NULL,
    sequence INT,
    mail_template_id INT,
    company_id INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    active boolean,
    fold boolean,
    create_date timestamp ,
    write_date timestamp ,
    sms_template_id INT
);








































CREATE TABLE project_project_stage_delete_wizard (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);
























CREATE TABLE project_project_stage_project_project_stage_delete_wizard_rel (
    project_project_stage_delete_wizard_id INT NOT NULL,
    project_project_stage_id INT NOT NULL
);







CREATE TABLE project_share_wizard (
    id INT NOT NULL,
    res_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    res_model VARCHAR(255) NOT NULL,
    access_mode VARCHAR(255),
    note text,
    send_email boolean,
    create_date timestamp ,
    write_date timestamp 
);






























CREATE TABLE project_share_wizard_res_partner_rel (
    project_share_wizard_id INT NOT NULL,
    res_partner_id INT NOT NULL
);







CREATE TABLE project_tags (
    id INT NOT NULL,
    color INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);












CREATE TABLE project_tags_project_task_rel (
    project_task_id INT NOT NULL,
    project_tags_id INT NOT NULL
);







CREATE TABLE project_task (
    id INT NOT NULL,
    sequence INT,
    stage_id INT,
    project_id INT,
    partner_id INT,
    company_id INT,
    color INT,
    displayed_image_id INT,
    parent_id INT,
    milestone_id INT,
    recurrence_id INT,
    analytic_account_id INT,
    create_uid INT,
    write_uid INT,
    email_cc VARCHAR(255),
    access_token VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    priority VARCHAR(255),
    state VARCHAR(255) NOT NULL,
    html_field_history json,
    task_properties json,
    description text,
    working_hours_open numeric,
    working_hours_close numeric,
    active boolean,
    display_in_project boolean,
    recurring_task boolean,
    create_date timestamp ,
    write_date timestamp ,
    date_end timestamp ,
    date_assign timestamp ,
    date_deadline timestamp ,
    date_last_stage_update timestamp ,
    rating_last_value double precision,
    allocated_hours double precision,
    working_days_open double precision,
    working_days_close double precision,
    planned_date_begin timestamp ,
    CONSTRAINT project_task_planned_dates_check CHECK ((planned_date_begin <= date_deadline)),
    CONSTRAINT project_task_private_task_has_no_parent CHECK ((NOT ((project_id IS NULL) AND (parent_id IS NOT NULL)))),
    CONSTRAINT project_task_recurring_task_has_no_parent CHECK ((NOT ((recurring_task IS TRUE) AND (parent_id IS NOT NULL))))
);






CREATE TABLE project_task_recurrence (
    id INT NOT NULL,
    repeat_interval INT,
    create_uid INT,
    write_uid INT,
    repeat_unit VARCHAR(255),
    repeat_type VARCHAR(255),
    repeat_until date,
    create_date timestamp ,
    write_date timestamp 
);

























CREATE TABLE project_task_type (
    id INT NOT NULL,
    sequence INT,
    mail_template_id INT,
    rating_template_id INT,
    user_id INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    active boolean,
    fold boolean,
    auto_validation_state boolean,
    create_date timestamp ,
    write_date timestamp ,
    sms_template_id INT
);














































CREATE TABLE project_task_type_delete_wizard (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);

















CREATE TABLE project_task_type_project_task_type_delete_wizard_rel (
    project_task_type_delete_wizard_id INT NOT NULL,
    project_task_type_id INT NOT NULL
);







CREATE TABLE project_task_type_rel (
    project_id INT NOT NULL,
    type_id INT NOT NULL
);







CREATE TABLE project_task_user_rel (
    id INT NOT NULL,
    task_id INT NOT NULL,
    user_id INT NOT NULL,
    stage_id INT,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);




























CREATE TABLE project_update (
    id INT NOT NULL,
    progress INT,
    user_id INT NOT NULL,
    project_id INT NOT NULL,
    task_count INT,
    closed_task_count INT,
    create_uid INT,
    write_uid INT,
    email_cc VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    date date,
    description text,
    create_date timestamp ,
    write_date timestamp 
);

































CREATE TABLE rating_rating (
    id INT NOT NULL,
    res_model_id INT,
    res_id INT NOT NULL,
    parent_res_model_id INT,
    parent_res_id INT,
    rated_partner_id INT,
    partner_id INT,
    message_id INT,
    create_uid INT,
    write_uid INT,
    res_name VARCHAR(255),
    res_model VARCHAR(255),
    parent_res_name VARCHAR(255),
    parent_res_model VARCHAR(255),
    rating_text VARCHAR(255),
    access_token VARCHAR(255),
    feedback text,
    is_internal boolean,
    consumed boolean,
    create_date timestamp ,
    write_date timestamp ,
    rating double precision,
    publisher_id INT,
    publisher_comment text,
    publisher_datetime timestamp ,
    CONSTRAINT rating_rating_rating_range CHECK (((rating >= (0)::double precision) AND (rating <= (5)::double precision)))
);

CREATE TABLE rel_badge_auth_users (
    gamification_badge_id INT NOT NULL,
    res_users_id INT NOT NULL
);







CREATE TABLE rel_modules_langexport (
    wiz_id INT NOT NULL,
    module_id INT NOT NULL
);







CREATE TABLE rel_server_actions (
    server_id INT NOT NULL,
    action_id INT NOT NULL
);







CREATE TABLE report_layout (
    id INT NOT NULL,
    view_id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    image VARCHAR(255),
    pdf VARCHAR(255),
    name VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);















CREATE TABLE report_paperformat (
    id INT NOT NULL,
    page_height INT,
    page_width INT,
    header_spacing INT,
    dpi INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    format VARCHAR(255),
    orientation VARCHAR(255),
    "default" boolean,
    header_line boolean,
    disable_shrinking boolean,
    create_date timestamp ,
    write_date timestamp ,
    margin_top double precision,
    margin_bottom double precision,
    margin_left double precision,
    margin_right double precision
);




























CREATE VIEW report_project_task_user AS
SELECT
    NULL::INT AS nbr,
    NULL::INT AS id,
    NULL::INT AS task_id,
    NULL::boolean AS active,
    NULL::timestamp  AS create_date,
    NULL::timestamp  AS date_assign,
    NULL::timestamp  AS date_end,
    NULL::timestamp  AS date_last_stage_update,
    NULL::timestamp  AS date_deadline,
    NULL::INT AS project_id,
    NULL::VARCHAR(255) AS priority,
    NULL::VARCHAR(255) AS name,
    NULL::INT AS company_id,
    NULL::INT AS partner_id,
    NULL::INT AS parent_id,
    NULL::INT AS stage_id,
    NULL::VARCHAR(255) AS state,
    NULL::INT AS milestone_id,
    NULL::boolean AS is_closed,
    NULL::boolean AS has_late_and_unreached_milestone,
    NULL::text AS description,
    NULL::double precision AS rating_last_value,
    NULL::double precision AS rating_avg,
    NULL::double precision AS working_days_close,
    NULL::double precision AS working_days_open,
    NULL::numeric AS working_hours_open,
    NULL::numeric AS working_hours_close,
    NULL::numeric AS delay_endings_days,
    NULL::bigint AS dependent_ids_count,
    NULL::timestamp  AS planned_date_begin;




CREATE TABLE res_bank (
    id INT NOT NULL,
    state INT,
    country INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    street VARCHAR(255),
    street2 VARCHAR(255),
    zip VARCHAR(255),
    city VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255),
    bic VARCHAR(255),
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);





















CREATE TABLE res_company (
    id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    partner_id INT NOT NULL,
    currency_id INT NOT NULL,
    sequence INT,
    create_date timestamp ,
    parent_path VARCHAR(255),
    parent_id INT,
    paperformat_id INT,
    external_report_layout_id INT,
    create_uid INT,
    write_uid INT,
    email VARCHAR(255),
    phone VARCHAR(255),
    mobile VARCHAR(255),
    font VARCHAR(255),
    primary_color VARCHAR(255),
    secondary_color VARCHAR(255),
    layout_background VARCHAR(255) NOT NULL,
    report_header json,
    report_footer json,
    company_details json,
    active boolean,
    uses_default_logo boolean,
    write_date timestamp ,
    logo_web bytea,
    social_twitter VARCHAR(255),
    social_facebook VARCHAR(255),
    social_github VARCHAR(255),
    social_linkedin VARCHAR(255),
    social_youtube VARCHAR(255),
    social_instagram VARCHAR(255),
    social_tiktok VARCHAR(255),
    resource_calendar_id INT,
    alias_domain_id INT,
    alias_domain_name VARCHAR(255),
    email_primary_color VARCHAR(255),
    email_secondary_color VARCHAR(255),
    partner_gid INT,
    iap_enrich_auto_done boolean,
    snailmail_color boolean,
    snailmail_cover boolean,
    snailmail_duplex boolean,
    website_id INT,
    hr_presence_control_email_amount INT,
    hr_presence_control_ip_list VARCHAR(255),
    employee_properties_definition json,
    sign_terms_type VARCHAR(255),
    sign_terms json,
    sign_terms_html json,
    planning_generation_interval INT NOT NULL,
    planning_self_unassign_days_before INT,
    planning_employee_unavailabilities VARCHAR(255) NOT NULL,
    nomenclature_id INT,
    CONSTRAINT res_company_planning_self_unassign_days_before_positive CHECK ((planning_self_unassign_days_before >= 0))
);




































































































































CREATE TABLE res_company_users_rel (
    cid INT NOT NULL,
    user_id INT NOT NULL
);







CREATE TABLE res_config (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);
















CREATE TABLE res_config_installer (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);














CREATE TABLE res_config_settings (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp ,
    web_app_name VARCHAR(255),
    company_id INT NOT NULL,
    user_default_rights boolean,
    module_base_import boolean,
    module_google_calendar boolean,
    module_microsoft_calendar boolean,
    module_mail_plugin boolean,
    module_auth_oauth boolean,
    module_auth_ldap boolean,
    module_account_inter_company_rules boolean,
    module_voip boolean,
    module_web_unsplash boolean,
    module_partner_autocomplete boolean,
    module_base_geolocalize boolean,
    module_google_recaptcha boolean,
    module_website_cf_turnstile boolean,
    group_multi_currency boolean,
    show_effect boolean,
    module_product_images boolean,
    profiling_enabled_until timestamp ,
    map_box_token VARCHAR(255),
    unsplash_access_key VARCHAR(255),
    unsplash_app_id VARCHAR(255),
    recaptcha_public_key VARCHAR(255),
    recaptcha_private_key VARCHAR(255),
    recaptcha_min_score double precision,
    tenor_gif_limit INT,
    twilio_account_sid VARCHAR(255),
    twilio_account_token VARCHAR(255),
    sfu_server_url VARCHAR(255),
    sfu_server_key VARCHAR(255),
    tenor_api_key VARCHAR(255),
    tenor_content_filter VARCHAR(255),
    google_translate_api_key VARCHAR(255),
    external_email_server_default boolean,
    module_google_gmail boolean,
    module_microsoft_outlook boolean,
    restrict_template_rendering boolean,
    use_twilio_rtc_servers boolean,
    auth_signup_template_user_id INT,
    auth_signup_uninvited VARCHAR(255),
    auth_signup_reset_password boolean,
    google_gmail_client_identifier VARCHAR(255),
    google_gmail_client_secret VARCHAR(255),
    digest_id INT,
    digest_emails boolean,
    disable_redirect_firebase_dynamic_link boolean,
    enable_ocn boolean,
    website_id INT,
    group_multi_website boolean,
    module_website_livechat boolean,
    module_marketing_automation boolean,
    group_analytic_accounting boolean,
    module_hr_presence boolean,
    module_hr_skills boolean,
    module_hr_homeworking boolean,
    hr_presence_control_login boolean,
    hr_presence_control_email boolean,
    hr_presence_control_ip boolean,
    module_hr_attendance boolean,
    hr_employee_self_edit boolean,
    use_sign_terms boolean,
    group_manage_template_access boolean,
    module_sign_itsme boolean,
    module_project_forecast boolean,
    analytic_plan_id INT,
    module_hr_timesheet boolean,
    group_project_rating boolean,
    group_project_stages boolean,
    group_project_recurring_tasks boolean,
    group_project_task_dependencies boolean,
    group_project_milestone boolean,
    mass_mailing_mail_server_id INT,
    group_mass_mailing_campaign boolean,
    mass_mailing_outgoing_mail_server boolean,
    show_blacklist_buttons boolean,
    mass_mailing_reports boolean,
    mass_mailing_split_contact_name boolean,
    module_social_demo boolean,
    google_maps_static_api_key VARCHAR(255),
    google_maps_static_api_secret VARCHAR(255),
    module_event_sale boolean,
    module_website_event_meet boolean,
    module_website_event_track boolean,
    module_website_event_track_live boolean,
    module_website_event_track_quiz boolean,
    module_website_event_exhibitor boolean,
    use_event_barcode boolean,
    module_website_event_sale boolean,
    module_event_booth boolean,
    use_google_maps_static_api boolean,
    facebook_use_own_account boolean,
    instagram_use_own_account boolean,
    linkedin_use_own_account boolean,
    twitter_use_own_account boolean,
    youtube_use_own_account boolean
);








































CREATE TABLE res_country (
    id INT NOT NULL,
    address_view_id INT,
    currency_id INT,
    phone_code INT,
    create_uid INT,
    write_uid INT,
    code VARCHAR(255)(2) NOT NULL,
    name_position VARCHAR(255),
    name json NOT NULL,
    vat_label json,
    address_format text,
    state_required boolean,
    zip_required boolean,
    create_date timestamp ,
    write_date timestamp 
);

















































CREATE TABLE res_country_group (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);




























CREATE TABLE res_country_res_country_group_rel (
    res_country_id INT NOT NULL,
    res_country_group_id INT NOT NULL
);







CREATE TABLE res_country_state (
    id INT NOT NULL,
    country_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);
















CREATE TABLE res_currency (
    id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    symbol VARCHAR(255) NOT NULL,
    decimal_places INT,
    create_uid INT,
    write_uid INT,
    full_name VARCHAR(255),
    "position" VARCHAR(255),
    currency_unit_label VARCHAR(255),
    currency_subunit_label VARCHAR(255),
    rounding numeric,
    active boolean,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT res_currency_rounding_gt_zero CHECK ((rounding > (0)::numeric))
);









































CREATE TABLE res_currency_rate (
    id INT NOT NULL,
    currency_id INT NOT NULL,
    company_id INT,
    create_uid INT,
    write_uid INT,
    name date NOT NULL,
    rate numeric,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT res_currency_rate_currency_rate_check CHECK ((rate > (0)::numeric))
);





























CREATE TABLE res_groups (
    id INT NOT NULL,
    name json NOT NULL,
    category_id INT,
    color INT,
    create_uid INT,
    write_uid INT,
    comment json,
    share boolean,
    create_date timestamp ,
    write_date timestamp 
);




























CREATE TABLE res_groups_implied_rel (
    gid INT NOT NULL,
    hid INT NOT NULL
);







CREATE TABLE res_groups_report_rel (
    uid INT NOT NULL,
    gid INT NOT NULL
);







CREATE TABLE res_groups_sign_template_rel (
    sign_template_id INT NOT NULL,
    res_groups_id INT NOT NULL
);







CREATE TABLE res_groups_users_rel (
    gid INT NOT NULL,
    uid INT NOT NULL
);







CREATE TABLE res_lang (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    code VARCHAR(255) NOT NULL,
    iso_code VARCHAR(255),
    url_code VARCHAR(255) NOT NULL,
    direction VARCHAR(255) NOT NULL,
    date_format VARCHAR(255) NOT NULL,
    time_format VARCHAR(255) NOT NULL,
    week_start VARCHAR(255) NOT NULL,
    "grouping" VARCHAR(255) NOT NULL,
    decimal_point VARCHAR(255) NOT NULL,
    thousands_sep VARCHAR(255),
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);


















































CREATE TABLE res_lang_install_rel (
    language_wizard_id INT NOT NULL,
    lang_id INT NOT NULL
);







CREATE TABLE res_partner (
    id INT NOT NULL,
    company_id INT,
    create_date timestamp ,
    name VARCHAR(255),
    title INT,
    parent_id INT,
    user_id INT,
    state_id INT,
    country_id INT,
    industry_id INT,
    color INT,
    commercial_partner_id INT,
    create_uid INT,
    write_uid INT,
    complete_name VARCHAR(255),
    ref VARCHAR(255),
    lang VARCHAR(255),
    tz VARCHAR(255),
    vat VARCHAR(255),
    company_registry VARCHAR(255),
    website VARCHAR(255),
    function VARCHAR(255),
    type VARCHAR(255),
    street VARCHAR(255),
    street2 VARCHAR(255),
    zip VARCHAR(255),
    city VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(255),
    mobile VARCHAR(255),
    commercial_company_name VARCHAR(255),
    company_name VARCHAR(255),
    comment text,
    partner_latitude numeric,
    partner_longitude numeric,
    active boolean,
    employee boolean,
    is_company boolean,
    partner_share boolean,
    write_date timestamp ,
    contact_address_complete VARCHAR(255),
    message_bounce INT,
    email_normalized VARCHAR(255),
    signup_type VARCHAR(255),
    signup_expiration timestamp ,
    signup_token VARCHAR(255),
    partner_gid INT,
    additional_info VARCHAR(255),
    phone_sanitized VARCHAR(255),
    ocn_token VARCHAR(255),
    website_id INT,
    is_published boolean,
    calendar_last_notif_ack timestamp ,
    website_meta_og_img VARCHAR(255),
    website_meta_title json,
    website_meta_description json,
    website_meta_keywords json,
    seo_name json,
    website_description json,
    website_short_description json,
    CONSTRAINT res_partner_check_name CHECK (((((type)::text = contact::text) AND (name IS NOT NULL)) OR ((type)::text <> contact::text)))
);












































































































































































CREATE TABLE res_partner_autocomplete_sync (
    id INT NOT NULL,
    partner_id INT,
    create_uid INT,
    write_uid INT,
    synched boolean,
    create_date timestamp ,
    write_date timestamp 
);




















CREATE TABLE res_partner_bank (
    id INT NOT NULL,
    partner_id INT NOT NULL,
    bank_id INT,
    sequence INT,
    currency_id INT,
    company_id INT,
    create_uid INT,
    write_uid INT,
    acc_number VARCHAR(255) NOT NULL,
    sanitized_acc_number VARCHAR(255),
    acc_holder_name VARCHAR(255),
    active boolean,
    allow_out_payment boolean,
    create_date timestamp ,
    write_date timestamp 
);
















































CREATE TABLE res_partner_category (
    id INT NOT NULL,
    color INT,
    parent_id INT,
    create_uid INT,
    write_uid INT,
    parent_path VARCHAR(255),
    name json NOT NULL,
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);


































CREATE TABLE res_partner_industry (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name json,
    full_name json,
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);



























CREATE TABLE res_partner_res_partner_category_rel (
    category_id INT NOT NULL,
    partner_id INT NOT NULL
);







CREATE TABLE res_partner_sign_send_request_rel (
    sign_send_request_id INT NOT NULL,
    res_partner_id INT NOT NULL
);







CREATE TABLE res_partner_title (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    shortcut json,
    create_date timestamp ,
    write_date timestamp 
);

























CREATE TABLE res_users (
    id INT NOT NULL,
    company_id INT NOT NULL,
    partner_id INT NOT NULL,
    active boolean DEFAULT true,
    create_date timestamp ,
    login VARCHAR(255) NOT NULL,
    password VARCHAR(255),
    action_id INT,
    create_uid INT,
    write_uid INT,
    signature text,
    share boolean,
    write_date timestamp ,
    totp_secret VARCHAR(255),
    notification_type VARCHAR(255) NOT NULL,
    odoobot_state VARCHAR(255),
    odoobot_failed boolean,
    oauth_uid VARCHAR(255),
    website_id INT,
    karma INT,
    rank_id INT,
    next_rank_id INT,
    CONSTRAINT res_users_notification_type CHECK ((((notification_type)::text = email::text) OR (NOT share)))
);

















































CREATE TABLE res_users_apikeys (
    id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    scope VARCHAR(255),
    index VARCHAR(255)(8),
    key VARCHAR(255),
    create_date timestamp  DEFAULT (now() AT TIME ZONE utc::text),
    CONSTRAINT res_users_apikeys_index_check CHECK ((char_length((index)::text) = 8))
);




CREATE TABLE res_users_apikeys_description (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);


















CREATE TABLE res_users_deletion (
    id INT NOT NULL,
    user_id INT,
    user_id_int INT,
    create_uid INT,
    write_uid INT,
    state VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);












CREATE TABLE res_users_identitycheck (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    request VARCHAR(255),
    password VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);

























CREATE TABLE res_users_log (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);




















CREATE TABLE res_users_settings (
    id INT NOT NULL,
    user_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp ,
    homemenu_config json,
    voice_active_duration INT,
    push_to_talk_key VARCHAR(255),
    is_discuss_sidebar_category_channel_open boolean,
    is_discuss_sidebar_category_chat_open boolean,
    use_push_to_talk boolean
);































CREATE TABLE res_users_settings_volumes (
    id INT NOT NULL,
    user_setting_id INT NOT NULL,
    partner_id INT,
    guest_id INT,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp ,
    volume double precision,
    CONSTRAINT res_users_settings_volumes_partner_or_guest_exists CHECK ((((partner_id IS NOT NULL) AND (guest_id IS NULL)) OR ((partner_id IS NULL) AND (guest_id IS NOT NULL))))
);





























CREATE TABLE res_users_sign_request_rel (
    sign_request_id INT NOT NULL,
    res_users_id INT NOT NULL
);







CREATE TABLE res_users_survey_survey_rel (
    survey_survey_id INT NOT NULL,
    res_users_id INT NOT NULL
);







CREATE TABLE reset_view_arch_wizard (
    id INT NOT NULL,
    view_id INT,
    compare_view_id INT,
    create_uid INT,
    write_uid INT,
    reset_mode VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);

























CREATE TABLE resource_calendar (
    id INT NOT NULL,
    company_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    tz VARCHAR(255) NOT NULL,
    hours_per_day numeric,
    active boolean,
    two_weeks_calendar boolean,
    create_date timestamp ,
    write_date timestamp 
);





































CREATE TABLE resource_calendar_attendance (
    id INT NOT NULL,
    calendar_id INT NOT NULL,
    resource_id INT,
    sequence INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    dayofweek VARCHAR(255) NOT NULL,
    day_period VARCHAR(255) NOT NULL,
    week_type VARCHAR(255),
    display_type VARCHAR(255),
    date_from date,
    date_to date,
    create_date timestamp ,
    write_date timestamp ,
    hour_from double precision NOT NULL,
    hour_to double precision NOT NULL,
    duration_days double precision
);




















































CREATE TABLE resource_calendar_leaves (
    id INT NOT NULL,
    company_id INT,
    calendar_id INT,
    resource_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    time_type VARCHAR(255),
    date_from timestamp  NOT NULL,
    date_to timestamp  NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);





CREATE TABLE product_accessory_rel (
    src_id INT NOT NULL,
    dest_id INT NOT NULL,
    PRIMARY KEY (src_id, dest_id)
);


CREATE TABLE product_attribute (
    id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    create_variant VARCHAR(255) NOT NULL,
    display_type VARCHAR(255) NOT NULL,
    name JSON NOT NULL,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    visibility VARCHAR(255),
    category_id INT,
    PRIMARY KEY (id)
);


CREATE TABLE product_category (
    id INT NOT NULL,
    parent_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    complete_name VARCHAR(255),
    parent_path VARCHAR(255),
    product_properties_definition JSON,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    removal_strategy_id INT,
    packaging_reserve_method VARCHAR(255),
    PRIMARY KEY (id)
);


CREATE TABLE product_image (
    id INT NOT NULL AUTO_INCREMENT,
    sequence INT,
    product_tmpl_id INT,
    product_variant_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    video_url VARCHAR(255),
    can_image_1024_be_zoomed BOOLEAN,
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    write_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);


CREATE TABLE product_packaging (
    id INT NOT NULL AUTO_INCREMENT,
    sequence INT,
    product_id INT NOT NULL,
    company_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    barcode VARCHAR(255),
    qty DECIMAL(12, 2),
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    sales BOOLEAN,
    package_type_id INT,
    purchase BOOLEAN,
    PRIMARY KEY (id)
);



CREATE TABLE product_pricelist (
    id INT NOT NULL,
    sequence INT,
    currency_id INT NOT NULL,
    company_id INT,
    create_uid INT,
    write_uid INT,
    discount_policy VARCHAR(255) NOT NULL,
    name JSON,
    active BOOLEAN,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    website_id INT,
    code VARCHAR(255),
    selectable BOOLEAN,
    PRIMARY KEY (id)
);

CREATE TABLE product_pricelist_item (
    id INT NOT NULL,
    pricelist_id INT NOT NULL,
    company_id INT,
    currency_id INT,
    categ_id INT,
    product_tmpl_id INT,
    product_id INT,
    base_pricelist_id INT,
    create_uid INT,
    write_uid INT,
    applied_on VARCHAR(255) NOT NULL,
    base VARCHAR(255) NOT NULL,
    compute_price VARCHAR(255) NOT NULL,
    min_quantity DECIMAL(18, 6),
    fixed_price DECIMAL(18, 6),
    price_discount DECIMAL(18, 6),
    price_round DECIMAL(18, 6),
    price_surcharge DECIMAL(18, 6),
    price_min_margin DECIMAL(18, 6),
    price_max_margin DECIMAL(18, 6),
    date_start TIMESTAMP,
    date_end TIMESTAMP,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    percent_price DOUBLE
);

CREATE TABLE product_product (
    id INT NOT NULL,
    product_tmpl_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    default_code VARCHAR(255),
    barcode VARCHAR(255),
    combination_indices VARCHAR(255),
    volume DECIMAL(18, 6),
    weight DECIMAL(18, 6),
    active TINYINT(1),
    can_image_variant_1024_be_zoomed TINYINT(1),
    write_date TIMESTAMP,
    create_date TIMESTAMP,
    lot_properties_definition JSON,
    ribbon_id INT,
    base_unit_id INT,
    base_unit_count DOUBLE NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE product_product_sale_order_alert_rel (
    sale_order_alert_id INT NOT NULL,
    product_product_id INT NOT NULL
);

CREATE TABLE sale_order_alert (
    id INT NOT NULL,
    automation_id INT NOT NULL,
    action_id INT,
    currency_id INT,
    company_id INT,
    rating_percentage INT,
    create_uid INT,
    write_uid INT,
    action VARCHAR(255) NOT NULL,
    trigger_condition VARCHAR(255),
    mrr_change_unit VARCHAR(255),
    mrr_change_period VARCHAR(255),
    rating_operator VARCHAR(255),
    subscription_state_from VARCHAR(255),
    subscription_state VARCHAR(255),
    order_state VARCHAR(255),
    activity_user VARCHAR(255),
    health VARCHAR(255),
    mrr_min DECIMAL(18, 6),
    mrr_max DECIMAL(18, 6),
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    mrr_change_amount DOUBLE,
    PRIMARY KEY (id)
);

CREATE TABLE product_product_stock_track_confirmation_rel (
    stock_track_confirmation_id INT NOT NULL,
    product_product_id INT NOT NULL
);

CREATE TABLE stock_track_confirmation (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    PRIMARY KEY (id)
);


CREATE TABLE product_removal (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name JSON,
    method JSON,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    PRIMARY KEY (id)
);


CREATE TABLE product_replenish (
    id INT NOT NULL,
    product_id INT NOT NULL,
    product_tmpl_id INT NOT NULL,
    product_uom_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    route_id INT,
    company_id INT,
    create_uid INT,
    write_uid INT,
    product_has_variants TINYINT(1) NOT NULL,
    date_planned TIMESTAMP NOT NULL,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    quantity DOUBLE NOT NULL,
    supplier_id INT,
    PRIMARY KEY (id)
);


CREATE TABLE product_ribbon (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    bg_color VARCHAR(255),
    text_color VARCHAR(255),
    html_class VARCHAR(255) NOT NULL,
    html JSON,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    PRIMARY KEY (id)
);


CREATE TABLE product_supplier_taxes_rel (
    prod_id INT NOT NULL,
    tax_id INT NOT NULL
);

CREATE TABLE product_supplierinfo (
    id INT NOT NULL,
    partner_id INT NOT NULL,
    sequence INT,
    company_id INT,
    currency_id INT NOT NULL,
    product_id INT,
    product_tmpl_id INT,
    delay INT NOT NULL,
    create_uid INT,
    write_uid INT,
    product_name VARCHAR(255),
    product_code VARCHAR(255),
    date_start DATE,
    date_end DATE,
    min_qty DECIMAL(18, 6) NOT NULL,
    price DECIMAL(18, 6) NOT NULL,
    discount DECIMAL(18, 6),
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    PRIMARY KEY (id)
);


CREATE TABLE product_supplierinfo_stock_replenishment_info_rel (
    stock_replenishment_info_id INT NOT NULL,
    product_supplierinfo_id INT NOT NULL
);

CREATE TABLE product_tag (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    color VARCHAR(255),
    name JSON NOT NULL,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    website_id INT,
    visible_on_ecommerce TINYINT(1),
    PRIMARY KEY (id)
);

CREATE TABLE product_tag_product_product_rel (
    product_product_id INT NOT NULL,
    product_tag_id INT NOT NULL
);


CREATE TABLE product_tags_table (
    res_company_id INT NOT NULL,
    documents_tag_id INT NOT NULL
);

CREATE TABLE product_taxes_rel (
    prod_id INT NOT NULL,
    tax_id INT NOT NULL
);



CREATE TABLE product_template (
    id INT NOT NULL,
    sequence INT,
  categ_id INT NOT NULL,
    uom_id INT NOT NULL,
    uom_po_id INT NOT NULL,
    company_id INT,
  color INT,
  create_uid INT,
  write_uid INT,
  detailed_type VARCHAR(255) NOT NULL,
    type VARCHAR(255),
    default_code VARCHAR(255),
    priority VARCHAR(255),
    name JSON,
    description JSON,
    description_purchase JSON,
    description_sale JSON,
    product_properties JSON,
    list_price DECIMAL(18, 6),
    volume DECIMAL(18, 6),
    weight DECIMAL(18, 6),
    sale_ok TINYINT,
    purchase_ok TINYINT,
    active TINYINT,
    can_image_1024_be_zoomed TINYINT,
    has_configurable_attributes TINYINT,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    can_be_expensed TINYINT DEFAULT 0,
    service_type VARCHAR(255),
    sale_line_warn VARCHAR(255) NOT NULL,
    expense_policy VARCHAR(255),
    invoice_policy VARCHAR(255),
    sale_line_warn_msg TEXT,
    planning_role_id INT,
  planning_enabled TINYINT,
    service_tracking VARCHAR(255),
    sale_delay INT,
  tracking VARCHAR(255) NOT NULL,
    description_picking JSON,
    description_pickingout JSON,
    description_pickingin JSON,
    available_in_pos TINYINT,
    to_weight TINYINT,
    description_self_order TEXT,
    self_order_available TINYINT,
    purchase_method VARCHAR(255),
    purchase_line_warn VARCHAR(255) NOT NULL,
    purchase_line_warn_msg TEXT,
    recurring_invoice TINYINT,
    rent_ok TINYINT,
    country_of_origin INT,
  hs_code VARCHAR(255),
    website_id INT,
  website_size_x INT,
  website_size_y INT,
  website_ribbon_id INT,
  website_sequence INT,
  base_unit_id INT,
  website_meta_og_img varchar(255), 
    website_meta_title json,
    website_meta_description json,
    website_meta_keywords json,
    seo_name json,
    website_description json,
    description_ecommerce json,
    compare_list_price numeric,
    is_published boolean,
    rating_last_value double precision,
    base_unit_count double precision NOT NULL,
    out_of_stock_message json,
    allow_out_of_stock_order boolean,
    show_availability boolean,
    available_threshold double precision,
    service_upsell_threshold double precision,
    version INT,
    create_repair boolean,
    expiration_time INT,
    use_time INT,
    removal_time INT,
    alert_time INT,
    use_expiration_date boolean,
    product_add_mode varchar(255),  
    x_beer INT,
    email_template_id INT,
    split_method_landed_cost varchar(255),  
    landed_cost_ok boolean,
    x_oem_no varchar(255)
);

CREATE TABLE product_wishlist (
    id int NOT NULL,
    partner_id int,
    product_id int NOT NULL,
    pricelist_id int,
    website_id int NOT NULL,
    create_uid int,
    write_uid int,
    price decimal(18,2),  -- Menggunakan decimal untuk numerik presisi tetap
    active tinyint(1) NOT NULL,  -- tinyint(1) untuk menyimpan nilai boolean
    create_date timestamp,
    write_date timestamp,
    PRIMARY KEY (id)
);





















-




CREATE TABLE resource_resource (
    id INT NOT NULL,
    company_id INT,
    user_id INT,
    calendar_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    resource_type VARCHAR(255) NOT NULL,
    tz VARCHAR(255) NOT NULL,
    active boolean,
    create_date timestamp ,
    write_date timestamp ,
    time_efficiency double precision NOT NULL,
    color INT,
    default_role_id INT,
    CONSTRAINT resource_resource_check_time_efficiency CHECK ((time_efficiency > (0)::double precision))
);























































CREATE TABLE resource_resource_planning_role_rel (
    planning_role_id INT NOT NULL,
    resource_resource_id INT NOT NULL
);







CREATE TABLE rule_group_rel (
    rule_group_id INT NOT NULL,
    group_id INT NOT NULL
);







CREATE TABLE sign_duplicate_template_pdf (
    id INT NOT NULL,
    original_template_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    new_template VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);























CREATE TABLE sign_item (
    id INT NOT NULL,
    template_id INT NOT NULL,
    type_id INT NOT NULL,
    responsible_id INT,
    page INT NOT NULL,
    transaction_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    alignment VARCHAR(255) NOT NULL,
    "posX" numeric NOT NULL,
    "posY" numeric NOT NULL,
    width numeric NOT NULL,
    height numeric NOT NULL,
    required boolean,
    create_date timestamp ,
    write_date timestamp 
);

















































CREATE TABLE sign_item_option (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    value text,
    available boolean,
    create_date timestamp ,
    write_date timestamp 
);


























CREATE TABLE sign_item_role (
    id INT NOT NULL,
    color INT,
    sequence INT,
    create_uid INT,
    write_uid INT,
    auth_method VARCHAR(255),
    name json NOT NULL,
    "default" boolean NOT NULL,
    change_authorized boolean,
    create_date timestamp ,
    write_date timestamp 
);






CREATE TABLE sign_item_sign_item_option_rel (
    sign_item_id INT NOT NULL,
    sign_item_option_id INT NOT NULL
);







CREATE TABLE sign_item_type (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    item_type VARCHAR(255) NOT NULL,
    auto_field VARCHAR(255),
    name json NOT NULL,
    tip json NOT NULL,
    placeholder json,
    default_width numeric NOT NULL,
    default_height numeric NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);











































CREATE TABLE sign_log (
    id INT NOT NULL,
    sign_request_id INT NOT NULL,
    sign_request_item_id INT,
    user_id INT,
    partner_id INT,
    create_uid INT,
    write_uid INT,
    ip VARCHAR(255) NOT NULL,
    log_hash VARCHAR(255),
    token VARCHAR(255),
    action VARCHAR(255) NOT NULL,
    request_state VARCHAR(255) NOT NULL,
    latitude numeric,
    longitude numeric,
    log_date timestamp  NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);























































CREATE TABLE sign_request (
    id INT NOT NULL,
    template_id INT NOT NULL,
    nb_wait INT,
    nb_closed INT,
    nb_total INT,
    color INT,
    communication_company_id INT,
    reminder INT,
    create_uid INT,
    write_uid INT,
    subject VARCHAR(255),
    reference VARCHAR(255) NOT NULL,
    access_token VARCHAR(255) NOT NULL,
    state VARCHAR(255),
    validity date,
    last_reminder date,
    message text,
    message_cc text,
    active boolean,
    reminder_enabled boolean,
    create_date timestamp ,
    write_date timestamp 
);






































































CREATE TABLE sign_request_completed_document_rel (
    sign_request_id INT NOT NULL,
    ir_attachment_id INT NOT NULL
);











CREATE TABLE sign_request_item (
    id INT NOT NULL,
    partner_id INT,
    sign_request_id INT NOT NULL,
    mail_sent_order INT,
    role_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    access_token VARCHAR(255) NOT NULL,
    sms_number VARCHAR(255),
    sms_token VARCHAR(255),
    state VARCHAR(255),
    signer_email VARCHAR(255),
    signing_date date,
    latitude numeric,
    longitude numeric,
    access_via_link boolean,
    signed_without_extra_auth boolean,
    ignored boolean NOT NULL,
    is_mail_sent boolean,
    create_date timestamp ,
    write_date timestamp 
);








































































CREATE TABLE sign_request_item_value (
    id INT NOT NULL,
    sign_request_item_id INT NOT NULL,
    sign_item_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    value text,
    frame_value text,
    frame_has_hash boolean,
    create_date timestamp ,
    write_date timestamp 
);






























CREATE TABLE sign_request_sign_template_tag_rel (
    sign_request_id INT NOT NULL,
    sign_template_tag_id INT NOT NULL
);







CREATE TABLE sign_send_request (
    id INT NOT NULL,
    activity_id INT,
    template_id INT NOT NULL,
    signer_id INT,
    signers_count INT,
    reminder INT,
    create_uid INT,
    write_uid INT,
    subject VARCHAR(255) NOT NULL,
    filename VARCHAR(255) NOT NULL,
    validity date,
    message text,
    message_cc text,
    has_default_template boolean,
    set_sign_order boolean,
    reminder_enabled boolean,
    create_date timestamp ,
    write_date timestamp 
);































































CREATE TABLE sign_send_request_signer (
    id INT NOT NULL,
    role_id INT NOT NULL,
    partner_id INT NOT NULL,
    mail_sent_order INT,
    sign_send_request_id INT,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);



































CREATE TABLE sign_template (
    id INT NOT NULL,
    attachment_id INT NOT NULL,
    num_pages INT,
    user_id INT,
    color INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    redirect_url VARCHAR(255),
    redirect_url_text json,
    active boolean,
    has_sign_requests boolean,
    create_date timestamp ,
    write_date timestamp 
);














































CREATE TABLE sign_template_authorized_users_rel (
    sign_template_id INT NOT NULL,
    res_users_id INT NOT NULL
);







CREATE TABLE sign_template_favorited_users_rel (
    sign_template_id INT NOT NULL,
    res_users_id INT NOT NULL
);








CREATE TABLE sign_template_sign_template_tag_rel (
    sign_template_id INT NOT NULL,
    sign_template_tag_id INT NOT NULL
);







CREATE TABLE sign_template_tag (
    id INT NOT NULL,
    color INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);
























CREATE TABLE sms_composer (
    id INT NOT NULL,
    res_id INT,
    template_id INT,
    create_uid INT,
    write_uid INT,
    composition_mode VARCHAR(255) NOT NULL,
    res_model VARCHAR(255),
    res_ids VARCHAR(255),
    recipient_single_number_itf VARCHAR(255),
    number_field_name VARCHAR(255),
    numbers VARCHAR(255),
    body text NOT NULL,
    mass_keep_log boolean,
    mass_force_send boolean,
    mass_use_blacklist boolean,
    create_date timestamp ,
    write_date timestamp ,
    mailing_id INT,
    utm_campaign_id INT,
    mass_sms_allow_unsubscribe boolean,
    marketing_activity_id INT
);



































































CREATE TABLE sms_resend (
    id INT NOT NULL,
    mail_message_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);




















CREATE TABLE sms_resend_recipient (
    id INT NOT NULL,
    sms_resend_id INT NOT NULL,
    notification_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    partner_name VARCHAR(255),
    sms_number VARCHAR(255),
    resend boolean,
    create_date timestamp ,
    write_date timestamp 
);
































CREATE TABLE sms_sms (
    id INT NOT NULL,
    partner_id INT,
    mail_message_id INT,
    create_uid INT,
    write_uid INT,
    uuid VARCHAR(255),
    number VARCHAR(255),
    state VARCHAR(255) NOT NULL,
    failure_type VARCHAR(255),
    body text,
    to_delete boolean,
    create_date timestamp ,
    write_date timestamp ,
    mailing_id INT
);

















































CREATE TABLE sms_template (
    id INT NOT NULL,
    model_id INT NOT NULL,
    sidebar_action_id INT,
    create_uid INT,
    write_uid INT,
    template_fs VARCHAR(255),
    lang VARCHAR(255),
    model VARCHAR(255),
    name json,
    body json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);






































CREATE TABLE sms_template_preview (
    id INT NOT NULL,
    sms_template_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    lang VARCHAR(255),
    resource_ref VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);




























CREATE TABLE sms_template_reset (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);


















CREATE TABLE sms_template_sms_template_reset_rel (
    sms_template_reset_id INT NOT NULL,
    sms_template_id INT NOT NULL
);







CREATE TABLE sms_tracker (
    id INT NOT NULL,
    mail_notification_id INT,
    create_uid INT,
    write_uid INT,
    sms_uuid VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp ,
    mailing_trace_id INT
);

































CREATE TABLE snailmail_letter (
    id INT NOT NULL,
    user_id INT,
    res_id INT NOT NULL,
    partner_id INT NOT NULL,
    company_id INT NOT NULL,
    report_template INT,
    attachment_id INT,
    message_id INT,
    state_id INT,
    country_id INT,
    create_uid INT,
    write_uid INT,
    model VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    error_code VARCHAR(255),
    info_msg VARCHAR(255),
    street VARCHAR(255),
    street2 VARCHAR(255),
    zip VARCHAR(255),
    city VARCHAR(255),
    color boolean,
    cover boolean,
    duplex boolean,
    create_date timestamp ,
    write_date timestamp 
);















































































CREATE TABLE snailmail_letter_format_error (
    id INT NOT NULL,
    message_id INT,
    create_uid INT,
    write_uid INT,
    snailmail_cover boolean,
    create_date timestamp ,
    write_date timestamp 
);
































CREATE TABLE snailmail_letter_missing_required_fields (
    id INT NOT NULL,
    partner_id INT,
    letter_id INT,
    state_id INT,
    country_id INT,
    create_uid INT,
    write_uid INT,
    street VARCHAR(255),
    street2 VARCHAR(255),
    zip VARCHAR(255),
    city VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);



















































CREATE TABLE social_account (
    id INT NOT NULL,
    media_id INT NOT NULL,
    audience INT,
    engagement INT,
    stories INT,
    utm_medium_id INT NOT NULL,
    company_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    social_account_handle VARCHAR(255),
    audience_trend numeric,
    engagement_trend numeric,
    stories_trend numeric,
    active boolean,
    is_media_disconnected boolean,
    has_trends boolean,
    has_account_stats boolean,
    create_date timestamp ,
    write_date timestamp ,
    facebook_account_id VARCHAR(255),
    facebook_access_token VARCHAR(255),
    instagram_account_id VARCHAR(255),
    instagram_facebook_account_id VARCHAR(255),
    instagram_access_token VARCHAR(255),
    linkedin_account_urn VARCHAR(255),
    linkedin_access_token VARCHAR(255),
    twitter_user_id VARCHAR(255),
    twitter_oauth_token VARCHAR(255),
    twitter_oauth_token_secret VARCHAR(255),
    youtube_channel_id VARCHAR(255),
    youtube_access_token VARCHAR(255),
    youtube_refresh_token VARCHAR(255),
    youtube_upload_playlist_id VARCHAR(255),
    youtube_token_expiration_date timestamp ,
    website_id INT
);















































































































CREATE TABLE social_account_revoke_youtube (
    id INT NOT NULL,
    account_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    create_date timestamp ,
    write_date timestamp 
);


























CREATE TABLE social_account_social_post_rel (
    social_post_id INT NOT NULL,
    social_account_id INT NOT NULL
);







CREATE TABLE social_account_social_post_template_rel (
    social_post_template_id INT NOT NULL,
    social_account_id INT NOT NULL
);







CREATE TABLE social_live_post (
    id INT NOT NULL,
    post_id INT NOT NULL,
    account_id INT NOT NULL,
    engagement INT,
    create_uid INT,
    write_uid INT,
    state VARCHAR(255) NOT NULL,
    failure_reason text,
    create_date timestamp ,
    write_date timestamp ,
    facebook_post_id VARCHAR(255),
    instagram_post_id VARCHAR(255),
    linkedin_post_id VARCHAR(255),
    twitter_tweet_id VARCHAR(255)
);

















































CREATE TABLE social_live_post_website_visitor_rel (
    social_live_post_id INT NOT NULL,
    website_visitor_id INT NOT NULL
);







CREATE TABLE social_media (
    id INT NOT NULL,
    max_post_length INT,
    create_uid INT,
    write_uid INT,
    media_description VARCHAR(255),
    media_type VARCHAR(255),
    name json NOT NULL,
    has_streams boolean NOT NULL,
    can_link_accounts boolean NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);

































CREATE TABLE social_media_social_post_rel (
    social_post_id INT NOT NULL,
    social_media_id INT NOT NULL
);







CREATE TABLE social_post (
    id INT NOT NULL,
    source_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    company_id INT,
    utm_campaign_id INT,
    state VARCHAR(255) NOT NULL,
    post_method VARCHAR(255) NOT NULL,
    message text,
    create_date timestamp ,
    write_date timestamp ,
    scheduled_date timestamp ,
    published_date timestamp ,
    calendar_date timestamp ,
    instagram_access_token VARCHAR(255),
    youtube_video VARCHAR(255),
    youtube_video_id VARCHAR(255),
    youtube_video_category_id VARCHAR(255),
    youtube_title VARCHAR(255),
    youtube_video_privacy VARCHAR(255) NOT NULL,
    youtube_description text,
    push_notification_title VARCHAR(255),
    push_notification_target_url VARCHAR(255),
    visitor_domain VARCHAR(255),
    use_visitor_timezone boolean
);


















































































CREATE TABLE social_post_template (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    message text,
    create_date timestamp ,
    write_date timestamp ,
    instagram_access_token VARCHAR(255),
    push_notification_title VARCHAR(255),
    push_notification_target_url VARCHAR(255),
    visitor_domain VARCHAR(255),
    use_visitor_timezone boolean
);



































CREATE TABLE social_stream (
    id INT NOT NULL,
    media_id INT NOT NULL,
    sequence INT,
    account_id INT NOT NULL,
    stream_type_id INT NOT NULL,
    company_id INT,
    create_uid INT,
    write_uid INT,
    name json,
    create_date timestamp ,
    write_date timestamp ,
    twitter_followed_account_id INT,
    twitter_searched_keyword VARCHAR(255),
    twitter_followed_account_search VARCHAR(255)
);



































CREATE TABLE social_stream_post (
    id INT NOT NULL,
    stream_id INT,
    create_uid INT,
    write_uid INT,
    author_name VARCHAR(255),
    link_image_url VARCHAR(255),
    link_url VARCHAR(255),
    message text,
    link_title text,
    link_description text,
    published_date timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    facebook_likes_count INT,
    facebook_comments_count INT,
    facebook_shares_count INT,
    facebook_reach INT,
    facebook_post_id VARCHAR(255),
    facebook_author_id VARCHAR(255),
    facebook_user_likes boolean,
    facebook_is_event_post boolean,
    instagram_comments_count INT,
    instagram_likes_count INT,
    instagram_facebook_author_id VARCHAR(255),
    instagram_post_id VARCHAR(255),
    instagram_post_link VARCHAR(255),
    linkedin_comments_count INT,
    linkedin_likes_count INT,
    linkedin_post_urn VARCHAR(255),
    linkedin_author_urn VARCHAR(255),
    linkedin_author_vanity_name VARCHAR(255),
    linkedin_author_image_url VARCHAR(255),
    twitter_likes_count INT,
    twitter_comments_count INT,
    twitter_retweet_count INT,
    twitter_tweet_id VARCHAR(255),
    twitter_conversation_id VARCHAR(255),
    twitter_author_id VARCHAR(255),
    twitter_screen_name VARCHAR(255),
    twitter_profile_image_url VARCHAR(255),
    twitter_retweeted_tweet_id_str VARCHAR(255),
    twitter_quoted_tweet_id_str VARCHAR(255),
    twitter_quoted_tweet_author_name VARCHAR(255),
    twitter_quoted_tweet_author_link VARCHAR(255),
    twitter_quoted_tweet_profile_image_url VARCHAR(255),
    twitter_quoted_tweet_message text,
    twitter_user_likes boolean,
    youtube_likes_count INT,
    youtube_dislikes_count INT,
    youtube_comments_count INT,
    youtube_views_count INT,
    youtube_video_id VARCHAR(255)
);

































































































































































CREATE TABLE social_stream_post_image (
    id INT NOT NULL,
    stream_post_id INT,
    create_uid INT,
    write_uid INT,
    image_url VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);































CREATE TABLE social_stream_type (
    id INT NOT NULL,
    media_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    stream_type VARCHAR(255) NOT NULL,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);























CREATE TABLE social_twitter_account (
    id INT NOT NULL,
    twitter_searched_by_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    description VARCHAR(255),
    twitter_id VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);



























CREATE TABLE survey_invite (
    id INT NOT NULL,
    template_id INT,
    author_id INT,
    mail_server_id INT,
    survey_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    lang VARCHAR(255),
    subject VARCHAR(255),
    existing_mode VARCHAR(255) NOT NULL,
    body text,
    emails text,
    deadline timestamp ,
    create_date timestamp ,
    write_date timestamp 
);

















































CREATE TABLE survey_invite_partner_ids (
    invite_id INT NOT NULL,
    partner_id INT NOT NULL
);







CREATE TABLE survey_mail_compose_message_ir_attachments_rel (
    wizard_id INT NOT NULL,
    attachment_id INT NOT NULL
);







CREATE TABLE survey_question (
    id INT NOT NULL,
    survey_id INT,
    sequence INT,
    random_questions_count INT,
    page_id INT,
    scale_min INT,
    scale_max INT,
    time_limit INT,
    validation_length_min INT,
    validation_length_max INT,
    create_uid INT,
    write_uid INT,
    question_type VARCHAR(255),
    matrix_subtype VARCHAR(255),
    answer_date date,
    validation_min_date date,
    validation_max_date date,
    title json NOT NULL,
    description json,
    question_placeholder json,
    scale_min_label json,
    scale_mid_label json,
    scale_max_label json,
    comments_message json,
    validation_error_msg json,
    constr_error_msg json,
    is_page boolean,
    is_scored_question boolean,
    save_as_email boolean,
    save_as_nickname boolean,
    is_time_limited boolean,
    is_time_customized boolean,
    comments_allowed boolean,
    comment_count_as_answer boolean,
    validation_required boolean,
    validation_email boolean,
    constr_mandatory boolean,
    answer_datetime timestamp ,
    validation_min_datetime timestamp ,
    validation_max_datetime timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    answer_numerical_box double precision,
    answer_score double precision,
    validation_min_float_value double precision,
    validation_max_float_value double precision,
    CONSTRAINT survey_question_is_time_limited_have_time_limit CHECK (((is_time_limited <> true) OR ((time_limit IS NOT NULL) AND (time_limit > 0)))),
    CONSTRAINT survey_question_positive_answer_score CHECK ((answer_score >= (0)::double precision)),
    CONSTRAINT survey_question_positive_len_max CHECK ((validation_length_max >= 0)),
    CONSTRAINT survey_question_positive_len_min CHECK ((validation_length_min >= 0)),
    CONSTRAINT survey_question_scale CHECK ((((question_type)::text <> scale::text) OR ((scale_min >= 0) AND (scale_max <= 10) AND (scale_min < scale_max)))),
    CONSTRAINT survey_question_scored_date_have_answers CHECK (((is_scored_question <> true) OR ((question_type)::text <> date::text) OR (answer_date IS NOT NULL))),
    CONSTRAINT survey_question_scored_datetime_have_answers CHECK (((is_scored_question <> true) OR ((question_type)::text <> datetime::text) OR (answer_datetime IS NOT NULL))),
    CONSTRAINT survey_question_validation_date CHECK ((validation_min_date <= validation_max_date)),
    CONSTRAINT survey_question_validation_datetime CHECK ((validation_min_datetime <= validation_max_datetime)),
    CONSTRAINT survey_question_validation_float CHECK ((validation_min_float_value <= validation_max_float_value)),
    CONSTRAINT survey_question_validation_length CHECK ((validation_length_min <= validation_length_max))
);















































































































































































CREATE TABLE survey_question_answer (
    id INT NOT NULL,
    question_id INT,
    matrix_question_id INT,
    sequence INT,
    create_uid INT,
    write_uid INT,
    value_image_filename VARCHAR(255),
    value json,
    is_correct boolean,
    create_date timestamp ,
    write_date timestamp ,
    answer_score double precision,
    CONSTRAINT survey_question_answer_value_not_empty CHECK (((value IS NOT NULL) OR (value_image_filename IS NOT NULL)))
);










































CREATE TABLE survey_question_survey_question_answer_rel (
    survey_question_id INT NOT NULL,
    survey_question_answer_id INT NOT NULL
);







CREATE TABLE survey_question_survey_user_input_rel (
    survey_user_input_id INT NOT NULL,
    survey_question_id INT NOT NULL
);







CREATE TABLE survey_survey (
    id INT NOT NULL,
    color INT,
    user_id INT,
    attempts_limit INT,
    certification_mail_template_id INT,
    certification_badge_id INT,
    session_question_id INT,
    session_speed_rating_time_limit INT,
    create_uid INT,
    write_uid INT,
    survey_type VARCHAR(255) NOT NULL,
    questions_layout VARCHAR(255) NOT NULL,
    questions_selection VARCHAR(255) NOT NULL,
    progression_mode VARCHAR(255),
    access_mode VARCHAR(255) NOT NULL,
    access_token VARCHAR(255),
    scoring_type VARCHAR(255) NOT NULL,
    certification_report_layout VARCHAR(255),
    session_state VARCHAR(255),
    session_code VARCHAR(255),
    title json NOT NULL,
    description json,
    description_done json,
    active boolean,
    users_login_required boolean,
    users_can_go_back boolean,
    is_attempts_limited boolean,
    is_time_limited boolean,
    certification boolean,
    certification_give_badge boolean,
    session_speed_rating boolean,
    session_start_time timestamp ,
    session_question_start_time timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    scoring_success_min double precision,
    time_limit double precision,
    CONSTRAINT survey_survey_attempts_limit_check CHECK (((is_attempts_limited = false) OR ((attempts_limit IS NOT NULL) AND (attempts_limit > 0)))),
    CONSTRAINT survey_survey_certification_check CHECK ((((scoring_type)::text <> no_scoring::text) OR (certification = false))),
    CONSTRAINT survey_survey_scoring_success_min_check CHECK (((scoring_success_min IS NULL) OR ((scoring_success_min >= (0)::double precision) AND (scoring_success_min <= (100)::double precision)))),
    CONSTRAINT survey_survey_session_speed_rating_has_time_limit CHECK (((session_speed_rating <> true) OR ((session_speed_rating_time_limit IS NOT NULL) AND (session_speed_rating_time_limit > 0)))),
    CONSTRAINT survey_survey_time_limit_check CHECK (((is_time_limited = false) OR ((time_limit IS NOT NULL) AND (time_limit > (0)::double precision))))
);

























































































































CREATE TABLE survey_user_input (
    id INT NOT NULL,
    survey_id INT NOT NULL,
    last_displayed_page_id INT,
    partner_id INT,
    create_uid INT,
    write_uid INT,
    state VARCHAR(255),
    access_token VARCHAR(255) NOT NULL,
    invite_token VARCHAR(255),
    email VARCHAR(255),
    nickname VARCHAR(255),
    scoring_total numeric,
    test_entry boolean,
    scoring_success boolean,
    survey_first_submitted boolean,
    is_session_answer boolean,
    start_datetime timestamp ,
    end_datetime timestamp ,
    deadline timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    scoring_percentage double precision
);


































































CREATE TABLE survey_user_input_line (
    id INT NOT NULL,
    user_input_id INT NOT NULL,
    survey_id INT,
    question_id INT NOT NULL,
    question_sequence INT,
    value_scale INT,
    suggested_answer_id INT,
    matrix_row_id INT,
    create_uid INT,
    write_uid INT,
    answer_type VARCHAR(255),
    value_char_box VARCHAR(255),
    value_date date,
    value_text_box text,
    skipped boolean,
    answer_is_correct boolean,
    value_datetime timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    value_numerical_box double precision,
    answer_score double precision
);


CREATE TABLE stock_location (
    id INT NOT NULL,
    location_id INT,
    posx INT,
    posy INT,
    posz INT,
    company_id INT,
    removal_strategy_id INT,
    cyclic_inventory_frequency INT,
    warehouse_id INT,
    storage_category_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    complete_name VARCHAR(255),
    usage_value VARCHAR(255) NOT NULL,
    parent_path VARCHAR(255),
    barcode_value VARCHAR(255),
    last_inventory_date DATE,
    next_inventory_date DATE,
    comment TEXT,
    active BOOLEAN,
    scrap_location BOOLEAN,
    return_location BOOLEAN,
    replenish_location BOOLEAN,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    valuation_in_account_id INT,
    valuation_out_account_id INT,
    is_subcontracting_location BOOLEAN,
    PRIMARY KEY (id),
    CHECK (cyclic_inventory_frequency >= 0)
);


CREATE TABLE stock_move (
    id INT NOT NULL,
    sequence INT,
    company_id INT NOT NULL,
    product_id INT NOT NULL,
    product_uom INT NOT NULL,
    location_id INT NOT NULL,
    location_dest_id INT NOT NULL,
    partner_id INT,
    picking_id INT,
    scrap_id INT,
    group_id INT,
    rule_id INT,
    picking_type_id INT,
    origin_returned_move_id INT,
    restrict_partner_id INT,
    warehouse_id INT,
    package_level_id INT,
    next_serial_count INT,
    orderpoint_id INT,
    product_packaging_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    priority VARCHAR(255),
    state VARCHAR(255),
    origin VARCHAR(255),
    procure_method VARCHAR(255) NOT NULL,
    reference VARCHAR(255),
    next_serial VARCHAR(255),
    reservation_date DATE,
    description_picking TEXT,
    product_qty DECIMAL(18, 6),
    product_uom_qty DECIMAL(18, 6) NOT NULL,
    quantity DECIMAL(18, 6),
    picked BOOLEAN,
    scrapped BOOLEAN,
    propagate_cancel BOOLEAN,
    is_inventory BOOLEAN,
    additional BOOLEAN,
    date TIMESTAMP NOT NULL,
    date_deadline TIMESTAMP,
    delay_alert_date TIMESTAMP,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    price_unit DOUBLE,
    to_refund BOOLEAN,
    sale_line_id INT,
    purchase_line_id INT,
    is_done BOOLEAN,
    unit_factor DOUBLE,
    created_production_id INT,
    production_id INT,
    raw_material_production_id INT,
    unbuild_id INT,
    consume_unbuild_id INT,
    operation_id INT,
    workorder_id INT,
    bom_line_id INT,
    byproduct_id INT,
    order_finished_lot_id INT,
    cost_share DECIMAL(18, 6),
    manual_consumption BOOLEAN,
    weight DECIMAL(18, 6),
    repair_id INT,
    repair_line_type VARCHAR(255),
    is_subcontract BOOLEAN,
    x_expiry_date TIMESTAMP
);


CREATE TABLE stock_quant (
    id INT NOT NULL,
    product_id INT NOT NULL,
    company_id INT,
    location_id INT NOT NULL,
    storage_category_id INT,
    lot_id INT,
    package_id INT,
    owner_id INT,
    user_id INT,
    create_uid INT,
    write_uid INT,
    inventory_date DATE,
    quantity DECIMAL(18, 6),
    reserved_quantity DECIMAL(18, 6) NOT NULL,
    inventory_quantity DECIMAL(18, 6),
    inventory_diff_quantity DECIMAL(18, 6),
    inventory_quantity_set BOOLEAN,
    in_date TIMESTAMP NOT NULL,
    create_date TIMESTAMP,
    write_date TIMESTAMP,
    accounting_date DATE,
    expiration_date TIMESTAMP,
    removal_date TIMESTAMP,
    PRIMARY KEY (id)
);

































































CREATE TABLE task_dependencies_rel (
    task_id INT NOT NULL,
    depends_on_id INT NOT NULL
);







CREATE TABLE theme_ir_asset (
    id INT NOT NULL,
    sequence INT NOT NULL,
    create_uid INT,
    write_uid INT,
    key VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    bundle VARCHAR(255) NOT NULL,
    directive VARCHAR(255),
    path VARCHAR(255) NOT NULL,
    target VARCHAR(255),
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);















































CREATE TABLE theme_ir_attachment (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    key VARCHAR(255) NOT NULL,
    url VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);

























CREATE TABLE theme_ir_ui_view (
    id INT NOT NULL,
    priority INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    key VARCHAR(255),
    type VARCHAR(255),
    mode VARCHAR(255),
    arch_fs VARCHAR(255),
    inherit_id VARCHAR(255),
    arch json,
    active boolean,
    customize_show boolean,
    create_date timestamp ,
    write_date timestamp 
);






















































CREATE TABLE theme_website_menu (
    id INT NOT NULL,
    page_id INT,
    sequence INT,
    parent_id INT,
    create_uid INT,
    write_uid INT,
    url VARCHAR(255),
    mega_menu_classes VARCHAR(255),
    name json NOT NULL,
    mega_menu_content text,
    new_window boolean,
    use_main_menu_as_parent boolean,
    create_date timestamp ,
    write_date timestamp 
);










































CREATE TABLE theme_website_page (
    id INT NOT NULL,
    view_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    url VARCHAR(255),
    header_color VARCHAR(255),
    website_indexed boolean,
    is_published boolean,
    header_overlay boolean,
    header_visible boolean,
    footer_visible boolean,
    create_date timestamp ,
    write_date timestamp 
);






























CREATE TABLE uom_category (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);

























CREATE TABLE uom_uom (
    id INT NOT NULL,
    category_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    uom_type VARCHAR(255) NOT NULL,
    name json NOT NULL,
    factor numeric NOT NULL,
    rounding numeric NOT NULL,
    active boolean,
    create_date timestamp ,
    write_date timestamp ,
    CONSTRAINT uom_uom_factor_gt_zero CHECK ((factor <> (0)::numeric)),
    CONSTRAINT uom_uom_factor_reference_is_one CHECK (((((uom_type)::text = reference::text) AND (factor = 1.0)) OR ((uom_type)::text <> reference::text))),
    CONSTRAINT uom_uom_rounding_gt_zero CHECK ((rounding > (0)::numeric))
);
















































CREATE TABLE utm_medium (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);



















CREATE TABLE utm_stage (
    id INT NOT NULL,
    sequence INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);
























CREATE TABLE utm_tag (
    id INT NOT NULL,
    color INT,
    create_uid INT,
    write_uid INT,
    name json NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);




























CREATE TABLE utm_tag_rel (
    tag_id INT NOT NULL,
    campaign_id INT NOT NULL
);







CREATE TABLE web_editor_converter_test (
    id INT NOT NULL,
    "INT" INT,
    many2one INT,
    create_uid INT,
    write_uid INT,
    "char" VARCHAR(255),
    selection_str VARCHAR(255),
    date date,
    html text,
    text text,
    "numeric" numeric,
    datetime timestamp ,
    create_date timestamp ,
    write_date timestamp ,
    "float" double precision,
    "binary" bytea
);





















































CREATE TABLE web_editor_converter_test_sub (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);











CREATE TABLE web_tour_tour (
    id INT NOT NULL,
    user_id INT,
    name VARCHAR(255) NOT NULL
);


















CREATE TABLE website (
    id INT NOT NULL,
    sequence INT,
    company_id INT NOT NULL,
    default_lang_id INT NOT NULL,
    user_id INT NOT NULL,
    theme_id INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    domain VARCHAR(255),
    social_twitter VARCHAR(255),
    social_facebook VARCHAR(255),
    social_github VARCHAR(255),
    social_linkedin VARCHAR(255),
    social_youtube VARCHAR(255),
    social_instagram VARCHAR(255),
    social_tiktok VARCHAR(255),
    google_analytics_key VARCHAR(255),
    google_search_console VARCHAR(255),
    google_maps_api_key VARCHAR(255),
    plausible_shared_key VARCHAR(255),
    plausible_site VARCHAR(255),
    cdn_url VARCHAR(255),
    homepage_url VARCHAR(255),
    auth_signup_uninvited VARCHAR(255),
    cdn_filters text,
    custom_code_head text,
    custom_code_footer text,
    robots_txt text,
    auto_redirect_lang boolean,
    cookies_bar boolean,
    configurator_done boolean,
    has_social_default_image boolean,
    cdn_activated boolean,
    specific_user_account boolean,
    create_date timestamp ,
    write_date timestamp ,
    notification_request_delay INT,
    firebase_project_id VARCHAR(255),
    firebase_web_api_key VARCHAR(255),
    firebase_push_certificate_key VARCHAR(255),
    firebase_sender_id VARCHAR(255),
    notification_request_title VARCHAR(255),
    notification_request_body text,
    firebase_enable_push_notifications boolean,
    firebase_use_own_account boolean
);














































































































































CREATE TABLE website_configurator_feature (
    id INT NOT NULL,
    sequence INT,
    page_view_id INT,
    module_id INT,
    menu_sequence INT,
    create_uid INT,
    write_uid INT,
    icon VARCHAR(255),
    iap_page_code VARCHAR(255),
    website_config_preselection VARCHAR(255),
    feature_url VARCHAR(255),
    name json,
    description json,
    menu_company boolean,
    create_date timestamp ,
    write_date timestamp 
);




















































CREATE TABLE website_controller_page (
    id INT NOT NULL,
    website_id INT,
    view_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    page_name VARCHAR(255) NOT NULL,
    name_slugified VARCHAR(255),
    page_type VARCHAR(255),
    record_domain VARCHAR(255),
    default_layout VARCHAR(255),
    is_published boolean,
    create_date timestamp ,
    write_date timestamp 
);








































CREATE TABLE website_event_menu (
    id INT NOT NULL,
    menu_id INT,
    event_id INT,
    view_id INT,
    create_uid INT,
    write_uid INT,
    menu_type VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);


































CREATE TABLE website_lang_rel (
    website_id INT NOT NULL,
    lang_id INT NOT NULL
);







CREATE TABLE website_menu (
    id INT NOT NULL,
    page_id INT,
    controller_page_id INT,
    sequence INT,
    website_id INT,
    parent_id INT,
    create_uid INT,
    write_uid INT,
    theme_template_id INT,
    url VARCHAR(255),
    parent_path VARCHAR(255),
    mega_menu_classes VARCHAR(255),
    name json NOT NULL,
    mega_menu_content json,
    new_window boolean,
    create_date timestamp ,
    write_date timestamp 
);




















CREATE TABLE website_page (
    id INT NOT NULL,
    website_id INT,
    view_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    theme_template_id INT,
    url VARCHAR(255) NOT NULL,
    header_color VARCHAR(255),
    header_text_color VARCHAR(255),
    is_published boolean,
    website_indexed boolean,
    is_new_page_template boolean,
    header_overlay boolean,
    header_visible boolean,
    footer_visible boolean,
    date_publish timestamp ,
    create_date timestamp ,
    write_date timestamp 
);


























































CREATE TABLE website_rewrite (
    id INT NOT NULL,
    website_id INT,
    route_id INT,
    sequence INT,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    url_from VARCHAR(255),
    url_to VARCHAR(255),
    redirect_type VARCHAR(255),
    active boolean,
    create_date timestamp ,
    write_date timestamp 
);













































CREATE TABLE website_robots (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    content text,
    create_date timestamp ,
    write_date timestamp 
);

























CREATE TABLE website_route (
    id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    path VARCHAR(255),
    create_date timestamp ,
    write_date timestamp 
);

















CREATE TABLE website_snippet_filter (
    id INT NOT NULL,
    website_id INT,
    action_server_id INT,
    filter_id INT,
    "limit" INT NOT NULL,
    create_uid INT,
    write_uid INT,
    field_names VARCHAR(255) NOT NULL,
    name json NOT NULL,
    is_published boolean,
    create_date timestamp ,
    write_date timestamp 
);







































CREATE TABLE website_track (
    id INT NOT NULL,
    visitor_id INT NOT NULL,
    page_id INT,
    url text,
    visit_datetime timestamp  NOT NULL
);















CREATE TABLE website_visitor (
    id INT NOT NULL,
    website_id INT,
    partner_id INT,
    country_id INT,
    lang_id INT,
    visit_count INT,
    create_uid INT,
    write_uid INT,
    access_token VARCHAR(255) NOT NULL,
    timezone VARCHAR(255),
    create_date timestamp ,
    last_connection_datetime timestamp ,
    write_date timestamp ,
    has_push_notifications boolean
);


















































CREATE TABLE website_visitor_push_subscription (
    id INT NOT NULL,
    website_visitor_id INT NOT NULL,
    push_token VARCHAR(255) NOT NULL
);











CREATE TABLE wizard_ir_model_menu_create (
    id INT NOT NULL,
    menu_id INT NOT NULL,
    create_uid INT,
    write_uid INT,
    name VARCHAR(255) NOT NULL,
    create_date timestamp ,
    write_date timestamp 
);























ALTER TABLE ONLY account_analytic_account ALTER COLUMN id SET DEFAULT nextval(account_analytic_account_id_seq::regclass);




ALTER TABLE ONLY account_analytic_applicability ALTER COLUMN id SET DEFAULT nextval(account_analytic_applicability_id_seq::regclass);




ALTER TABLE ONLY account_analytic_distribution_model ALTER COLUMN id SET DEFAULT nextval(account_analytic_distribution_model_id_seq::regclass);




ALTER TABLE ONLY account_analytic_line ALTER COLUMN id SET DEFAULT nextval(account_analytic_line_id_seq::regclass);




ALTER TABLE ONLY account_analytic_plan ALTER COLUMN id SET DEFAULT nextval(account_analytic_plan_id_seq::regclass);




ALTER TABLE ONLY appointment_answer ALTER COLUMN id SET DEFAULT nextval(appointment_answer_id_seq::regclass);




ALTER TABLE ONLY appointment_answer_input ALTER COLUMN id SET DEFAULT nextval(appointment_answer_input_id_seq::regclass);




ALTER TABLE ONLY appointment_booking_line ALTER COLUMN id SET DEFAULT nextval(appointment_booking_line_id_seq::regclass);




ALTER TABLE ONLY appointment_invite ALTER COLUMN id SET DEFAULT nextval(appointment_invite_id_seq::regclass);




ALTER TABLE ONLY appointment_manage_leaves ALTER COLUMN id SET DEFAULT nextval(appointment_manage_leaves_id_seq::regclass);




ALTER TABLE ONLY appointment_question ALTER COLUMN id SET DEFAULT nextval(appointment_question_id_seq::regclass);




ALTER TABLE ONLY appointment_resource ALTER COLUMN id SET DEFAULT nextval(appointment_resource_id_seq::regclass);




ALTER TABLE ONLY appointment_slot ALTER COLUMN id SET DEFAULT nextval(appointment_slot_id_seq::regclass);




ALTER TABLE ONLY appointment_type ALTER COLUMN id SET DEFAULT nextval(appointment_type_id_seq::regclass);




ALTER TABLE ONLY auth_totp_device ALTER COLUMN id SET DEFAULT nextval(auth_totp_device_id_seq::regclass);




ALTER TABLE ONLY auth_totp_wizard ALTER COLUMN id SET DEFAULT nextval(auth_totp_wizard_id_seq::regclass);




ALTER TABLE ONLY barcode_nomenclature ALTER COLUMN id SET DEFAULT nextval(barcode_nomenclature_id_seq::regclass);




ALTER TABLE ONLY barcode_rule ALTER COLUMN id SET DEFAULT nextval(barcode_rule_id_seq::regclass);




ALTER TABLE ONLY base_document_layout ALTER COLUMN id SET DEFAULT nextval(base_document_layout_id_seq::regclass);




ALTER TABLE ONLY base_enable_profiling_wizard ALTER COLUMN id SET DEFAULT nextval(base_enable_profiling_wizard_id_seq::regclass);




ALTER TABLE ONLY base_import_import ALTER COLUMN id SET DEFAULT nextval(base_import_import_id_seq::regclass);




ALTER TABLE ONLY base_import_mapping ALTER COLUMN id SET DEFAULT nextval(base_import_mapping_id_seq::regclass);




ALTER TABLE ONLY base_import_module ALTER COLUMN id SET DEFAULT nextval(base_import_module_id_seq::regclass);




ALTER TABLE ONLY base_language_export ALTER COLUMN id SET DEFAULT nextval(base_language_export_id_seq::regclass);




ALTER TABLE ONLY base_language_import ALTER COLUMN id SET DEFAULT nextval(base_language_import_id_seq::regclass);




ALTER TABLE ONLY base_language_install ALTER COLUMN id SET DEFAULT nextval(base_language_install_id_seq::regclass);




ALTER TABLE ONLY base_module_install_request ALTER COLUMN id SET DEFAULT nextval(base_module_install_request_id_seq::regclass);




ALTER TABLE ONLY base_module_install_review ALTER COLUMN id SET DEFAULT nextval(base_module_install_review_id_seq::regclass);




ALTER TABLE ONLY base_module_uninstall ALTER COLUMN id SET DEFAULT nextval(base_module_uninstall_id_seq::regclass);




ALTER TABLE ONLY base_module_update ALTER COLUMN id SET DEFAULT nextval(base_module_update_id_seq::regclass);




ALTER TABLE ONLY base_module_upgrade ALTER COLUMN id SET DEFAULT nextval(base_module_upgrade_id_seq::regclass);




ALTER TABLE ONLY base_partner_merge_automatic_wizard ALTER COLUMN id SET DEFAULT nextval(base_partner_merge_automatic_wizard_id_seq::regclass);




ALTER TABLE ONLY base_partner_merge_line ALTER COLUMN id SET DEFAULT nextval(base_partner_merge_line_id_seq::regclass);




ALTER TABLE ONLY bus_bus ALTER COLUMN id SET DEFAULT nextval(bus_bus_id_seq::regclass);




ALTER TABLE ONLY bus_presence ALTER COLUMN id SET DEFAULT nextval(bus_presence_id_seq::regclass);




ALTER TABLE ONLY calendar_alarm ALTER COLUMN id SET DEFAULT nextval(calendar_alarm_id_seq::regclass);




ALTER TABLE ONLY calendar_attendee ALTER COLUMN id SET DEFAULT nextval(calendar_attendee_id_seq::regclass);




ALTER TABLE ONLY calendar_event ALTER COLUMN id SET DEFAULT nextval(calendar_event_id_seq::regclass);




ALTER TABLE ONLY calendar_event_type ALTER COLUMN id SET DEFAULT nextval(calendar_event_type_id_seq::regclass);




ALTER TABLE ONLY calendar_filters ALTER COLUMN id SET DEFAULT nextval(calendar_filters_id_seq::regclass);




ALTER TABLE ONLY calendar_popover_delete_wizard ALTER COLUMN id SET DEFAULT nextval(calendar_popover_delete_wizard_id_seq::regclass);




ALTER TABLE ONLY calendar_provider_config ALTER COLUMN id SET DEFAULT nextval(calendar_provider_config_id_seq::regclass);




ALTER TABLE ONLY calendar_recurrence ALTER COLUMN id SET DEFAULT nextval(calendar_recurrence_id_seq::regclass);




ALTER TABLE ONLY change_password_own ALTER COLUMN id SET DEFAULT nextval(change_password_own_id_seq::regclass);




ALTER TABLE ONLY change_password_user ALTER COLUMN id SET DEFAULT nextval(change_password_user_id_seq::regclass);




ALTER TABLE ONLY change_password_wizard ALTER COLUMN id SET DEFAULT nextval(change_password_wizard_id_seq::regclass);




ALTER TABLE ONLY decimal_precision ALTER COLUMN id SET DEFAULT nextval(decimal_precision_id_seq::regclass);




ALTER TABLE ONLY digest_digest ALTER COLUMN id SET DEFAULT nextval(digest_digest_id_seq::regclass);




ALTER TABLE ONLY digest_tip ALTER COLUMN id SET DEFAULT nextval(digest_tip_id_seq::regclass);




ALTER TABLE ONLY discuss_channel ALTER COLUMN id SET DEFAULT nextval(discuss_channel_id_seq::regclass);




ALTER TABLE ONLY discuss_channel_member ALTER COLUMN id SET DEFAULT nextval(discuss_channel_member_id_seq::regclass);




ALTER TABLE ONLY discuss_channel_rtc_session ALTER COLUMN id SET DEFAULT nextval(discuss_channel_rtc_session_id_seq::regclass);




ALTER TABLE ONLY discuss_gif_favorite ALTER COLUMN id SET DEFAULT nextval(discuss_gif_favorite_id_seq::regclass);




ALTER TABLE ONLY discuss_voice_metadata ALTER COLUMN id SET DEFAULT nextval(discuss_voice_metadata_id_seq::regclass);




ALTER TABLE ONLY event_event ALTER COLUMN id SET DEFAULT nextval(event_event_id_seq::regclass);




ALTER TABLE ONLY event_event_ticket ALTER COLUMN id SET DEFAULT nextval(event_event_ticket_id_seq::regclass);




ALTER TABLE ONLY event_mail ALTER COLUMN id SET DEFAULT nextval(event_mail_id_seq::regclass);




ALTER TABLE ONLY event_mail_registration ALTER COLUMN id SET DEFAULT nextval(event_mail_registration_id_seq::regclass);




ALTER TABLE ONLY event_question ALTER COLUMN id SET DEFAULT nextval(event_question_id_seq::regclass);




ALTER TABLE ONLY event_question_answer ALTER COLUMN id SET DEFAULT nextval(event_question_answer_id_seq::regclass);




ALTER TABLE ONLY event_registration ALTER COLUMN id SET DEFAULT nextval(event_registration_id_seq::regclass);




ALTER TABLE ONLY event_registration_answer ALTER COLUMN id SET DEFAULT nextval(event_registration_answer_id_seq::regclass);




ALTER TABLE ONLY event_stage ALTER COLUMN id SET DEFAULT nextval(event_stage_id_seq::regclass);




ALTER TABLE ONLY event_tag ALTER COLUMN id SET DEFAULT nextval(event_tag_id_seq::regclass);




ALTER TABLE ONLY event_tag_category ALTER COLUMN id SET DEFAULT nextval(event_tag_category_id_seq::regclass);




ALTER TABLE ONLY event_type ALTER COLUMN id SET DEFAULT nextval(event_type_id_seq::regclass);




ALTER TABLE ONLY event_type_mail ALTER COLUMN id SET DEFAULT nextval(event_type_mail_id_seq::regclass);




ALTER TABLE ONLY event_type_ticket ALTER COLUMN id SET DEFAULT nextval(event_type_ticket_id_seq::regclass);




ALTER TABLE ONLY fetchmail_server ALTER COLUMN id SET DEFAULT nextval(fetchmail_server_id_seq::regclass);




ALTER TABLE ONLY gamification_badge ALTER COLUMN id SET DEFAULT nextval(gamification_badge_id_seq::regclass);




ALTER TABLE ONLY gamification_badge_user ALTER COLUMN id SET DEFAULT nextval(gamification_badge_user_id_seq::regclass);




ALTER TABLE ONLY gamification_badge_user_wizard ALTER COLUMN id SET DEFAULT nextval(gamification_badge_user_wizard_id_seq::regclass);




ALTER TABLE ONLY gamification_challenge ALTER COLUMN id SET DEFAULT nextval(gamification_challenge_id_seq::regclass);




ALTER TABLE ONLY gamification_challenge_line ALTER COLUMN id SET DEFAULT nextval(gamification_challenge_line_id_seq::regclass);




ALTER TABLE ONLY gamification_goal ALTER COLUMN id SET DEFAULT nextval(gamification_goal_id_seq::regclass);




ALTER TABLE ONLY gamification_goal_definition ALTER COLUMN id SET DEFAULT nextval(gamification_goal_definition_id_seq::regclass);




ALTER TABLE ONLY gamification_goal_wizard ALTER COLUMN id SET DEFAULT nextval(gamification_goal_wizard_id_seq::regclass);




ALTER TABLE ONLY gamification_karma_rank ALTER COLUMN id SET DEFAULT nextval(gamification_karma_rank_id_seq::regclass);




ALTER TABLE ONLY gamification_karma_tracking ALTER COLUMN id SET DEFAULT nextval(gamification_karma_tracking_id_seq::regclass);




ALTER TABLE ONLY hr_contract_type ALTER COLUMN id SET DEFAULT nextval(hr_contract_type_id_seq::regclass);




ALTER TABLE ONLY hr_department ALTER COLUMN id SET DEFAULT nextval(hr_department_id_seq::regclass);




ALTER TABLE ONLY hr_departure_reason ALTER COLUMN id SET DEFAULT nextval(hr_departure_reason_id_seq::regclass);




ALTER TABLE ONLY hr_departure_wizard ALTER COLUMN id SET DEFAULT nextval(hr_departure_wizard_id_seq::regclass);




ALTER TABLE ONLY hr_employee ALTER COLUMN id SET DEFAULT nextval(hr_employee_id_seq::regclass);




ALTER TABLE ONLY hr_employee_category ALTER COLUMN id SET DEFAULT nextval(hr_employee_category_id_seq::regclass);




ALTER TABLE ONLY hr_employee_cv_wizard ALTER COLUMN id SET DEFAULT nextval(hr_employee_cv_wizard_id_seq::regclass);




ALTER TABLE ONLY hr_employee_skill ALTER COLUMN id SET DEFAULT nextval(hr_employee_skill_id_seq::regclass);




ALTER TABLE ONLY hr_employee_skill_log ALTER COLUMN id SET DEFAULT nextval(hr_employee_skill_log_id_seq::regclass);




ALTER TABLE ONLY hr_job ALTER COLUMN id SET DEFAULT nextval(hr_job_id_seq::regclass);




ALTER TABLE ONLY hr_resume_line ALTER COLUMN id SET DEFAULT nextval(hr_resume_line_id_seq::regclass);




ALTER TABLE ONLY hr_resume_line_type ALTER COLUMN id SET DEFAULT nextval(hr_resume_line_type_id_seq::regclass);




ALTER TABLE ONLY hr_skill ALTER COLUMN id SET DEFAULT nextval(hr_skill_id_seq::regclass);




ALTER TABLE ONLY hr_skill_level ALTER COLUMN id SET DEFAULT nextval(hr_skill_level_id_seq::regclass);




ALTER TABLE ONLY hr_skill_type ALTER COLUMN id SET DEFAULT nextval(hr_skill_type_id_seq::regclass);




ALTER TABLE ONLY hr_work_location ALTER COLUMN id SET DEFAULT nextval(hr_work_location_id_seq::regclass);




ALTER TABLE ONLY iap_account ALTER COLUMN id SET DEFAULT nextval(iap_account_id_seq::regclass);




ALTER TABLE ONLY iap_account_info ALTER COLUMN id SET DEFAULT nextval(iap_account_info_id_seq::regclass);




ALTER TABLE ONLY ir_act_client ALTER COLUMN id SET DEFAULT nextval(ir_actions_id_seq::regclass);




ALTER TABLE ONLY ir_act_report_xml ALTER COLUMN id SET DEFAULT nextval(ir_actions_id_seq::regclass);




ALTER TABLE ONLY ir_act_server ALTER COLUMN id SET DEFAULT nextval(ir_actions_id_seq::regclass);




ALTER TABLE ONLY ir_act_url ALTER COLUMN id SET DEFAULT nextval(ir_actions_id_seq::regclass);




ALTER TABLE ONLY ir_act_window ALTER COLUMN id SET DEFAULT nextval(ir_actions_id_seq::regclass);




ALTER TABLE ONLY ir_act_window_view ALTER COLUMN id SET DEFAULT nextval(ir_act_window_view_id_seq::regclass);




ALTER TABLE ONLY ir_actions ALTER COLUMN id SET DEFAULT nextval(ir_actions_id_seq::regclass);




ALTER TABLE ONLY ir_actions_todo ALTER COLUMN id SET DEFAULT nextval(ir_actions_todo_id_seq::regclass);




ALTER TABLE ONLY ir_asset ALTER COLUMN id SET DEFAULT nextval(ir_asset_id_seq::regclass);




ALTER TABLE ONLY ir_attachment ALTER COLUMN id SET DEFAULT nextval(ir_attachment_id_seq::regclass);




ALTER TABLE ONLY ir_config_parameter ALTER COLUMN id SET DEFAULT nextval(ir_config_parameter_id_seq::regclass);




ALTER TABLE ONLY ir_cron ALTER COLUMN id SET DEFAULT nextval(ir_cron_id_seq::regclass);




ALTER TABLE ONLY ir_cron_trigger ALTER COLUMN id SET DEFAULT nextval(ir_cron_trigger_id_seq::regclass);




ALTER TABLE ONLY ir_default ALTER COLUMN id SET DEFAULT nextval(ir_default_id_seq::regclass);




ALTER TABLE ONLY ir_demo ALTER COLUMN id SET DEFAULT nextval(ir_demo_id_seq::regclass);




ALTER TABLE ONLY ir_demo_failure ALTER COLUMN id SET DEFAULT nextval(ir_demo_failure_id_seq::regclass);




ALTER TABLE ONLY ir_demo_failure_wizard ALTER COLUMN id SET DEFAULT nextval(ir_demo_failure_wizard_id_seq::regclass);




ALTER TABLE ONLY ir_exports ALTER COLUMN id SET DEFAULT nextval(ir_exports_id_seq::regclass);




ALTER TABLE ONLY ir_exports_line ALTER COLUMN id SET DEFAULT nextval(ir_exports_line_id_seq::regclass);




ALTER TABLE ONLY ir_filters ALTER COLUMN id SET DEFAULT nextval(ir_filters_id_seq::regclass);




ALTER TABLE ONLY ir_logging ALTER COLUMN id SET DEFAULT nextval(ir_logging_id_seq::regclass);




ALTER TABLE ONLY ir_mail_server ALTER COLUMN id SET DEFAULT nextval(ir_mail_server_id_seq::regclass);




ALTER TABLE ONLY ir_model ALTER COLUMN id SET DEFAULT nextval(ir_model_id_seq::regclass);




ALTER TABLE ONLY ir_model_access ALTER COLUMN id SET DEFAULT nextval(ir_model_access_id_seq::regclass);




ALTER TABLE ONLY ir_model_constraint ALTER COLUMN id SET DEFAULT nextval(ir_model_constraint_id_seq::regclass);




ALTER TABLE ONLY ir_model_data ALTER COLUMN id SET DEFAULT nextval(ir_model_data_id_seq::regclass);




ALTER TABLE ONLY ir_model_fields ALTER COLUMN id SET DEFAULT nextval(ir_model_fields_id_seq::regclass);




ALTER TABLE ONLY ir_model_fields_selection ALTER COLUMN id SET DEFAULT nextval(ir_model_fields_selection_id_seq::regclass);




ALTER TABLE ONLY ir_model_inherit ALTER COLUMN id SET DEFAULT nextval(ir_model_inherit_id_seq::regclass);




ALTER TABLE ONLY ir_model_relation ALTER COLUMN id SET DEFAULT nextval(ir_model_relation_id_seq::regclass);




ALTER TABLE ONLY ir_module_category ALTER COLUMN id SET DEFAULT nextval(ir_module_category_id_seq::regclass);




ALTER TABLE ONLY ir_module_module ALTER COLUMN id SET DEFAULT nextval(ir_module_module_id_seq::regclass);




ALTER TABLE ONLY ir_module_module_dependency ALTER COLUMN id SET DEFAULT nextval(ir_module_module_dependency_id_seq::regclass);




ALTER TABLE ONLY ir_module_module_exclusion ALTER COLUMN id SET DEFAULT nextval(ir_module_module_exclusion_id_seq::regclass);




ALTER TABLE ONLY ir_profile ALTER COLUMN id SET DEFAULT nextval(ir_profile_id_seq::regclass);




ALTER TABLE ONLY ir_property ALTER COLUMN id SET DEFAULT nextval(ir_property_id_seq::regclass);




ALTER TABLE ONLY ir_rule ALTER COLUMN id SET DEFAULT nextval(ir_rule_id_seq::regclass);




ALTER TABLE ONLY ir_sequence ALTER COLUMN id SET DEFAULT nextval(ir_sequence_id_seq::regclass);




ALTER TABLE ONLY ir_sequence_date_range ALTER COLUMN id SET DEFAULT nextval(ir_sequence_date_range_id_seq::regclass);




ALTER TABLE ONLY ir_ui_menu ALTER COLUMN id SET DEFAULT nextval(ir_ui_menu_id_seq::regclass);




ALTER TABLE ONLY ir_ui_view ALTER COLUMN id SET DEFAULT nextval(ir_ui_view_id_seq::regclass);




ALTER TABLE ONLY ir_ui_view_custom ALTER COLUMN id SET DEFAULT nextval(ir_ui_view_custom_id_seq::regclass);




ALTER TABLE ONLY knowledge_article ALTER COLUMN id SET DEFAULT nextval(knowledge_article_id_seq::regclass);




ALTER TABLE ONLY knowledge_article_favorite ALTER COLUMN id SET DEFAULT nextval(knowledge_article_favorite_id_seq::regclass);




ALTER TABLE ONLY knowledge_article_member ALTER COLUMN id SET DEFAULT nextval(knowledge_article_member_id_seq::regclass);




ALTER TABLE ONLY knowledge_article_stage ALTER COLUMN id SET DEFAULT nextval(knowledge_article_stage_id_seq::regclass);




ALTER TABLE ONLY knowledge_article_template_category ALTER COLUMN id SET DEFAULT nextval(knowledge_article_template_category_id_seq::regclass);




ALTER TABLE ONLY knowledge_article_thread ALTER COLUMN id SET DEFAULT nextval(knowledge_article_thread_id_seq::regclass);




ALTER TABLE ONLY knowledge_cover ALTER COLUMN id SET DEFAULT nextval(knowledge_cover_id_seq::regclass);




ALTER TABLE ONLY knowledge_invite ALTER COLUMN id SET DEFAULT nextval(knowledge_invite_id_seq::regclass);




ALTER TABLE ONLY link_tracker ALTER COLUMN id SET DEFAULT nextval(link_tracker_id_seq::regclass);




ALTER TABLE ONLY link_tracker_click ALTER COLUMN id SET DEFAULT nextval(link_tracker_click_id_seq::regclass);




ALTER TABLE ONLY link_tracker_code ALTER COLUMN id SET DEFAULT nextval(link_tracker_code_id_seq::regclass);




ALTER TABLE ONLY mail_activity ALTER COLUMN id SET DEFAULT nextval(mail_activity_id_seq::regclass);




ALTER TABLE ONLY mail_activity_plan ALTER COLUMN id SET DEFAULT nextval(mail_activity_plan_id_seq::regclass);




ALTER TABLE ONLY mail_activity_plan_template ALTER COLUMN id SET DEFAULT nextval(mail_activity_plan_template_id_seq::regclass);




ALTER TABLE ONLY mail_activity_schedule ALTER COLUMN id SET DEFAULT nextval(mail_activity_schedule_id_seq::regclass);




ALTER TABLE ONLY mail_activity_todo_create ALTER COLUMN id SET DEFAULT nextval(mail_activity_todo_create_id_seq::regclass);




ALTER TABLE ONLY mail_activity_type ALTER COLUMN id SET DEFAULT nextval(mail_activity_type_id_seq::regclass);




ALTER TABLE ONLY mail_alias ALTER COLUMN id SET DEFAULT nextval(mail_alias_id_seq::regclass);




ALTER TABLE ONLY mail_alias_domain ALTER COLUMN id SET DEFAULT nextval(mail_alias_domain_id_seq::regclass);




ALTER TABLE ONLY mail_blacklist ALTER COLUMN id SET DEFAULT nextval(mail_blacklist_id_seq::regclass);




ALTER TABLE ONLY mail_blacklist_remove ALTER COLUMN id SET DEFAULT nextval(mail_blacklist_remove_id_seq::regclass);




ALTER TABLE ONLY mail_canned_response ALTER COLUMN id SET DEFAULT nextval(mail_canned_response_id_seq::regclass);




ALTER TABLE ONLY mail_compose_message ALTER COLUMN id SET DEFAULT nextval(mail_compose_message_id_seq::regclass);




ALTER TABLE ONLY mail_followers ALTER COLUMN id SET DEFAULT nextval(mail_followers_id_seq::regclass);




ALTER TABLE ONLY mail_gateway_allowed ALTER COLUMN id SET DEFAULT nextval(mail_gateway_allowed_id_seq::regclass);




ALTER TABLE ONLY mail_guest ALTER COLUMN id SET DEFAULT nextval(mail_guest_id_seq::regclass);




ALTER TABLE ONLY mail_ice_server ALTER COLUMN id SET DEFAULT nextval(mail_ice_server_id_seq::regclass);




ALTER TABLE ONLY mail_link_preview ALTER COLUMN id SET DEFAULT nextval(mail_link_preview_id_seq::regclass);




ALTER TABLE ONLY mail_mail ALTER COLUMN id SET DEFAULT nextval(mail_mail_id_seq::regclass);




ALTER TABLE ONLY mail_message ALTER COLUMN id SET DEFAULT nextval(mail_message_id_seq::regclass);




ALTER TABLE ONLY mail_message_reaction ALTER COLUMN id SET DEFAULT nextval(mail_message_reaction_id_seq::regclass);




ALTER TABLE ONLY mail_message_schedule ALTER COLUMN id SET DEFAULT nextval(mail_message_schedule_id_seq::regclass);




ALTER TABLE ONLY mail_message_subtype ALTER COLUMN id SET DEFAULT nextval(mail_message_subtype_id_seq::regclass);




ALTER TABLE ONLY mail_message_translation ALTER COLUMN id SET DEFAULT nextval(mail_message_translation_id_seq::regclass);




ALTER TABLE ONLY mail_notification ALTER COLUMN id SET DEFAULT nextval(mail_notification_id_seq::regclass);




ALTER TABLE ONLY mail_push ALTER COLUMN id SET DEFAULT nextval(mail_push_id_seq::regclass);




ALTER TABLE ONLY mail_push_device ALTER COLUMN id SET DEFAULT nextval(mail_push_device_id_seq::regclass);




ALTER TABLE ONLY mail_resend_message ALTER COLUMN id SET DEFAULT nextval(mail_resend_message_id_seq::regclass);




ALTER TABLE ONLY mail_resend_partner ALTER COLUMN id SET DEFAULT nextval(mail_resend_partner_id_seq::regclass);




ALTER TABLE ONLY mail_template ALTER COLUMN id SET DEFAULT nextval(mail_template_id_seq::regclass);




ALTER TABLE ONLY mail_template_preview ALTER COLUMN id SET DEFAULT nextval(mail_template_preview_id_seq::regclass);




ALTER TABLE ONLY mail_template_reset ALTER COLUMN id SET DEFAULT nextval(mail_template_reset_id_seq::regclass);




ALTER TABLE ONLY mail_tracking_value ALTER COLUMN id SET DEFAULT nextval(mail_tracking_value_id_seq::regclass);




ALTER TABLE ONLY mail_wizard_invite ALTER COLUMN id SET DEFAULT nextval(mail_wizard_invite_id_seq::regclass);




ALTER TABLE ONLY mailing_contact ALTER COLUMN id SET DEFAULT nextval(mailing_contact_id_seq::regclass);




ALTER TABLE ONLY mailing_contact_import ALTER COLUMN id SET DEFAULT nextval(mailing_contact_import_id_seq::regclass);




ALTER TABLE ONLY mailing_contact_to_list ALTER COLUMN id SET DEFAULT nextval(mailing_contact_to_list_id_seq::regclass);




ALTER TABLE ONLY mailing_filter ALTER COLUMN id SET DEFAULT nextval(mailing_filter_id_seq::regclass);




ALTER TABLE ONLY mailing_list ALTER COLUMN id SET DEFAULT nextval(mailing_list_id_seq::regclass);




ALTER TABLE ONLY mailing_list_merge ALTER COLUMN id SET DEFAULT nextval(mailing_list_merge_id_seq::regclass);




ALTER TABLE ONLY mailing_mailing ALTER COLUMN id SET DEFAULT nextval(mailing_mailing_id_seq::regclass);




ALTER TABLE ONLY mailing_mailing_schedule_date ALTER COLUMN id SET DEFAULT nextval(mailing_mailing_schedule_date_id_seq::regclass);




ALTER TABLE ONLY mailing_mailing_test ALTER COLUMN id SET DEFAULT nextval(mailing_mailing_test_id_seq::regclass);




ALTER TABLE ONLY mailing_sms_test ALTER COLUMN id SET DEFAULT nextval(mailing_sms_test_id_seq::regclass);




ALTER TABLE ONLY mailing_subscription ALTER COLUMN id SET DEFAULT nextval(mailing_subscription_id_seq::regclass);




ALTER TABLE ONLY mailing_subscription_optout ALTER COLUMN id SET DEFAULT nextval(mailing_subscription_optout_id_seq::regclass);




ALTER TABLE ONLY mailing_trace ALTER COLUMN id SET DEFAULT nextval(mailing_trace_id_seq::regclass);




ALTER TABLE ONLY marketing_activity ALTER COLUMN id SET DEFAULT nextval(marketing_activity_id_seq::regclass);




ALTER TABLE ONLY marketing_campaign ALTER COLUMN id SET DEFAULT nextval(marketing_campaign_id_seq::regclass);




ALTER TABLE ONLY marketing_campaign_test ALTER COLUMN id SET DEFAULT nextval(marketing_campaign_test_id_seq::regclass);




ALTER TABLE ONLY marketing_participant ALTER COLUMN id SET DEFAULT nextval(marketing_participant_id_seq::regclass);




ALTER TABLE ONLY marketing_trace ALTER COLUMN id SET DEFAULT nextval(marketing_trace_id_seq::regclass);




ALTER TABLE ONLY phone_blacklist ALTER COLUMN id SET DEFAULT nextval(phone_blacklist_id_seq::regclass);




ALTER TABLE ONLY phone_blacklist_remove ALTER COLUMN id SET DEFAULT nextval(phone_blacklist_remove_id_seq::regclass);




ALTER TABLE ONLY planning_planning ALTER COLUMN id SET DEFAULT nextval(planning_planning_id_seq::regclass);




ALTER TABLE ONLY planning_recurrency ALTER COLUMN id SET DEFAULT nextval(planning_recurrency_id_seq::regclass);




ALTER TABLE ONLY planning_role ALTER COLUMN id SET DEFAULT nextval(planning_role_id_seq::regclass);




ALTER TABLE ONLY planning_send ALTER COLUMN id SET DEFAULT nextval(planning_send_id_seq::regclass);




ALTER TABLE ONLY planning_slot ALTER COLUMN id SET DEFAULT nextval(planning_slot_id_seq::regclass);




ALTER TABLE ONLY planning_slot_template ALTER COLUMN id SET DEFAULT nextval(planning_slot_template_id_seq::regclass);




ALTER TABLE ONLY portal_share ALTER COLUMN id SET DEFAULT nextval(portal_share_id_seq::regclass);




ALTER TABLE ONLY portal_wizard ALTER COLUMN id SET DEFAULT nextval(portal_wizard_id_seq::regclass);




ALTER TABLE ONLY portal_wizard_user ALTER COLUMN id SET DEFAULT nextval(portal_wizard_user_id_seq::regclass);




ALTER TABLE ONLY privacy_log ALTER COLUMN id SET DEFAULT nextval(privacy_log_id_seq::regclass);




ALTER TABLE ONLY privacy_lookup_wizard ALTER COLUMN id SET DEFAULT nextval(privacy_lookup_wizard_id_seq::regclass);




ALTER TABLE ONLY privacy_lookup_wizard_line ALTER COLUMN id SET DEFAULT nextval(privacy_lookup_wizard_line_id_seq::regclass);




ALTER TABLE ONLY project_collaborator ALTER COLUMN id SET DEFAULT nextval(project_collaborator_id_seq::regclass);




ALTER TABLE ONLY project_milestone ALTER COLUMN id SET DEFAULT nextval(project_milestone_id_seq::regclass);




ALTER TABLE ONLY project_project ALTER COLUMN id SET DEFAULT nextval(project_project_id_seq::regclass);




ALTER TABLE ONLY project_project_stage ALTER COLUMN id SET DEFAULT nextval(project_project_stage_id_seq::regclass);




ALTER TABLE ONLY project_project_stage_delete_wizard ALTER COLUMN id SET DEFAULT nextval(project_project_stage_delete_wizard_id_seq::regclass);




ALTER TABLE ONLY project_share_wizard ALTER COLUMN id SET DEFAULT nextval(project_share_wizard_id_seq::regclass);




ALTER TABLE ONLY project_tags ALTER COLUMN id SET DEFAULT nextval(project_tags_id_seq::regclass);




ALTER TABLE ONLY project_task ALTER COLUMN id SET DEFAULT nextval(project_task_id_seq::regclass);




ALTER TABLE ONLY project_task_recurrence ALTER COLUMN id SET DEFAULT nextval(project_task_recurrence_id_seq::regclass);




ALTER TABLE ONLY project_task_type ALTER COLUMN id SET DEFAULT nextval(project_task_type_id_seq::regclass);




ALTER TABLE ONLY project_task_type_delete_wizard ALTER COLUMN id SET DEFAULT nextval(project_task_type_delete_wizard_id_seq::regclass);




ALTER TABLE ONLY project_task_user_rel ALTER COLUMN id SET DEFAULT nextval(project_task_user_rel_id_seq::regclass);




ALTER TABLE ONLY project_update ALTER COLUMN id SET DEFAULT nextval(project_update_id_seq::regclass);




ALTER TABLE ONLY rating_rating ALTER COLUMN id SET DEFAULT nextval(rating_rating_id_seq::regclass);




ALTER TABLE ONLY report_layout ALTER COLUMN id SET DEFAULT nextval(report_layout_id_seq::regclass);




ALTER TABLE ONLY report_paperformat ALTER COLUMN id SET DEFAULT nextval(report_paperformat_id_seq::regclass);




ALTER TABLE ONLY res_bank ALTER COLUMN id SET DEFAULT nextval(res_bank_id_seq::regclass);




ALTER TABLE ONLY res_company ALTER COLUMN id SET DEFAULT nextval(res_company_id_seq::regclass);




ALTER TABLE ONLY res_config ALTER COLUMN id SET DEFAULT nextval(res_config_id_seq::regclass);




ALTER TABLE ONLY res_config_installer ALTER COLUMN id SET DEFAULT nextval(res_config_installer_id_seq::regclass);




ALTER TABLE ONLY res_config_settings ALTER COLUMN id SET DEFAULT nextval(res_config_settings_id_seq::regclass);




ALTER TABLE ONLY res_country ALTER COLUMN id SET DEFAULT nextval(res_country_id_seq::regclass);




ALTER TABLE ONLY res_country_group ALTER COLUMN id SET DEFAULT nextval(res_country_group_id_seq::regclass);




ALTER TABLE ONLY res_country_state ALTER COLUMN id SET DEFAULT nextval(res_country_state_id_seq::regclass);




ALTER TABLE ONLY res_currency ALTER COLUMN id SET DEFAULT nextval(res_currency_id_seq::regclass);




ALTER TABLE ONLY res_currency_rate ALTER COLUMN id SET DEFAULT nextval(res_currency_rate_id_seq::regclass);




ALTER TABLE ONLY res_groups ALTER COLUMN id SET DEFAULT nextval(res_groups_id_seq::regclass);




ALTER TABLE ONLY res_lang ALTER COLUMN id SET DEFAULT nextval(res_lang_id_seq::regclass);




ALTER TABLE ONLY res_partner ALTER COLUMN id SET DEFAULT nextval(res_partner_id_seq::regclass);




ALTER TABLE ONLY res_partner_autocomplete_sync ALTER COLUMN id SET DEFAULT nextval(res_partner_autocomplete_sync_id_seq::regclass);




ALTER TABLE ONLY res_partner_bank ALTER COLUMN id SET DEFAULT nextval(res_partner_bank_id_seq::regclass);




ALTER TABLE ONLY res_partner_category ALTER COLUMN id SET DEFAULT nextval(res_partner_category_id_seq::regclass);




ALTER TABLE ONLY res_partner_industry ALTER COLUMN id SET DEFAULT nextval(res_partner_industry_id_seq::regclass);




ALTER TABLE ONLY res_partner_title ALTER COLUMN id SET DEFAULT nextval(res_partner_title_id_seq::regclass);




ALTER TABLE ONLY res_users ALTER COLUMN id SET DEFAULT nextval(res_users_id_seq::regclass);




ALTER TABLE ONLY res_users_apikeys ALTER COLUMN id SET DEFAULT nextval(res_users_apikeys_id_seq::regclass);




ALTER TABLE ONLY res_users_apikeys_description ALTER COLUMN id SET DEFAULT nextval(res_users_apikeys_description_id_seq::regclass);




ALTER TABLE ONLY res_users_deletion ALTER COLUMN id SET DEFAULT nextval(res_users_deletion_id_seq::regclass);




ALTER TABLE ONLY res_users_identitycheck ALTER COLUMN id SET DEFAULT nextval(res_users_identitycheck_id_seq::regclass);




ALTER TABLE ONLY res_users_log ALTER COLUMN id SET DEFAULT nextval(res_users_log_id_seq::regclass);




ALTER TABLE ONLY res_users_settings ALTER COLUMN id SET DEFAULT nextval(res_users_settings_id_seq::regclass);




ALTER TABLE ONLY res_users_settings_volumes ALTER COLUMN id SET DEFAULT nextval(res_users_settings_volumes_id_seq::regclass);




ALTER TABLE ONLY reset_view_arch_wizard ALTER COLUMN id SET DEFAULT nextval(reset_view_arch_wizard_id_seq::regclass);




ALTER TABLE ONLY resource_calendar ALTER COLUMN id SET DEFAULT nextval(resource_calendar_id_seq::regclass);




ALTER TABLE ONLY resource_calendar_attendance ALTER COLUMN id SET DEFAULT nextval(resource_calendar_attendance_id_seq::regclass);




ALTER TABLE ONLY resource_calendar_leaves ALTER COLUMN id SET DEFAULT nextval(resource_calendar_leaves_id_seq::regclass);




ALTER TABLE ONLY resource_resource ALTER COLUMN id SET DEFAULT nextval(resource_resource_id_seq::regclass);




ALTER TABLE ONLY sign_duplicate_template_pdf ALTER COLUMN id SET DEFAULT nextval(sign_duplicate_template_pdf_id_seq::regclass);




ALTER TABLE ONLY sign_item ALTER COLUMN id SET DEFAULT nextval(sign_item_id_seq::regclass);




ALTER TABLE ONLY sign_item_option ALTER COLUMN id SET DEFAULT nextval(sign_item_option_id_seq::regclass);




ALTER TABLE ONLY sign_item_role ALTER COLUMN id SET DEFAULT nextval(sign_item_role_id_seq::regclass);




ALTER TABLE ONLY sign_item_type ALTER COLUMN id SET DEFAULT nextval(sign_item_type_id_seq::regclass);




ALTER TABLE ONLY sign_log ALTER COLUMN id SET DEFAULT nextval(sign_log_id_seq::regclass);




ALTER TABLE ONLY sign_request ALTER COLUMN id SET DEFAULT nextval(sign_request_id_seq::regclass);




ALTER TABLE ONLY sign_request_item ALTER COLUMN id SET DEFAULT nextval(sign_request_item_id_seq::regclass);




ALTER TABLE ONLY sign_request_item_value ALTER COLUMN id SET DEFAULT nextval(sign_request_item_value_id_seq::regclass);




ALTER TABLE ONLY sign_send_request ALTER COLUMN id SET DEFAULT nextval(sign_send_request_id_seq::regclass);




ALTER TABLE ONLY sign_send_request_signer ALTER COLUMN id SET DEFAULT nextval(sign_send_request_signer_id_seq::regclass);




ALTER TABLE ONLY sign_template ALTER COLUMN id SET DEFAULT nextval(sign_template_id_seq::regclass);




ALTER TABLE ONLY sign_template_tag ALTER COLUMN id SET DEFAULT nextval(sign_template_tag_id_seq::regclass);




ALTER TABLE ONLY sms_composer ALTER COLUMN id SET DEFAULT nextval(sms_composer_id_seq::regclass);




ALTER TABLE ONLY sms_resend ALTER COLUMN id SET DEFAULT nextval(sms_resend_id_seq::regclass);




ALTER TABLE ONLY sms_resend_recipient ALTER COLUMN id SET DEFAULT nextval(sms_resend_recipient_id_seq::regclass);




ALTER TABLE ONLY sms_sms ALTER COLUMN id SET DEFAULT nextval(sms_sms_id_seq::regclass);




ALTER TABLE ONLY sms_template ALTER COLUMN id SET DEFAULT nextval(sms_template_id_seq::regclass);




ALTER TABLE ONLY sms_template_preview ALTER COLUMN id SET DEFAULT nextval(sms_template_preview_id_seq::regclass);




ALTER TABLE ONLY sms_template_reset ALTER COLUMN id SET DEFAULT nextval(sms_template_reset_id_seq::regclass);




ALTER TABLE ONLY sms_tracker ALTER COLUMN id SET DEFAULT nextval(sms_tracker_id_seq::regclass);




ALTER TABLE ONLY snailmail_letter ALTER COLUMN id SET DEFAULT nextval(snailmail_letter_id_seq::regclass);




ALTER TABLE ONLY snailmail_letter_format_error ALTER COLUMN id SET DEFAULT nextval(snailmail_letter_format_error_id_seq::regclass);




ALTER TABLE ONLY snailmail_letter_missing_required_fields ALTER COLUMN id SET DEFAULT nextval(snailmail_letter_missing_required_fields_id_seq::regclass);




ALTER TABLE ONLY social_account ALTER COLUMN id SET DEFAULT nextval(social_account_id_seq::regclass);




ALTER TABLE ONLY social_account_revoke_youtube ALTER COLUMN id SET DEFAULT nextval(social_account_revoke_youtube_id_seq::regclass);




ALTER TABLE ONLY social_live_post ALTER COLUMN id SET DEFAULT nextval(social_live_post_id_seq::regclass);




ALTER TABLE ONLY social_media ALTER COLUMN id SET DEFAULT nextval(social_media_id_seq::regclass);




ALTER TABLE ONLY social_post ALTER COLUMN id SET DEFAULT nextval(social_post_id_seq::regclass);




ALTER TABLE ONLY social_post_template ALTER COLUMN id SET DEFAULT nextval(social_post_template_id_seq::regclass);




ALTER TABLE ONLY social_stream ALTER COLUMN id SET DEFAULT nextval(social_stream_id_seq::regclass);




ALTER TABLE ONLY social_stream_post ALTER COLUMN id SET DEFAULT nextval(social_stream_post_id_seq::regclass);




ALTER TABLE ONLY social_stream_post_image ALTER COLUMN id SET DEFAULT nextval(social_stream_post_image_id_seq::regclass);




ALTER TABLE ONLY social_stream_type ALTER COLUMN id SET DEFAULT nextval(social_stream_type_id_seq::regclass);




ALTER TABLE ONLY social_twitter_account ALTER COLUMN id SET DEFAULT nextval(social_twitter_account_id_seq::regclass);




ALTER TABLE ONLY survey_invite ALTER COLUMN id SET DEFAULT nextval(survey_invite_id_seq::regclass);




ALTER TABLE ONLY survey_question ALTER COLUMN id SET DEFAULT nextval(survey_question_id_seq::regclass);




ALTER TABLE ONLY survey_question_answer ALTER COLUMN id SET DEFAULT nextval(survey_question_answer_id_seq::regclass);




ALTER TABLE ONLY survey_survey ALTER COLUMN id SET DEFAULT nextval(survey_survey_id_seq::regclass);




ALTER TABLE ONLY survey_user_input ALTER COLUMN id SET DEFAULT nextval(survey_user_input_id_seq::regclass);




ALTER TABLE ONLY survey_user_input_line ALTER COLUMN id SET DEFAULT nextval(survey_user_input_line_id_seq::regclass);




ALTER TABLE ONLY theme_ir_asset ALTER COLUMN id SET DEFAULT nextval(theme_ir_asset_id_seq::regclass);




ALTER TABLE ONLY theme_ir_attachment ALTER COLUMN id SET DEFAULT nextval(theme_ir_attachment_id_seq::regclass);




ALTER TABLE ONLY theme_ir_ui_view ALTER COLUMN id SET DEFAULT nextval(theme_ir_ui_view_id_seq::regclass);




ALTER TABLE ONLY theme_website_menu ALTER COLUMN id SET DEFAULT nextval(theme_website_menu_id_seq::regclass);




ALTER TABLE ONLY theme_website_page ALTER COLUMN id SET DEFAULT nextval(theme_website_page_id_seq::regclass);




ALTER TABLE ONLY uom_category ALTER COLUMN id SET DEFAULT nextval(uom_category_id_seq::regclass);




ALTER TABLE ONLY uom_uom ALTER COLUMN id SET DEFAULT nextval(uom_uom_id_seq::regclass);




ALTER TABLE ONLY utm_campaign ALTER COLUMN id SET DEFAULT nextval(utm_campaign_id_seq::regclass);




ALTER TABLE ONLY utm_medium ALTER COLUMN id SET DEFAULT nextval(utm_medium_id_seq::regclass);




ALTER TABLE ONLY utm_source ALTER COLUMN id SET DEFAULT nextval(utm_source_id_seq::regclass);




ALTER TABLE ONLY utm_stage ALTER COLUMN id SET DEFAULT nextval(utm_stage_id_seq::regclass);




ALTER TABLE ONLY utm_tag ALTER COLUMN id SET DEFAULT nextval(utm_tag_id_seq::regclass);




ALTER TABLE ONLY web_editor_converter_test ALTER COLUMN id SET DEFAULT nextval(web_editor_converter_test_id_seq::regclass);




ALTER TABLE ONLY web_editor_converter_test_sub ALTER COLUMN id SET DEFAULT nextval(web_editor_converter_test_sub_id_seq::regclass);




ALTER TABLE ONLY web_tour_tour ALTER COLUMN id SET DEFAULT nextval(web_tour_tour_id_seq::regclass);




ALTER TABLE ONLY website ALTER COLUMN id SET DEFAULT nextval(website_id_seq::regclass);




ALTER TABLE ONLY website_configurator_feature ALTER COLUMN id SET DEFAULT nextval(website_configurator_feature_id_seq::regclass);




ALTER TABLE ONLY website_controller_page ALTER COLUMN id SET DEFAULT nextval(website_controller_page_id_seq::regclass);




ALTER TABLE ONLY website_event_menu ALTER COLUMN id SET DEFAULT nextval(website_event_menu_id_seq::regclass);




ALTER TABLE ONLY website_menu ALTER COLUMN id SET DEFAULT nextval(website_menu_id_seq::regclass);




ALTER TABLE ONLY website_page ALTER COLUMN id SET DEFAULT nextval(website_page_id_seq::regclass);




ALTER TABLE ONLY website_rewrite ALTER COLUMN id SET DEFAULT nextval(website_rewrite_id_seq::regclass);




ALTER TABLE ONLY website_robots ALTER COLUMN id SET DEFAULT nextval(website_robots_id_seq::regclass);




ALTER TABLE ONLY website_route ALTER COLUMN id SET DEFAULT nextval(website_route_id_seq::regclass);




ALTER TABLE ONLY website_snippet_filter ALTER COLUMN id SET DEFAULT nextval(website_snippet_filter_id_seq::regclass);




ALTER TABLE ONLY website_track ALTER COLUMN id SET DEFAULT nextval(website_track_id_seq::regclass);




ALTER TABLE ONLY website_visitor ALTER COLUMN id SET DEFAULT nextval(website_visitor_id_seq::regclass);




ALTER TABLE ONLY website_visitor_push_subscription ALTER COLUMN id SET DEFAULT nextval(website_visitor_push_subscription_id_seq::regclass);




ALTER TABLE ONLY wizard_ir_model_menu_create ALTER COLUMN id SET DEFAULT nextval(wizard_ir_model_menu_create_id_seq::regclass);

