#!/usr/bin/env Rscript
library(dplyr)
args=commandArgs(T)
cat(args,sep="\n")

start_str=grepl('start',args,ignore.case = T) 
stop_str=grepl('stop',args,ignore.case = T)

start_date=''
stop_date=''
if(any(start_str)){
  start_date=strsplit(args[start_str],"=")[[1]][2] %>% as.Date()
}
if(any(stop_str)){
  stop_date=strsplit(args[stop_str],"=")[[1]][2] %>% as.Date()
}

cat(sprintf("Start: %s, Stop: %s",start_date,stop_date))
