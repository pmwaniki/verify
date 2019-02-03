"""
WSGI config for verify project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/1.11/howto/deployment/wsgi/
"""

import os
import django.contrib.auth.handlers.modwsgi
def check_password(environ, user, password):
    return django.contrib.auth.handlers.modwsgi.check_password(environ, user, password)

from django.core.wsgi import get_wsgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "verify.settings")

application = get_wsgi_application()
