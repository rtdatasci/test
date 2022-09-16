harmonize_formatting <- function(data) {
  
  # change to caps
  data <- data %>% 
    mutate(across(everything(), as.character)) %>%
    mutate_all(.funs = toupper)
  
  # harmonize special characters
  data <- data %>% 
    mutate_all(~str_replace_all(., ",", " ")) %>% 
    mutate_all(~str_replace_all(., "  ", " ")) %>%
    mutate_all(list(~ str_replace_all(., "\\*", ""))) %>%
    mutate_all(list(~ trimws(.))) %>%
    mutate_all(~ ifelse(. %in% c("N/A", "null", "", "NA"), NA_character_, .)) 
  
  return(data)
  
}

