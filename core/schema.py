import graphene
from graphene_django.types import DjangoObjectType
from .models import Hospital

class HospitalType(DjangoObjectType):
    class Meta:
        model = Hospital
        fields = ('id', 'name', 'address', 'phone_number', 'email', 'website', 'capacity')

class Query(graphene.ObjectType):
    all_hospitals = graphene.List(HospitalType)

    def resolve_all_hospitals(root, info):
        return Hospital.objects.all()
