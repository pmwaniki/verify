# Generated by Django 2.0.2 on 2018-04-18 06:37

import api.models
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_auto_20180418_0625'),
    ]

    operations = [
        migrations.AddField(
            model_name='history',
            name='date_created',
            field=models.DateField(auto_now=True, help_text='Date created'),
        ),
        migrations.AlterField(
            model_name='history',
            name='checked',
            field=models.BooleanField(default=False, help_text='Verified?'),
        ),
        migrations.AlterField(
            model_name='history',
            name='values',
            field=api.models.DictField(help_text='Unique identifier', max_length=1000),
        ),
    ]
