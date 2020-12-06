from django.conf.urls import url

from GeoNames.views import view_autocomplete_geoname, view_get_location_for_geoname

urlpatterns = [
    url(r'^autocomplete$', view_autocomplete_geoname, name='autocomplete_geoname'),
    url(r'^location$', view_get_location_for_geoname, name='get_location_for_geoname'),
]