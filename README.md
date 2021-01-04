# GeoNames

The objectives of the GeoNames component is to facilitate the conversion between toponyms and coordinates. Besides storage, it offers access mechanisms for a framework where web applications with geospatial data are developed. GeoNames architecture is illustrated in figure below. The backend part is responsible for data download and for managing data access.

![GeoNames Diagram](https://github.com/FMMFHD/GeoNames/blob/main/img_readme/GeoNames_diagram.png)

GeoNames is a geographical database that covers all countries and contains over eleven million toponyms. For each toponym it gives information about: latitude, longitude, population, etc.

The API has two access points. The first access point offers the possibility to auto complete sub-strings of toponyms. In other words, this feature will suggest toponyms that start with the same sub-string. The answer of the request is a list with the possible toponyms. The second access point offers the possibility to return all possible locations (several places may have the same name) for a given toponym. The answer of the request is a list with the all the possible coordinates.