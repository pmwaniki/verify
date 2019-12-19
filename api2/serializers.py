from api.models import Image, Validation,History,Hospital
from rest_framework import serializers

class ImageSerializer(serializers.ModelSerializer):
	class Meta:
		model=Image
		fields=['hosp_id','record_id','ipno','date_created','file_path','validation']



class HospitalSerializer(serializers.ModelSerializer):
	class Meta:
		model=Hospital
		fields=['id','name']

class ValidationSerializer(serializers.ModelSerializer):
	class Meta:
		model=Validation
		fields=["validation_id","name",'field_unique', 'last_updated' ,'mapping']

class HistorySerializer(serializers.ModelSerializer):
	class Meta:
		model=History
		fields=["validation","values","checked","note"]