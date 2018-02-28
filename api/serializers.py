from api.models import Image, Validation,History
from rest_framework import serializers

class ImageSerializer(serializers.ModelSerializer):
	class Meta:
		model=Image
		fields=['hosp_id','record_id','ipno','date_created','file_path']


class Hospital(object):
	def __init__(self,id,name):
		self.id=id
		self.name=name

class HospitalSerializer(serializers.Serializer):
	id=serializers.IntegerField()
	name=serializers.CharField(max_length=256)

class ValidationSerializer(serializers.ModelSerializer):
	class Meta:
		model=Validation
		fields=["validation_id","name",'field_unique', 'last_updated' ,'mapping']

class HistorySerializer(serializers.ModelSerializer):
	class Meta:
		model=History
		fields=["validation","values"]