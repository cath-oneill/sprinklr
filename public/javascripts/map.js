// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var width = 1000,
    height = 1000;

$('#map').attr("width", width).attr("height", height);

var center = [-97.72409, 30.279262];

var projection = d3.geo.conicConformal()
    .center(center)
    .clipAngle(180)
    .scale(90000)
    .translate([width / 2, height / 2]);
    //.precision(0.1);

var path = d3.geo.path().projection(projection);

var svg = d3.select("#map").append("svg")
    .attr("width", width)
    .attr("height", height);

var quantize = d3.scale.quantize()
    .domain([0, .15])
    .range(d3.range(9).map(function(i) { return "q" + i + "-9"; }));

var zips = svg.append("g")
    .attr("class", "zips");
 
d3.json("austinzips.geojson", function(err, data) {
  console.log(data);
  $.each(data.features, function(i, feature) {
    zips.append("path")
        .datum(feature.geometry)
        .attr("id", feature.properties.NAME)
        .attr("d", path);
  });
});


// d3.json("unemployment.json", function(json) {
//   data = json;

//   zips.selectAll("path")
//       .attr("class", quantize);
// });
