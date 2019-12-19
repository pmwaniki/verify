from django.forms import ModelForm
from api.models import Image

class ImageForm(ModelForm):
	class Meta:
		model=Image
		exclude=('date_created',)
