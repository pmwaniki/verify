# Generated by Django 2.0.2 on 2018-05-16 11:14

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0005_auto_20180418_1143'),
    ]

    operations = [
        migrations.AddField(
            model_name='image',
            name='validation',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.Validation'),
        ),
    ]