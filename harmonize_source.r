harmonize_source <- function(source_to_harmonize, current_data) {
  
  select_cols <- c("STUDYID", "DATE", "TIME")
  
  for (c in select_cols) {
    
    if (!(c %in% colnames(source_to_harmonize))) {
      source_to_harmonize <- source_to_harmonize %>%
        mutate(!!c := NA_character_)
    }
    
  }
  
  source_to_harmonize %<>% mutate(STUDYID = current_data$study_id)
  

  source_to_harmonize <- date_time(source_to_harmonize)
  source_to_harmonize <- harmonize_formatting(source_to_harmonize)
 

  return(source_to_harmonize)
  
}
