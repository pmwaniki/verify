
from django.conf.urls import url
from api import views
from rest_framework.urlpatterns import format_suffix_patterns

app_name='images'
urlpatterns=[
	url(r"^$", views.root_view),
	url(r"^hospitals/$",views.get_hospitals),
	url(r"^new/$",views.create_image),
	url(r"^issues/$", views.issues),
	url(r"^validations/$",views.get_validations),
	url(r"^history/$",views.history),
	url(r'change_password/',views.change_password),

]

urlpatterns=format_suffix_patterns(urlpatterns)
