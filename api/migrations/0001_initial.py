# Generated by Django 2.0.2 on 2018-03-14 08:40

import api.models
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='History',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('values', api.models.DictField(blank=True, max_length=1000, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Hospital',
            fields=[
                ('id', models.IntegerField(help_text='Hospital Id', primary_key=True, serialize=False)),
                ('name', models.CharField(help_text='Hospital name', max_length=250)),
            ],
        ),
        migrations.CreateModel(
            name='Image',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('record_id', models.CharField(max_length=100, verbose_name='Record id')),
                ('ipno', models.CharField(max_length=250, verbose_name='iP Number')),
                ('date_created', models.DateField(auto_now_add=True)),
                ('file_path', models.FileField(upload_to=api.models.get_upload_filename, verbose_name='image file')),
                ('hosp_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.Hospital')),
                ('user', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Validation',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('validation_id', models.CharField(max_length=30, unique=True, verbose_name='Validation id')),
                ('name', models.CharField(max_length=100, verbose_name='Name of validation')),
                ('field_unique', api.models.ListField(max_length=500, verbose_name='Unique Fields')),
                ('last_updated', models.DateTimeField(blank=True, null=True, verbose_name='Last updated')),
                ('script', models.CharField(max_length=100, verbose_name='Error script')),
                ('mapping', api.models.DictField(help_text='Dict of mapping between  {}', max_length=500, verbose_name='Mapping')),
            ],
        ),
        migrations.AddField(
            model_name='history',
            name='validation',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='api.Validation'),
        ),
    ]
