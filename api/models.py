from django.db import models
from django.contrib.auth.models import User
import time
import json

# Create your models here.
class Hospital(models.Model):
    id=models.IntegerField(primary_key=True,help_text='Hospital Id')
    name=models.CharField(max_length=250,help_text='Hospital name')

def get_upload_filename(instance, filname):
    return "uploaded_media/file_%s %s" % (time.strftime("%Y-%m-%d %H_%M_%S"), filname)

class Image(models.Model):

    file_types = ((1, "jpeg/png"), (2, "pdf"))
    user=models.ForeignKey(User,blank=True,null=True,on_delete=models.CASCADE)
    hosp_id = models.ForeignKey(Hospital,on_delete=models.CASCADE)
    record_id=models.CharField(max_length=100,verbose_name="Record id")
    ipno = models.CharField(max_length=250, verbose_name="iP Number")
    date_created=models.DateField(auto_now_add=True)
    file_path = models.FileField(upload_to=get_upload_filename, verbose_name= "image file")






    def __str__(self):
        return 'Hospital: {0}, ipno: {1}'.format(self.get_hosp_id_display(), self.ipno)






class DictField(models.Field):
    def __init__(self,max_length,*args,**kwargs):
        self.max_length=max_length
        kwargs["max_length"]=max_length
        super().__init__(*args,**kwargs)

    def db_type(self, connection):
        return "varchar(%s)" % self.max_length

    def from_db_value(self, value, expression, connection):
        if value is None:
            return value
        return json.loads(value)
    def to_python(self, value):
        if isinstance(value,dict):
            return value
        if value is None:
            return value
        return json.loads(value)

    def get_prep_value(self, value):
        if value is None:
            return None
        return json.dumps(value,sort_keys=True)

class ListField(models.Field):
    def __init__(self,max_length,sort=False,*args,**kwargs):
        self.max_length=max_length
        self.sort=sort
        kwargs["max_length"]=max_length
        super().__init__(*args,**kwargs)

    def db_type(self, connection):
        return "varchar(%s)" % self.max_length

    def from_db_value(self, value, expression, connection):
        if value is None:
            return value
        return json.loads(value)
    def to_python(self, value):
        if isinstance(value,dict):
            return value
        if value is None:
            return value
        return json.loads(value)

    def get_prep_value(self, value):
        if value is None:
            return None
        if self.sort:
            return json.dumps(sorted(value))
        return json.dumps(value)

class Validation(models.Model):
    validation_id=models.CharField(unique=True,max_length=30,verbose_name="Validation id")
    name=models.CharField(max_length=100,verbose_name="Name of validation")
    field_unique=ListField(max_length=500,verbose_name="Unique Fields")
    last_updated=models.DateTimeField(verbose_name="Last updated",blank=True,null=True)
    script=models.CharField(max_length=100,verbose_name="Error script")
    mapping=DictField(max_length=500,verbose_name="Mapping",help_text="Dict of mapping between  {}")

class History(models.Model):
    validation=models.ForeignKey(Validation,on_delete=models.CASCADE)
    values=DictField(max_length=1000,blank=True,null=True)