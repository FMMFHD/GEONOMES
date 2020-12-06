from General_modules.module_DB import sqlExecute
from General_modules import global_settings

def autocomplete_geoname(str_name):
    """
        Get all the names that start with str_name
    """

    DB_NAME = global_settings.DB_NAME_GEONAMES
    db_user = global_settings.POSTGRESQL_USERNAME
    db_password = global_settings.POSTGRESQL_PASSWORD
    db_host = global_settings.POSTGRESQL_HOST
    db_port = global_settings.POSTGRESQL_PORT

    sql = "SELECT distinct name FROM {} WHERE name ilike '{}%'".format(global_settings.TABLE_NAME_GEONAMES, str_name)

    resp = sqlExecute(DB_NAME, db_user, db_password, db_host, db_port, sql, True)

    if not resp['success']:
        return []

    geonames = []

    for data in resp['data']:
        geonames.append(data[0])

    return geonames


def get_location(geoname):
    """
        For a given geoname return the latitude and longitude
    """

    DB_NAME = global_settings.DB_NAME_GEONAMES
    db_user = global_settings.POSTGRESQL_USERNAME
    db_password = global_settings.POSTGRESQL_PASSWORD
    db_host = global_settings.POSTGRESQL_HOST
    db_port = global_settings.POSTGRESQL_PORT

    sql = "SELECT latitude, longitude FROM {} WHERE name like '{}'".format(global_settings.TABLE_NAME_GEONAMES, geoname)

    resp = sqlExecute(DB_NAME, db_user, db_password, db_host, db_port, sql, True)

    if not resp['success']:
        return []

    lat_long = []

    for data in resp['data']:
        lat_long.append([data[0], data[1]])

    return lat_long
