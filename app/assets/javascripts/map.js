// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var width = 1000,
    height = 1000,
    center = [-97.72409, 30.279262],
    YYYY,
    MM,
    DD,
    mapType = "eto",
    projection,
    path,
    svg,
    zips,
    url;

$('#map-form').on('submit', function(e){
    e.preventDefault();
    date = $('#map-date').val().split("-");
    YYYY = date[0];
    MM = date[1];
    DD = date[2];
    mapType = $('#map-date').val();
    $('.zips').html("");
    coloredMap();
    header();
});

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

function coloredMap() {
 
    url = "./eto/" + YYYY + "/" + MM + "/" + DD + ".json";

    d3.json( url, function( res ) {
        var paired_data = {};
        $.each( res, function(i, report ) {
            key = report["weather_station"]["zip"];
            value = report["eto"];
            paired_data[key] = value;
            createTable(key, value);
        });

        d3.json("austinzips.geojson", function(err, data) {
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
}

function getYesterdaysDate() {
    var date = new Date();
    date.setDate(date.getDate()-1);
    DD = date.getDate(); 
    MM = date.getMonth()+1;
    YYYY = date.getFullYear();
}

function createTable(zip, data) {
    var row = $('<tr>');
    var tdz = $('<td>').text(zip);
    var tdd = $('<td>').text((Math.round((data) * 100) / 100) + "in."); //round to 2 digits workaround for js
    row.append(tdz);
    row.append(tdd);
    $('#table-data').append(row);
}


function header() {
    $('#map-title').text(function(){
        if (mapType === 'eto') {
            return "Calculated Evapotranspiration";
        }
    });
    $('#date-title').text(MM + "-" + DD + "-" + YYYY);
}

getYesterdaysDate();
coloredMap();
header();
