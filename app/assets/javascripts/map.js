// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var width = 1000,
    height = 1000,
    center = [-97.72409, 30.279262],
    projection,
    path,
    svg,
    zips,
    url;

$('#map').attr("width", width).attr("height", height);

projection = d3.geo.conicConformal()
    .center(center)
    .clipAngle(180)
    .scale(90000)
    .translate([width / 2, height / 2]);

path = d3.geo.path().projection(projection);

svg = d3.select("#map").append("svg")
    .attr({
        width: width,
        height: height
    });


zips = svg.append("g")
    .attr({
        class: "zips",
        transform: "translate(-300, 450) rotate(-53)"
    });
 
url = "./eto/2014/09/30.json";

d3.json( url, function( res ) {
    var paired_data = {};
    $.each( res, function(i, report ) {
        key = report["weather_station"]["zip"];
        value = report["eto"];
        paired_data[key] = value;
    });

    d3.json("austinzips.geojson", function(err, data) {
        console.log(data);
        $.each(data.features, function(i, feature) {
        zips.append("path")
            .datum(feature.geometry)
            .attr("id", feature.properties.NAME)
            .attr("d", path)
            .attr("class", quantize(feature.properties.NAME));
        });

        function quantize(zip) {
            eto = paired_data[zip];
            if (eto === undefined) { return }
            return "q" + Math.min(8, ~~(eto * 36)) + "-9";
        }
    });
});


