from django.urls import include, path, re_path
from rest_framework import permissions
from rest_framework.routers import DefaultRouter
from .views import *
from drf_yasg.views import get_schema_view
from drf_yasg import openapi

router = DefaultRouter(trailing_slash=False)

schema_view = get_schema_view(
   openapi.Info(
      title="Echjan API",
      default_version='v1.0.1-pre-alpha',
      description="The simplest and most intuitive API implementation",
      terms_of_service="#",
      contact=openapi.Contact(email="feedback@sadykov-maksim.webiste"),
      license=openapi.License(name="BSD License"),
   ),
   public=True,
   permission_classes=[permissions.AllowAny],
)

urlpatterns = [
    path('', include(router.urls)),
    path('api-auth/', include('rest_framework.urls')),
    re_path('swagger(?P<format>\.json|\.yaml)', schema_view.without_ui(cache_timeout=0), name='schema-json'),
    re_path('swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    re_path('redoc/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
]
