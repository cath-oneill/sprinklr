// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var width = 1000,
    height = 1000;

$('#map').attr("width", width).attr("height", height);

var center = [-97.72409, 30.279262];
// var center = [38.996815, 34.802075];
var projection = d3.geo.conicConformal()
    .center(center)
    .clipAngle(180)
    .scale(3500)
    .translate([width / 2, height / 2]);
    //.precision(0.1);

var path = d3.geo.path().projection(projection);

var svg = d3.select("#map").append("svg")
    .attr("width", width)
    .attr("height", height);


d3.json("texas_zip_code_shapefiles.geojson", function(err, data) {
  console.log(data);
  $.each(data.geometries, function(i, geometry) {
    svg.append("path")
        .datum(geometry)
        .attr("class", "border")
        .attr("d", path)
  });
});
