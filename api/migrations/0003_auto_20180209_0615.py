# Generated by Django 2.0.2 on 2018-02-09 06:15

import api.models
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_auto_20180209_0614'),
    ]

    operations = [
        migrations.AlterField(
            model_name='validation',
            name='mapping',
            field=api.models.DictField(help_text='Dict of mapping between  {}', max_length=500, verbose_name='Mapping'),
        ),
    ]
