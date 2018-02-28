# Validate hospital and unique ids

if (exists("hosp_to_validate", envir = environment())) {
  if (!isTRUE(data_missing(hosp_to_validate))) {
    if (isTRUE(is_int(hosp_to_validate))) {
      hosp_to_validate = as.integer(hosp_to_validate)
      if (!isTRUE(data_missing(hosp_id))) {
        if (!isTRUE(hosp_id %in% hosp_to_validate)) {
          form__x2014cin = c(form__x2014cin, "Biodata")
          name__x2014cin = c(name__x2014cin, "hosp_to_validate")
          msg__x2014cin = c (msg__x2014cin, "Invalid Hospital ID [hosp_id] (does not match hospital)!")
          sect__x2014cin = c(sect__x2014cin, "")
          type__x2014cin = c(type__x2014cin, "")
          entry__x2014cin = c(entry__x2014cin, "")
        }
      }
      if (!isTRUE(data_missing (id))) {
        if (isTRUE(nchar(id) > 6L)) {
          if (isTRUE(!as.integer(substr(id, 1L, 2L)) %in% hosp_to_validate)) {
            form__x2014cin = c(form__x2014cin, "Biodata")
            name__x2014cin = c(name__x2014cin, "id")
            msg__x2014cin = c(msg__x2014cin, "Invalid Unique ID [id] (does not match hospital)!")
            sect__x2014cin = c(sect__x2014cin, "")
            type__x2014cin = c(type__x2014cin, "")
            entry__x2014cin = c(entry__x2014cin, "")
          }
        } else {
          form__x2014cin = c(form__x2014cin, "Biodata")
          name__x2014cin = c(name__x2014cin, "id")
          sect__x2014cin = c(sect__x2014cin, "")
          type__x2014cin = c(type__x2014cin, "")
          entry__x2014cin = c(entry__x2014cin, "")
        }
      }
    }
  }
}

if (isTRUE(any(is.na(dx1_primary), str_trim(dx1_primary) == ""))) {
  form__x2014cin = c(form__x2014cin, "Admission Diagnosis")
  name__x2014cin = c(name__x2014cin, "dx1_primary")
  msg__x2014cin = c(msg__x2014cin, "Clear primary diagnosis is required!")
  sect__x2014cin = c(sect__x2014cin, "")
  type__x2014cin = c(type__x2014cin, "")
  entry__x2014cin = c(entry__x2014cin, "")
}
if (isTRUE(all(!is.na(dx1_primary), dx1_primary == 0L))) {
  if (isTRUE(all(
    any(is.na(dx1_malaria), str_trim(dx1_malaria ) == "")
    , any(is.na(dx1_pneum), str_trim(dx1_pneum) == "")
    , any(is.na(dx1_diarrhoea), str_trim(dx1_diarrhoea) == "")
    , any(is.na(dx1_dehydrat), str_trim(dx1_dehydrat) == "")
    , any(is.na(dx1_hiv), str_trim(dx1_hiv) == "")
    , any(is.na(dx1_malnutr), str_trim(dx1_malnutr) == "")
    , any(is.na(dx1_tb_status), str_trim(dx1_tb_status) == "-1")
    , any(is.na(dx1_anaemia), str_trim(dx1_anaemia) == "")
    , any(is.na(dx1_meningitis), str_trim(dx1_meningitis) == "0")
    , any(is.na(dx1_asthma), str_trim(dx1_asthma) == "")
    , any(is.na(dx1_rickets), str_trim(dx1_rickets) == "0")
    , any(is.na(dx1_sepsis), str_trim(dx1_sepsis) == "0")
    , any(is.na(dx1_pre_lbw), str_trim(dx1_pre_lbw) == "0")
    , any(is.na(dx1_sickle_cell), str_trim(dx1_sickle_cell) == "0")
    , any(is.na(dx1_other_3), str_trim(dx1_other_3) == "")
    , any(is.na(dx1_other_4), str_trim(dx1_other_4) == "")
    , any(is.na(dx1_other_3_text), str_trim(dx1_other_3_text) == "")
  ))) {
    form__x2014cin = c(form__x2014cin, "Admission Diagnosis")
    name__x2014cin = c(name__x2014cin, "dx1_primary")
    msg__x2014cin = c(msg__x2014cin, "Specify at least one 'Primary admission diagnosis?'!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(all(!is.na(dx1_primary), dx1_primary == 1L))) {
  primary <- c(
    any(is.na(dx1_malaria), str_trim(dx1_malaria ) == "")
    , any(is.na(dx1_pneum), str_trim(dx1_pneum) == "")
    , any(is.na(dx1_diarrhoea), str_trim(dx1_diarrhoea) == "")
    , any(is.na(dx1_dehydrat), str_trim(dx1_dehydrat) == "")
    , any(is.na(dx1_hiv), str_trim(dx1_hiv) == "")
    , any(is.na(dx1_malnutr), str_trim(dx1_malnutr) == "")
    , any(is.na(dx1_tb_status), str_trim(dx1_tb_status) == "-1")
    , any(is.na(dx1_anaemia), str_trim(dx1_anaemia) == "")
    , any(is.na(dx1_meningitis), str_trim(dx1_meningitis) == "0")
    , any(is.na(dx1_asthma), str_trim(dx1_asthma) == "")
    , any(is.na(dx1_rickets), str_trim(dx1_rickets) == "0")
    , any(is.na(dx1_sepsis), str_trim(dx1_sepsis) == "0")
    , any(is.na(dx1_pre_lbw), str_trim(dx1_pre_lbw) == "0")
    , any(is.na(dx1_sickle_cell), str_trim(dx1_sickle_cell) == "0")
    , any(is.na(dx1_other_3), str_trim(dx1_other_3) == "")
    , any(is.na(dx1_other_4), str_trim(dx1_other_4) == "")
    , any(is.na(dx1_other_3_text), str_trim(dx1_other_3_text) == "")
  )
  if (length(which(!primary)) != 1L) {
    if (length(which(!primary)) == 2L) {
      if (!isTRUE(all(
        any(!is.na(dx1_dehydrat), str_trim(dx1_dehydrat) != "")
        , any(!is.na(dx1_diarrhoea), str_trim(dx1_diarrhoea) != "")
      ))) {
        form__x2014cin = c(form__x2014cin, "Admission Diagnosis")
        name__x2014cin = c(name__x2014cin, "dx1_primary_other")
        msg__x2014cin = c(msg__x2014cin, "Specify only one 'Primary admission diagnosis?'!")
        sect__x2014cin = c(sect__x2014cin, "")
        type__x2014cin = c(type__x2014cin, "")
        entry__x2014cin = c(entry__x2014cin, "")
      }
    }
    else {
      form__x2014cin = c(form__x2014cin, "Admission Diagnosis")
      name__x2014cin = c(name__x2014cin, "dx1_primary_other")
      msg__x2014cin = c(msg__x2014cin, "Specify only one 'Primary admission diagnosis?'!")
      sect__x2014cin = c(sect__x2014cin, "")
      type__x2014cin = c(type__x2014cin, "")
      entry__x2014cin = c(entry__x2014cin, "")
    }
  }
}

if (isTRUE(all(!is.na(sec_dx), sec_dx == 1L))) {
  if (isTRUE(all(
    any(is.na(dx2_malaria), str_trim(dx2_malaria) == "")
    , any(is.na(dx2_pneum), str_trim(dx2_pneum) == "")
    , any(is.na(dx2_diarrhoea), str_trim(dx2_diarrhoea) == "")
    , any(is.na(dx2_dehydrat), str_trim(dx2_dehydrat) == "")
    , any(is.na(dx2_hiv), str_trim(dx2_hiv) == "")
    , any(is.na(dx2_malnutr), str_trim(dx2_malnutr) == "")
    , any(is.na(dx2_tb_status), str_trim(dx2_tb_status) == "-1")
    , any(is.na(dx2_anaemia), str_trim(dx2_anaemia) == "")
    , any(is.na(dx2_meningitis), str_trim(dx2_meningitis) == "0")
    , any(is.na(dx2_asthma), str_trim(dx2_asthma) == "")
    , any(is.na(dx2_rickets), str_trim(dx2_rickets) == "0")
    , any(is.na(dx2_sepsis), str_trim(dx2_sepsis) == "0")
    , any(is.na(dx2_pre_lbw), str_trim(dx2_pre_lbw) == "0")
    , any(is.na(dx2_sickle_cell), str_trim(dx2_sickle_cell) == "0")
    , any(is.na(dx2_other_3), str_trim(dx2_other_3) == "")
    , any(is.na(dx2_other_4), str_trim(dx2_other_4) == "")
    , any(is.na(dx2_other_3_text), str_trim(dx2_other_3_text) == "")
  ))) {
    form__x2014cin = c(form__x2014cin, "Admission Diagnosis")
    name__x2014cin = c(name__x2014cin, "sec_dx")
    msg__x2014cin = c(msg__x2014cin, "Specify at least one 'Secondary admission diagnosis?'!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}
if (isTRUE(all(!is.na(adm_rx), adm_rx == 1L))) {
  if (isTRUE(all(
    any(is.na(adm_rx1), str_trim(adm_rx1) == "")
    , any(is.na(adm_rx2), str_trim(adm_rx2) == "")
    , any(is.na(adm_rx3), str_trim(adm_rx3) == "")
    , any(is.na(adm_rx4), str_trim(adm_rx4) == "")
    , any(is.na(adm_rx4), str_trim("adm_rx_free_text") == "")
  ))) {
    form__x2014cin = c(form__x2014cin, "Treatment")
    name__x2014cin = c(name__x2014cin, "adm_rx1")
    msg__x2014cin = c(msg__x2014cin, "'Other treatment details' are required!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}


if (isTRUE(any(is.na(dsc_dx1_primary), str_trim(dsc_dx1_primary) == ""))) {
  form__x2014cin = c(form__x2014cin, "Discharge Information")
  name__x2014cin = c(name__x2014cin, "dsc_dx1_primary")
  msg__x2014cin = c(msg__x2014cin, "Clear primary discharge diagnosis is required!")
  sect__x2014cin = c(sect__x2014cin, "")
  type__x2014cin = c(type__x2014cin, "")
  entry__x2014cin = c(entry__x2014cin, "")
}
if (isTRUE(all(!is.na(dsc_dx1_primary), dsc_dx1_primary == 0L))) {
  if (isTRUE(all(
    any(is.na(dsc_dx1_malaria), str_trim(dsc_dx1_malaria) == "")
    , any(is.na(dsc_dx1_malaria_sev), str_trim(dsc_dx1_malaria_sev) == "")
    , any(is.na(dsc_dx1_malaria_non_sev), str_trim(dsc_dx1_malaria_non_sev) == "")
    , any(is.na(dsc_dx1_malaria_no_class), str_trim(dsc_dx1_malaria_no_class) == "")
    , any(is.na(dsc_dx1_pneum), str_trim(dsc_dx1_pneum) == "")
    , any(is.na(dsc_dx1_diarrhoea), str_trim(dsc_dx1_diarrhoea) == "")    
    , any(is.na(dsc_dx1_dehydrat), str_trim(dsc_dx1_dehydrat) == "")
    , any(is.na(dsc_dx1_hiv), str_trim(dsc_dx1_hiv) == "")
    , any(is.na(dsc_dx1_malnutr), str_trim(dsc_dx1_malnutr) == "")  
    , any(is.na(dsc_dx1_anaemia), str_trim(dsc_dx1_anaemia) == "")
    , any(is.na(dsc_dx1_meningitis), str_trim(dsc_dx1_meningitis) == "0")
    , any(is.na(dsc_dx1_rickets), str_trim(dsc_dx1_rickets) == "0") 
    , any(is.na(dsc_dx1_asthma), str_trim(dsc_dx1_asthma) == "")
    , any(is.na(dsc_dx1_tb), str_trim(dsc_dx1_tb) == "")
    , any(is.na(dsc_dx1_sepsis), str_trim(dsc_dx1_sepsis) == "0")
    , any(is.na(dsc_dx1_pre_lbw), str_trim(dsc_dx1_pre_lbw) == "0")
    , any(is.na(dsc_dx1_sickle_cell), str_trim(dsc_dx1_sickle_cell) == "0")
    , any(is.na(dsc_dx1_other_1), str_trim(dsc_dx1_other_1) == "")
    , any(is.na(dsc_dx1_other_2), str_trim(dsc_dx1_other_2) == "")  
    , any(is.na(dsc_dx1_other_3), str_trim(dsc_dx1_other_3) == "")    
    , any(is.na(dsc_dx1_other_4), str_trim(dsc_dx1_other_4) == "")
    , any(is.na(dsc_dx1_other_5), str_trim(dsc_dx1_other_5) == "")
  ))) {
    form__x2014cin = c(form__x2014cin, "Discharge Information")
    name__x2014cin = c(name__x2014cin, "dsc_dx1_primary")
    msg__x2014cin = c(msg__x2014cin, "Specify at least one 'Primary discharge diagnosis?'!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}
if (isTRUE(all(!is.na(dsc_dx1_primary), dsc_dx1_primary == 1L))) {
  primary = c(
    any(is.na(dsc_dx1_malaria), str_trim(dsc_dx1_malaria) == "")
  , any(is.na(dsc_dx1_pneum), str_trim(dsc_dx1_pneum) == "")
  , any(is.na(dsc_dx1_diarrhoea), str_trim(dsc_dx1_diarrhoea) == "")    
  , any(is.na(dsc_dx1_dehydrat), str_trim(dsc_dx1_dehydrat) == "")
  , any(is.na(dsc_dx1_hiv), str_trim(dsc_dx1_hiv) == "")
  , any(is.na(dsc_dx1_malnutr), str_trim(dsc_dx1_malnutr) == "")  
  , any(is.na(dsc_dx1_anaemia), str_trim(dsc_dx1_anaemia) == "")
  , any(is.na(dsc_dx1_meningitis), str_trim(dsc_dx1_meningitis) == "0")
  , any(is.na(dsc_dx1_rickets), str_trim(dsc_dx1_rickets) == "0") 
  , any(is.na(dsc_dx1_asthma), str_trim(dsc_dx1_asthma) == "")
  , any(is.na(dsc_dx1_tb), str_trim(dsc_dx1_tb) == "")
  , any(is.na(dsc_dx1_sepsis), str_trim(dsc_dx1_sepsis) == "0")
  , any(is.na(dsc_dx1_pre_lbw), str_trim(dsc_dx1_pre_lbw) == "0")
  , any(is.na(dsc_dx1_sickle_cell), str_trim(dsc_dx1_sickle_cell) == "0")
  , any(is.na(dsc_dx1_other_1), str_trim(dsc_dx1_other_1) == "")
  , any(is.na(dsc_dx1_other_2), str_trim(dsc_dx1_other_2) == "")  
  , any(is.na(dsc_dx1_other_3), str_trim(dsc_dx1_other_3) == "")    
  , any(is.na(dsc_dx1_other_4), str_trim(dsc_dx1_other_4) == "")
  , any(is.na(dsc_dx1_other_5), str_trim(dsc_dx1_other_5) == "")
  )
  if (length(which(!primary)) != 1L) {
    if (length(which(!primary)) == 2L) {
      if (!isTRUE(all(
        any(!is.na(dsc_dx1_dehydrat), str_trim(dsc_dx1_dehydrat) != "")
        , any(!is.na(dsc_dx1_diarrhoea), str_trim(dsc_dx1_diarrhoea) != "")
      ))) {
        form__x2014cin = c(form__x2014cin, "Discharge Information")
        name__x2014cin = c(name__x2014cin, "dsc_dx1_primary")
        msg__x2014cin = c(msg__x2014cin, "Specify only least one 'Primary discharge diagnosis?'!")
        sect__x2014cin = c(sect__x2014cin, "")
        type__x2014cin = c(type__x2014cin, "")
        entry__x2014cin = c(entry__x2014cin, "")
      }
    }
    else {
      form__x2014cin = c(form__x2014cin, "Discharge Information")
      name__x2014cin = c(name__x2014cin, "dsc_dx1_primary")
      msg__x2014cin = c(msg__x2014cin, "Specify only one 'Primary discharge diagnosis?'!")
      sect__x2014cin = c(sect__x2014cin, "")
      type__x2014cin = c(type__x2014cin, "")
      entry__x2014cin = c(entry__x2014cin, "")
    }
  }
}

if (isTRUE(all(!is.na(dsc_dx2), dsc_dx2 == 1L))) {
  if (isTRUE(all(
      any(is.na(dsc_dx2_malaria), str_trim(dsc_dx2_malaria) == "")
    , any(is.na(dsc_dx2_pneum), str_trim(dsc_dx2_pneum) == "")
    , any(is.na(dsc_dx2_diarrhoea), str_trim(dsc_dx2_diarrhoea) == "")
    , any(is.na(dsc_dx2_dehydrat), str_trim(dsc_dx2_dehydrat) == "")
    , any(is.na(dsc_dx2_hiv), str_trim(dsc_dx2_hiv) == "")
    , any(is.na(dsc_dx2_malnutr), str_trim(dsc_dx2_malnutr) == "")
    , any(is.na(dsc_dx2_anaemia), str_trim(dsc_dx2_anaemia) == "")
    , any(is.na(dsc_dx2_meningitis), str_trim(dsc_dx2_meningitis) == "")
    , any(is.na(dsc_dx2_rickets), str_trim(dsc_dx2_rickets) == "")
    , any(is.na(dsc_dx2_asthma), str_trim(dsc_dx2_asthma) == "")
    , any(is.na(dsc_dx2_tb), str_trim(dsc_dx2_tb ) == "")
    , any(is.na(dsc_dx2_sepsis), str_trim(dsc_dx2_sepsis) == "")
    , any(is.na(dsc_dx2_pre_lbw), str_trim(dsc_dx2_pre_lbw) == "")
    , any(is.na(dsc_dx2_sickle_cell), str_trim(dsc_dx2_sickle_cell) == "")
    , any(is.na(dsc_dx2_other_1), str_trim(dsc_dx2_other_1) == "")
    , any(is.na(dsc_dx2_other_2), str_trim(dsc_dx2_other_2) == "")
    , any(is.na(dsc_dx2_other_3), str_trim(dsc_dx2_other_3) == "")
    , any(is.na(dsc_dx2_other_4), str_trim(dsc_dx2_other_4) == "")
    , any(is.na(dsc_dx2_other_5), str_trim(dsc_dx2_other_5) == "")
    , any(is.na(dsc_dx2_other_6), str_trim(dsc_dx2_other_6) == "")
    , any(is.na(dsc_dx2_other_7), str_trim(dsc_dx2_other_7) == "")
  ))) {
    form__x2014cin = c(form__x2014cin, "Discharge Information")
    name__x2014cin = c(name__x2014cin, "dsc_dx2")
    msg__x2014cin = c(msg__x2014cin, "Specify at least one 'Primary discharge diagnosis?'!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

# Check dates

if (isTRUE(date_can_be_validated(date_adm) && date_can_be_validated(date_discharge))) {
  if (!(isTRUE(as.Date(date_adm)%in% c(seq(as.Date('1913-01-01', "%Y-%m-%d"), by="year",length.out = 5))))){
    if (isTRUE(as.Date(date_adm) > as.Date(date_discharge))) {
      form__x2014cin = c(form__x2014cin, "Biodata")
      name__x2014cin = c(name__x2014cin, "date_adm")
      msg__x2014cin = c(msg__x2014cin, "'Admission Date' cannot be after 'Discharge/Death Date'")
      sect__x2014cin = c(sect__x2014cin, "")
      type__x2014cin = c(type__x2014cin, "")
      entry__x2014cin = c(entry__x2014cin, "")
    }
  }
}

if (isTRUE(date_can_be_validated(date_adm))) {
  if (isTRUE(as.Date(date_adm) > Sys.Date())) {
    form__x2014cin = c(form__x2014cin, "Biodata")
    name__x2014cin = c(name__x2014cin, "date_adm")
    msg__x2014cin = c(msg__x2014cin, "Admission Date' cannot be in the future!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(date_discharge))) {
  if (isTRUE(as.Date(date_discharge) > Sys.Date())) {
    form__x2014cin = c(form__x2014cin, "Biodata")
    name__x2014cin = c(name__x2014cin, "date_discharge")
    msg__x2014cin = c(msg__x2014cin, "Discharge/Death Date' cannot be in the future!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

# Dates for drugs
if (isTRUE(date_can_be_validated(adm_rx1_date_presc) & as.Date(adm_rx1_date_presc, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(adm_rx1_date_presc, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(adm_rx1_date_presc, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(adm_rx1_date_presc, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "adm_rx1_date_presc")
    msg__x2014cin = c(msg__x2014cin, "Other treatment 1 prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(adm_rx1_date_given) & as.Date(adm_rx1_date_given, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(adm_rx1_date_given, "%Y-%m-%d") > as.Date(date_discharge) & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(adm_rx1_date_given, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(adm_rx1_date_given, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(adm_rx1_date_given, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(adm_rx1_date_presc, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "adm_rx1_date_given")
    msg__x2014cin = c(msg__x2014cin, "Other treatment 1 start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(adm_rx2_date_presc) & as.Date(adm_rx2_date_presc, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(adm_rx2_date_presc, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(adm_rx2_date_presc, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(adm_rx2_date_presc, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "adm_rx2_date_presc")
    msg__x2014cin = c(msg__x2014cin, "Other treatment 2 prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(adm_rx2_date_given) & as.Date(adm_rx2_date_given, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(adm_rx2_date_given, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(adm_rx2_date_given, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(adm_rx2_date_given, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(adm_rx2_date_given, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(adm_rx2_date_presc, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "adm_rx2_date_given")
    msg__x2014cin = c(msg__x2014cin, "Other treatment 2 start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(adm_rx3_date_presc) & as.Date(adm_rx3_date_presc, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(adm_rx3_date_presc) > as.Date(date_discharge) & as.Date(date_discharge)!= "1913-01-01") |
             (as.Date(adm_rx3_date_presc) > Sys.Date() & as.Date(date_discharge)== "1913-01-01") |
             (as.Date(adm_rx3_date_presc) < as.Date(date_adm))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "adm_rx3_date_presc")
    msg__x2014cin = c(msg__x2014cin, "Other treatment 3 prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(adm_rx3_date_given) & as.Date(adm_rx3_date_given, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(adm_rx3_date_given, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(adm_rx3_date_given, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(adm_rx3_date_given, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(adm_rx3_date_given, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(adm_rx3_date_presc, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "adm_rx3_date_given")
    msg__x2014cin = c(msg__x2014cin, "Other treatment 3 start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(adm_rx4_date_presc) & as.Date(adm_rx4_date_presc, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(adm_rx4_date_presc, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(adm_rx4_date_presc, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(adm_rx4_date_presc, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "adm_rx4_date_presc")
    msg__x2014cin = c(msg__x2014cin, "Other treatment 4 prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(adm_rx4_date_given) & as.Date(adm_rx4_date_given, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(adm_rx4_date_given, "%Y-%m-%d") > as.Date(date_discharge) & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(adm_rx4_date_given, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(adm_rx4_date_given, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(adm_rx4_date_given, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(adm_rx4_date_presc, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "adm_rx4_date_given")
    msg__x2014cin = c(msg__x2014cin, "Other treatment 4 start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(adm_rx5_date_presc) & as.Date(adm_rx5_date_presc, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(adm_rx5_date_presc, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(adm_rx5_date_presc, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(adm_rx5_date_presc, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "adm_rx5_date_presc")
    msg__x2014cin = c(msg__x2014cin, "Other treatment 5 prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(adm_rx5_date_given) & as.Date(adm_rx5_date_given, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(adm_rx5_date_given, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(adm_rx5_date_given, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(adm_rx5_date_given, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(adm_rx5_date_given, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(adm_rx5_date_presc, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "adm_rx5_date_given")
    msg__x2014cin = c(msg__x2014cin, "Other treatment 5 start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(adm_rx6_date_presc) & as.Date(adm_rx6_date_presc, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(adm_rx6_date_presc, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(adm_rx6_date_presc, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(adm_rx6_date_presc, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "adm_rx6_date_presc")
    msg__x2014cin = c(msg__x2014cin, "Other treatment 6 prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(adm_rx5_date_given) & as.Date(adm_rx6_date_given, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(adm_rx6_date_given, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(adm_rx6_date_given, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(adm_rx6_date_given, "%Y-%m-%d") < as.Date(date_adm)) |
             (as.Date(adm_rx6_date_given, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(adm_rx6_date_presc, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "adm_rx6_date_given")
    msg__x2014cin = c(msg__x2014cin, "Other treatment 6 start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(amox1_date) & as.Date(amox1_date, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(amox1_date, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(amox1_date, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(amox1_date, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "amox1_date")
    msg__x2014cin = c(msg__x2014cin, "Amoxycillin prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(adm_rx5_date_given) & as.Date(amox1_date_started, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(amox1_date_started, "%Y-%m-%d") > as.Date(date_discharge) & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(amox1_date_started, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(amox1_date_started, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(amox1_date_started, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm), as.Date(amox1_date, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "amox1_date_started")
    msg__x2014cin = c(msg__x2014cin, "Amoxycillin start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(pen1_date) & as.Date(pen1_date, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(pen1_date, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(pen1_date, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(pen1_date, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "pen1_date")
    msg__x2014cin = c(msg__x2014cin, "Penicillin prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(pen1_date_started) & as.Date(pen1_date_started, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(pen1_date_started, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(pen1_date_started, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(pen1_date_started, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(pen1_date_started, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(pen1_date, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "pen1_date_started")
    msg__x2014cin = c(msg__x2014cin, "Penicillin start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(genta1_date) & as.Date(genta1_date, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(genta1_date, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(genta1_date, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(genta1_date, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "genta1_date")
    msg__x2014cin = c(msg__x2014cin, "Gentamicin prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(genta1_date_started) & as.Date(genta1_date_started, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(genta1_date_started, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(genta1_date_started, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge)== "1913-01-01") |
             (as.Date(genta1_date_started, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(genta1_date_started, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(genta1_date, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "genta1_date_started")
    msg__x2014cin = c(msg__x2014cin, "Gentamicin start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(ceftri1_date) & as.Date(ceftri1_date, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(ceftri1_date, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(ceftri1_date, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(ceftri1_date, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "ceftri1_date")
    msg__x2014cin = c(msg__x2014cin, "Cefrtiaxone prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(ceftri1_date_started) & as.Date(ceftri1_date_started, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(ceftri1_date_started, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(ceftri1_date_started, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(ceftri1_date_started, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(ceftri1_date_started, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(ceftri1_date, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "ceftri1_date_started")
    msg__x2014cin = c(msg__x2014cin, "Cefrtiaxone start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(caf1_date) & as.Date(caf1_date, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(caf1_date, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(caf1_date, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(caf1_date, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "caf1_date")
    msg__x2014cin = c(msg__x2014cin, "chloramphenical prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(caf1_date_started) & as.Date(caf1_date_started, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(caf1_date_started, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(caf1_date_started, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(caf1_date_started, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(caf1_date_started, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(caf1_date, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "caf1_date_started")
    msg__x2014cin = c(msg__x2014cin, "chloramphenical start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(metr1_date) & as.Date(metr1_date, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(metr1_date, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(metr1_date, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(metr1_date, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "metr1_date")
    msg__x2014cin = c(msg__x2014cin, "metronidazole prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(metr1_date_started) & as.Date(metr1_date_started, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(metr1_date_started, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(metr1_date_started, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(metr1_date_started, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(metr1_date_started, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(metr1_date, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "metr1_date_started")
    msg__x2014cin = c(msg__x2014cin, "metronidazole start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(cotrimox1_date) & as.Date(cotrimox1_date, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(cotrimox1_date, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(cotrimox1_date, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(cotrimox1_date, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "cotrimox1_date")
    msg__x2014cin = c(msg__x2014cin, "cotrimoxazole prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(cotrimox1_date_started) & as.Date(cotrimox1_date_started, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(cotrimox1_date_started, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(cotrimox1_date_started, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(cotrimox1_date_started, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(cotrimox1_date_started, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(cotrimox1_date, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "cotrimox1_date_started")
    msg__x2014cin = c(msg__x2014cin, "cotrimoxazole start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(ant_tb_date) & as.Date(ant_tb_date, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(ant_tb_date, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(ant_tb_date, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(ant_tb_date, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "ant_tb_date")
    msg__x2014cin = c(msg__x2014cin, "anti-TBs prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(quinl1_date) & as.Date(quinl1_date, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(quinl1_date, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(quinl1_date, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(quinl1_date, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "quinl1_date")
    msg__x2014cin = c(msg__x2014cin, "Quinine prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(quinl1_date_started) & as.Date(quinl1_date_started, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(quinl1_date_started, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(quinl1_date_started, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(quinl1_date_started, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(quinl1_date_started, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(quinl1_date, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "quinl1_date_started")
    msg__x2014cin = c(msg__x2014cin, "Quinine start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(quinm1_date) & as.Date(quinm1_date, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(quinm1_date, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(quinm1_date, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(quinm1_date, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "quinm1_date")
    msg__x2014cin = c(msg__x2014cin, "Quinine prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(quinm1_date_started) & as.Date(quinm1_date_started, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(quinm1_date_started, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(quinm1_date_started, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(quinm1_date_started, "%Y-%m-%d") < as.Date(date_adm)) |
             (as.Date(quinm1_date_started, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(quinm1_date, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "quinm1_date_started")
    msg__x2014cin = c(msg__x2014cin, "Quinine start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(arte_date) & as.Date(arte_date, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(arte_date, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(arte_date, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(arte_date, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "arte_date")
    msg__x2014cin = c(msg__x2014cin, "Artesunate prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(arte_date_started) & as.Date(arte_date_started, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(arte_date_started, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(arte_date_started, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(arte_date_started, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(arte_date_started, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(arte_date, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "arte_date_started")
    msg__x2014cin = c(msg__x2014cin, "Artesunate start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(coart1_date) & as.Date(coart1_date, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(coart1_date, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(coart1_date, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(coart1_date, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "coart1_date")
    msg__x2014cin = c(msg__x2014cin, "coartem prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(coart1_date_started) & as.Date(coart1_date_started, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(coart1_date_started, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(coart1_date_started, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(coart1_date_started, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(coart1_date_started, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(coart1_date, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "coart1_date_started")
    msg__x2014cin = c(msg__x2014cin, "coartem start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(oxy_date) & as.Date(oxy_date, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(oxy_date, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(oxy_date, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(oxy_date, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "oxy_date")
    msg__x2014cin = c(msg__x2014cin, "Oxygen prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(transf_date_pres) & as.Date(transf_date_pres, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(transf_date_pres, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(transf_date_pres, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(transf_date_pres, "%Y-%m-%d", "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "transf_date_pres")
    msg__x2014cin = c(msg__x2014cin, "Blood prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(transf_date_gvn) & as.Date(transf_date_gvn, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(transf_date_gvn, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(transf_date_gvn, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(transf_date_gvn, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(transf_date_gvn, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm, "%Y-%m-%d"), as.Date(transf_date_pres, "%Y-%m-%d")))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "transf_date_gvn")
    msg__x2014cin = c(msg__x2014cin, "Blood transfusion Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(date_feeds_start) & as.Date(date_feeds_start, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(date_feeds_start, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(date_feeds_start, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(date_feeds_start, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d"))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "date_feeds_start")
    msg__x2014cin = c(msg__x2014cin, "Post admission feed prescription Date' cannot be after discharge date/or future or before admission date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}

if (isTRUE(date_can_be_validated(date_post_adm_feeds) & as.Date(date_post_adm_feeds, "%Y-%m-%d")!= "1913-01-01")) {
  if (isTRUE((as.Date(date_post_adm_feeds, "%Y-%m-%d") > as.Date(date_discharge, "%Y-%m-%d") & as.Date(date_discharge, "%Y-%m-%d")!= "1913-01-01") |
             (as.Date(date_post_adm_feeds, "%Y-%m-%d") > Sys.Date() & as.Date(date_discharge, "%Y-%m-%d")== "1913-01-01") |
             (as.Date(date_post_adm_feeds, "%Y-%m-%d") < as.Date(date_adm, "%Y-%m-%d")) |
             (as.Date(date_post_adm_feeds, "%Y-%m-%d") < max(na.rm = T, as.Date(date_adm), as.Date(date_feeds_start)))
  )) {
    form__x2014cin = c(form__x2014cin, "treatment")
    name__x2014cin = c(name__x2014cin, "date_post_adm_feeds")
    msg__x2014cin = c(msg__x2014cin, "Post admission feed start Date' cannot be after discharge date/or future or before admission or prescription date!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Validate missingness of History variables
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  if (isTRUE(all(
    any(is.na(fever), str_trim(fever) == "")
    , any(is.na(cough), str_trim(cough) == "")
    , any(is.na(diff_breath), str_trim(diff_breath) == "")
    , any(is.na(diarrhoea), str_trim(diarrhoea) == "")
    , any(is.na(convulsions), str_trim(convulsions) == "")
    , any(is.na(vomits), str_trim(vomits) == "")
    , any(is.na(diff_feed), str_trim(diff_breath) == "")
    , as.numeric(is_minimum) != 1
  ))) {
    form__x2014cin = c(form__x2014cin, "History")
    name__x2014cin = c(name__x2014cin, "fever")
    msg__x2014cin = c(msg__x2014cin, "'Fever','Cough','Diarrhoea','Convulsions','Vomits','Difficult breathng' are all missing.Specify at least one!")
    sect__x2014cin = c(sect__x2014cin, "")
    type__x2014cin = c(type__x2014cin, "")
    entry__x2014cin = c(entry__x2014cin, "")
  }




