# Error verification app python backend

## Installation
git clone ssh://<username>@hsuanalytics.kemri-wellce.org:/var/hsu-data/repo/cin-web/verify.git

where <username> is a valid username on analytics server

### Install python requirements
cd verify
pip install -r requirements.txt

### Make migrations
python manage.py makemigrations
python manage.py migrate

### Create super user
./manage.py createsuperuser

### Start server
./manage.py runserver 0.0.0.0:8000


## Create token for users
./manage.py drf_create_token <username>
