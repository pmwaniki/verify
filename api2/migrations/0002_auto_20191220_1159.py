# Generated by Django 2.0.2 on 2019-12-20 11:59

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api2', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='validation',
            name='script',
        ),
        migrations.AddField(
            model_name='validation',
            name='url',
            field=models.URLField(default='', verbose_name='Url of error api'),
            preserve_default=False,
        ),
    ]