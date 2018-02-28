##########################################################
#
# Project         : Error Reporting - Site Machines
# Author          : Boniface Makone
# Editor          : Abraham Lagat
# Date            : 12-02-2016
# Organization    : KEMRI Wellcome Trust
# Department      : HSRG (Data & Analytics Team)
#
############################################################

# Define the period

end_date <- Sys.Date()
start_date <- end_date - 30*5 # Set to the last 5 months

# ==============================================================================

# Function for performance 

start_time <- Sys.time()
message(sprintf("Hi, %s!\nError reporting approximately started at %s!", 
                (if (.Platform$OS.type == "windows") 
                  Sys.getenv("USERNAME") else 
                    Sys.getenv("USER")
                )
                , format(start_time, "%I:%M %p [%A %e %B, %Y]")))

# Load packages

message("Loading required packages...")
rpkgs = c("RedcapData", "data.table", "stringr", "magrittr", "dplyr", "parallel", "jsonlite")
if(any(!rpkgs %in% installed.packages())){
  rpkgs1 = rpkgs[!rpkgs %in% installed.packages()] 
  rpkgs1 = rpkgs1[!rpkgs1 %in% "RedcapData"]
  install.packages(rpkgs1,dep=TRUE,repos='http://cran.rstudio.com', dependencies = TRUE)
}

if(!"RedcapData" %in% installed.packages()){
  if(!"devtools" %in% installed.packages()) install.packages('devtools', repos='http://cran.rstudio.com', dependencies = TRUE)
  devtools::install_github("tjhubs/RedcapData", dependencies = TRUE)
}
lapply(rpkgs[(rpkgs %in% .packages(all.available = TRUE))], library, character.only = TRUE)

message("Setting and validating global options...")

# Set global options
api_url <- "http://hsu.kemri-wellcome.org/redcap/api/"
token <- "D6DAC0B3027F03F9C4659F71155ACCBC"
local <- FALSE
chunked <- TRUE
chunk_size <- 2500
id_var <- "id" # Check for pumwani and CIN id names: id_var, id respectively
date_var <- "date_today"
hosp_var <- "hosp_id"
surrogate_id_var <- "ipno" # Check for pumwani and CIN ipno names: patient_ipno, ipno respectively
hosp_to_validate <- NA
#hosp_to_validate <- c(51,52,53, 54, 55, 57,58, 62, 63, 64, 66, 68, 70, 71)
gui <- TRUE

if (chunked) stopifnot(is.numeric(chunk_size) && chunk_size > 0)
chunk_size <- as.integer(chunk_size)

message("Global options OK!")

# Set file paths

message("File system checking...")

# create a function to wrap file-allied functionality
file_system_checks <- function(file_path, create = FALSE, verify = TRUE, dir = FALSE, ...) {
  if (create && !file.exists(file_path)) {
    if (!file.exists(basename(file_path)))
      stopifnot(dir.create(basename(file_path), recursive = T))
    stopifnot(if (dir) dir.create(file_path) else file.create(file_path))
  }
  if (verify) stopifnot(file.exists(file_path))
  normalizePath(file_path)
}

path_to_files <- file_system_checks(
  (if (.Platform$OS.type == "windows") 
    Sys.getenv("USERPROFILE") else 
      Sys.getenv("HOME")
  ) %>% 
    file.path("hsuApps","error_scripts","cin_error") %>% 
    gsub("\\\\", "/", .)
)

updates_location <- file_system_checks(file.path(path_to_files, "upd.csv"), verify = FALSE,create = T) 
custom_code_location <- file_system_checks(file.path(path_to_files, "custom.R"), verify = FALSE)
exclusion_patterns_location <- file_system_checks(file.path(path_to_files, "exclude.R"), verify = FALSE)

message("File system OK!")

# Running the application

message("Running the application...")

# populate the global namespace with the regular expressions matching the exclusion criteria
source(exclusion_patterns_location)

# get ids and date of entry for data entered between the start and end period
ids_matching_dates <- tbl_df(get_redcap_data(
  api = api_url, 
  token = token, 
  content = "record", 
  local = local ,
  fields = c(id_var, date_var)) 
)
names(ids_matching_dates) <- c("id", "date")

ids_matching_dates %<>%
  mutate(date = as.Date(date)) %>%
  filter(date >= start_date & date <= end_date)
ids_matching_dates <- ids_matching_dates$id

# Manualy get the ids
# =========================================================================================================================
 # ids_matching_dates = ifelse (.Platform$OS.type == "windows", Sys.getenv("USERPROFILE"), Sys.getenv("HOME")) %>%
 #               file.path(., "hsuApps","error_scripts","error-reports_cin", "tmp", "old errors") %>%
 #               paste0(., "/", list.files(., pattern = ".csv")) %>%
 #               lapply(., function(x) read.csv(x, header = T)) %>%
 #               lapply(., function(x) unique(x$RecordID)) %>%
 #               unlist(.) %>% unique(.)
# =========================================================================================================================

if ((data_size <- length(ids_matching_dates)) == 0)
  stop("No data to validate!")

message(sprintf("%d records to validate...", data_size))

# get data and metadata
message("Getting & cleaning metadata...")
meta_data <- tbl_df(get_redcap_data(
  api = api_url, 
  token = token, 
  content = "metadata", 
  local = local
))
# Clean metadata
meta_data %<>%
  filter(
    field_type != "descriptive"
  ) %>%
  mutate(required_field = ifelse(field_type == "checkbox", TRUE, required_field)) %>%
  mutate_each(funs(remove_empties = ifelse((is.na(.) | str_trim(.) == ""), NA, .)))

if (exists("exclusion_patterns") && length(na.omit(exclusion_patterns))) {
  meta_data %<>%
    mutate(`..to_exclude..` = grepl(paste0(str_trim(exclusion_patterns), collapse="|"), field_name)) %>%
    filter(!`..to_exclude..`) %>%
    select(-`..to_exclude..`)
}

message("Metadata in memory!")

message("Pulling data from REDCap...")
if (chunked) {
  data_to_validate <- get_redcap_data(
    api = api_url, 
    token = token, 
    content = "record", 
    local = local, 
    ids_to_pull = ids_matching_dates
  )
} else {
  get_chunked_redcap_data(
    dataset_name = "data_to_validate",
    metadataset_name = "..meta_tmp..",
    api = api_url, 
    token = token, 
    content = "record", 
    local = local, 
    ids_to_pull = ids_matching_dates
  )
}
#data_to_validate <- data_to_validate[data_to_validate$date_today != as.Date("2016-08-31"),]

data_to_validate <- tbl_df(data_to_validate)

message("Data in memory!")


# Generating validation function code

message("Generating data validation code...")

# getting custom logic
if (file.exists(custom_code_location)) {
  custom_code <- readLines(custom_code_location, warn = F)
  custom_code <- custom_code[!(is.na(custom_code) | custom_code == "")]
  custom_code <- if (0 == length(custom_code)) NA else custom_code
} else {
  custom_code <- NA
}

# getting updates
updates <- if (file.exists(updates_location)) 
  RedcapData:::load_updates(read.csv(updates_location, stringsAsFactors = F)) else 
    list()

# generate code and evaluate in current namespace
data_validation_code <- generate_data_validation_code(
  meta_data, 
  date_var, 
  hosp_var, 
  custom_code = custom_code, 
  surrogate_id_var = surrogate_id_var,
  updates = "updates", 
  updates_envir_depth = 1
)
if(any(grepl("weight =\"-1\"", data_validation_code)) | 
      any(grepl("weight = \"-1\"", data_validation_code))){
  data_validation_code<-gsub("weight = \"-1\"", "weight ==-1",data_validation_code)
  data_validation_code<-gsub("weight =\"-1\"", "weight ==-1",data_validation_code)
}
  

eval(parse(text = data_validation_code))

message("Data validation code generated!")

# validate data entry

message("Validating data (This might take a while)...")
data_to_validate <- data.table(data_to_validate)
data_to_validate <- data_to_validate[, key:= .I]
setkey(data_to_validate, key)

#Replace -1 with .1 for field values with checkboxes
names(data_to_validate) <- gsub('____','___.',names(data_to_validate))

library(digest); library(plyr)

data_to_validate1 <- data_to_validate
j = 0

for(i in unique(data_to_validate1$hosp_id)[!is.na(unique(data_to_validate1$hosp_id))]){
  data_to_validate <-data_to_validate1[which(data_to_validate1$hosp_id==i),]
  
  if(dim(data_to_validate)[1]>0){
    #seq_len(nrow(data_to_validate))
    if (1 < length(chunks <- get_chunks(seq_len(nrow(data_to_validate)), chunk_size)) && chunked) {
      message("Validating in parallel (2 nodes per core)...")
      tryCatch({
        message(sprintf("** %d nodes spawned **", detectCores() * 2))
        cl <- makeCluster(min(length(chunks),detectCores()*2)) # initialize 2 slaves (nodes) per core
        
        invisible(clusterEvalQ(cl, {
          # load relevant packages to cluster
          library(data.table)
          library(stringr)
          library(RedcapData)
          return(NULL)
        }))
        
        clusterExport(cl, c("validate_data_entry", "data_to_validate", "hosp_to_validate", "updates")) # export variables to nodes
        # Execute code in parallel
        error_report <- clusterApplyLB(
          cl,
          chunks,
          function(x) {
            data_to_validate[x, validate_data_entry(.SD, hosp_to_validate = hosp_to_validate, updates = updates), by=key]
          }
        ) %>% rbindlist()
      }, error = function(e) {
        stop(sprintf("An error has occured.\nDetails:\n%s", paste0(e$message, collapse = "\n")))
      }, finally = {
        if (exists("cl")) {
          stopCluster(cl)
          rm(cl)
        }
      })
      message("DONE!")
    } else {
      error_report <- data_to_validate[, validate_data_entry(.SD, hosp_to_validate = hosp_to_validate, updates = updates), by=key]
    }
    
    if(i == 80) error_report <- error_report[which(error_report$Variable != "clinician_data"),]
    
    #=================================================================================================================================
    # Identify IDs with concordant values for: date_adm,date_discharge,outcome,oxygen_sat,resp_rate,pulse_rate,temp
    #=================================================================================================================================
    
    message("Data validated!")
    
    # Save error report and pop it open using default system app
    message("\tSaving error report for hospital ", i, "...!\n")
    hosp<-paste0("Hospital-",i,"-ErrorReport")
    report_location <- file.path(path_to_files, "tmp", paste0(hosp, ".csv"))
    report_json <- file.path(path_to_files, "tmp",paste0(hosp, ".json"))
    
    if(dim(error_report)[1]>0){
      # Correct section names
      error_report = merge(error_report, 
                           rename(subset(meta_data, select = c(field_name, form_name)),c(field_name='Variable')),
                           by = 'Variable') %>% 
        mutate(., Section = form_name) %>%
        subset(., select = -form_name)
      
      # Create JSON Files
      error_json = error_report %>% toJSON()
      
      j = j + 1
      write.csv(error_report, file=report_location, row.names = FALSE)
      ifelse(j==1, error_report_combined <- error_report, 
             error_report_combined <-rbind(error_report_combined, error_report))
      write(error_json, report_json)
    }
  }
  
  error_json = error_report_combined %>% toJSON()
  if(dim(error_report_combined)[1]>0){
    write(error_json, "Combined_ErrorReport.json")
  }
}

message(sprintf("Error report located in \"%s\"!", report_location))

end_time <- Sys.time()
time_diff <- 
  difftime(end_time, start_time, units = "mins") %>%
  as.numeric() %>%
  `*`(60) %>%
  round(0)
time_diff <- sprintf("%d minutes, %d seconds", (time_diff %/% 60), (time_diff %% 60))

message(sprintf("Error reporting approximately ended at %s!", format(end_time, "%I:%M %p [%A %e %B, %Y]")))
message(sprintf("The session took approximately %s", time_diff))

message("DONE!")

message("Cleaning the Work Environment......................................")
#rm(list=ls(all.names = T))
#Sys.sleep(10)
