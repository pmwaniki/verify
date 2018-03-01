# Error verification app python backend

## Installation
```commandline
git clone ssh://username@hsuanalytics.kemri-wellce.org:/var/hsu-data/repo/cin-web/verify.git
```


where *username* is a valid username on analytics server

### Install python requirements
```commandline
cd verify
pip install -r requirements.txt
```


### Make migrations
```commandline
python manage.py makemigrations
python manage.py migrate
```


### Create super user
```commandline
./manage.py createsuperuser
```


### Start server
```commandline
./manage.py runserver 0.0.0.0:8000
```



## Create token for users
```commandline
./manage.py drf_create_token <username>
```

