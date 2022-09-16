date_time <- function(data){
  
  
  # Date and time:
  bsed_format <- "%Y-%m-%d"
  bsed_pattern <- "[0-9]{4}-[0-9]{2}-[0-9]{2}"
  bsetm_format <- "%H:%M"
  bsetm_pattern <- "[0-9]{2}:[0-9]{2}"
  
  
  # BSETM 
  # checked BSETM first because in some cases BSETM can be extracted from BSED (eg. BSED: 2017-09-18T13:49:00)
  if("BSETM" %in% names(data)){
    
    # parse from BSED, if BSETM is NA
    if("BSED" %in% names(data)){
      data <- data %>% 
        dplyr::mutate(BSETM = ifelse(is.na(BSETM),                                                              # parsing from BSED only when BSETM is NA
                                     ifelse(str_detect(BSED, bsetm_pattern), str_extract(BSED, bsetm_pattern),  # parsing from BSED instead of BSETM
                                            BSETM),
                                     BSETM)
                      ) 
      
    } else {
      data <- data
    } 
    
    # parse from BSETM if BSETM is not NA (based on format)
    data <- data %>% 
      dplyr::mutate(BSETM = ifelse(!is.na(BSETM),
                                   ifelse(str_detect(BSETM, bsetm_pattern), str_extract(BSETM, bsetm_pattern),
                                          ifelse(!str_detect(BSETM, fixed(bsetm_pattern)),format(strptime(BSETM, "%H:%M"),format=bsetm_format), BSETM)),
                                   BSETM)
      )  # %I:01-12 hour format, %H:01-23 hour format, %M:00-59 minute format
  } else {
    data <- data 
  }
  
  
  
  ## BSED
  if("BSED" %in% names(data)){
    data <- data %>% 
      dplyr::mutate(BSED = ifelse(!is.na(BSED), 
                                  ifelse(str_detect(BSED, bsed_pattern), str_extract(BSED, bsed_pattern),
                                         ifelse(!str_detect(BSED, bsed_pattern),format(strptime(BSED, "%Y%m%d"),format = bsed_format),BSED)),
                                         BSED)
                    )  
                                         
                                  
  } else {
    data <- data 
  }
  
  return(data)

}
  