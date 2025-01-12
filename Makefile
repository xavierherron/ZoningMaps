.PHONY : all
all : residential_density.kml built_residential_density.kml structural_density.kml intersected.kml unrealized_tax_revenue.kml zoning.csv

zoning.csv : intersected.json
	python density.py -raw $< > $@

residential_density.kml : intersected.json
	python density.py -residency $< > $@

structural_density.kml : intersected.json
	python density.py -sqft $< > $@

built_residential_density.kml : intersected.json
	python density.py -current-residency $< > $@

unrealized_tax_revenue.kml : intersected.json
	python density.py -tax $< > $@

intersected.kml : intersected.json
	python mapping.py $< > $@

intersected.json intersected.json.savestate : | Zoning_PreAug2012.geojson Zoning_BaseDistricts.geojson
	python intersect_maps.py Zoning_PreAug2012.geojson Zoning_BaseDistricts.geojson intersected.json.savestate > $@
