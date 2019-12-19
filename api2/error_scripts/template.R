#!/usr/bin/env Rscript
library(dplyr)
args=commandArgs(F)
cat(args,sep="\n")

start_str=grepl('start',args,ignore.case = T) 
stop_str=grepl('stop',args,ignore.case = T)
file_str=grepl('file',args,ignore.case = T)

start_date=''
stop_date=''
path_to_files=getwd()
if(any(start_str)){
  start_date=strsplit(args[start_str],"=")[[1]][2] %>% as.Date()
}
if(any(stop_str)){
  stop_date=strsplit(args[stop_str],"=")[[1]][2] %>% as.Date()
}
if(any(file_str)){
  path_to_files=dirname(strsplit(args[file_str],"=")[[1]][2])
}


cat(sprintf("Start: %s, Stop: %s, dir:%s",start_date,stop_date,path_to_files))
