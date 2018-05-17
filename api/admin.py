from django.contrib import admin
from api.models import Validation, Image,History,Hospital
# Register your models here.

class ValidationAdmin(admin.ModelAdmin):
    list_display=('validation_id' ,'name', 'field_unique' ,'script', 'mapping')

class ImageAdmin(admin.ModelAdmin):
    list_display=('user' ,'hosp_id', 'record_id' ,'ipno','validation', 'date_created')

class HistoryAdmin(admin.ModelAdmin):
    list_display=('validation' ,'values','checked','note','date_created')

class HospitalAdmin(admin.ModelAdmin):
    list_display=('id' ,'name')

admin.site.register(Validation,ValidationAdmin)
admin.site.register(Image, ImageAdmin)
admin.site.register(History,HistoryAdmin)
admin.site.register(Hospital, HospitalAdmin)
