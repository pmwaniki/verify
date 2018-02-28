

tryCatch({
  quiet<-capture.output({ #code in this block will not print output
    #put your code here
    library(jsonlite)
    print("something") # this will not be printed to console
    #put file logic here
    data<-mtcars
    
    data_json<-toJSON(data)
  })
  
  #return data as json
  write(data_json,file=stdout())
  },error=function(e) write("Script failled",stderr())
)



