import json

from django.http import HttpResponse, HttpResponseRedirect

from GeoNames.utils import autocomplete_geoname, get_location


def view_autocomplete_geoname(request):
    out = []
    if request.method == 'GET':
        str_name = request.GET['str_name']

        out = autocomplete_geoname(str_name)

    return HttpResponse(json.dumps(out), content_type='application/json', status=200)


def view_get_location_for_geoname(request):
    out = {}
    if request.method == 'GET':
        geoname = request.GET['geoname']

        out['coordinates'] = get_location(geoname)

    return HttpResponse(json.dumps(out), content_type='application/json', status=200)