from django.shortcuts import render
from rest_framework.decorators import api_view, parser_classes, authentication_classes, permission_classes
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.parsers import MultiPartParser
from api.models import Image, Hospital, Validation, History
from rest_framework.response import Response
from api.serializers import ImageSerializer, Hospital, HospitalSerializer, ValidationSerializer, HistorySerializer
from rest_framework import status
import json
from api.utils import get_errors
from django.contrib.auth import authenticate


# Create your views here.

@api_view(['GET'])
@authentication_classes((TokenAuthentication,))
@permission_classes((IsAuthenticated,))
def root_view(request, format=None):
    images = Image.objects.all()
    print(request.META)
    print(request.auth)

    hosp = request.query_params.get("hosp_id", None)
    ipno = request.query_params.get("ipno", None)
    if hosp is not None:
        images = images.filter(hosp_id=hosp)
    if ipno is not None:
        images = images.filter(ipno=ipno)

    serializer = ImageSerializer(images, many=True)

    return Response(serializer.data)


@api_view(['POST'])
@authentication_classes((TokenAuthentication,))
@permission_classes((IsAuthenticated,))
@parser_classes((MultiPartParser,))
def create_image(request, format=None):
    if request.method == "POST":
        data=request.data
        print(data)
        validation_id=data.get("validation", None)
        print(validation_id)
        if validation_id is not None:
            validation=Validation.objects.get(validation_id=validation_id)
            print(validation)
            data['validation']=validation.id
            print(data)

        serializer = ImageSerializer(data=data)
        if serializer.is_valid():
            print(serializer.validated_data)
            if request.user.id is None:
                serializer.save()
            else:
                serializer.save(user=request.user)
            print(Response(serializer.validated_data, status=status.HTTP_201_CREATED))
            # return Response(serializer.validated_data["file_path"],status=status.HTTP_201_CREATED)
            return Response(json.dumps({"message": "success"}), status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def get_hospitals(request, format=None):
    hospitals = Hospital.objects.all()
    serial = HospitalSerializer(hospitals, many=True)
    return Response(serial.data)


@api_view(['GET'])
def issues(request, format=None):  # issues?validation=pneum_reanalysis&start=2016-05-01
    query = dict(request.query_params)
    print(query)
    val = Validation.objects.get(validation_id=query.get('validation')[0])
    unique_keys=val.field_unique
    try:
        data = get_errors(query)
        for index,row in data.iterrows():
            unique_vals =json.loads(row[unique_keys].to_json())
            history = History(validation=val, values=unique_vals)
            existing=History.objects.filter(values=history.values)
            if len(existing)==0:
                history.save()
        return Response(json.loads(data.to_json(orient="table")), status=status.HTTP_200_OK)
    except Exception as err:
        return Response(str(err), status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def get_validations(request, format=None):
    query = list(Validation.objects.all().values())
    #serializer = ValidationSerializer(query, many=True)
    return Response(query)


@api_view(['GET', 'POST'])
@authentication_classes((TokenAuthentication,))
@permission_classes((IsAuthenticated,))
def history(request, format=None):
    if request.method == "GET":
        validation_type = request.query_params.get("validation")
        print(validation_type)
        if validation_type is not None:
            validation = Validation.objects.get(validation_id=validation_type)
            query = History.objects.filter(validation=validation.id)

        else:
            query = History.objects.all()
        query=list(query.values())

        return Response(query)

    if request.method == "POST":
        data = request.data
        print(data)
        validation=Validation.objects.get(validation_id=data["validation"])

        if data.get('values') is not None:
            queryset=History.objects.get(validation=validation.id,values=data['values'])


            notes=data.get('notes')
            if notes is not None:
                queryset.note=notes
            else:
                queryset.checked = not queryset.checked

            queryset.save()


        new_result=list(History.objects.all().values())
        #print(new_result)

        return Response(new_result)


@api_view(['POST'])
def change_password(request,format=None):
    username=request.data.get("username", None)
    password=request.data.get("password", None)
    new_password=request.data.get("new_password", None)
    #print(request.data)
    #print("User %s changing password from %s to %s" % (username,password,new_password))

    user=authenticate(username=username, password=password)
    if user is not None:
        user.set_password(new_password)
        user.save()
        return Response(status=status.HTTP_200_OK,data="Password changed successfully")

    else:
        return Response(status=status.HTTP_401_UNAUTHORIZED,data= "Wrong password")
