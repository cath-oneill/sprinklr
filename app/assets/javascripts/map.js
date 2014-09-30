// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var width = 960,
    height = 1160;

$('#map').attr("width", width).attr("height", height);

var center = [-97.72409, 30.279262];
// var center = [38.996815, 34.802075];
var projection = d3.geo.conicConformal()
    .center(center)
    //.clipAngle(180)
    .scale(1000)
    .translate([width / 2, height / 2]);
    // .precision(0.1);

var path = d3.geo.path().projection(projection);

var svg = d3.select("#map").append("svg")
    .attr("width", width)
    .attr("height", height);

// THIS IS SYRIA YO
// d3.json("cities.json", function(err, data) {
//   console.log(data);
//   $.each(data.features, function(i, feature) {
//     console.log(feature.geometry);
//     var name = feature.properties.NAME;
//     // if (i==0) {
//       svg.append("path")
//         .datum(feature.geometry)
//         .attr("class", "border")
//         .attr('data-name', name)
//         .attr("d", path);
//     // }
//   });
// });

// d3.json("stolen_data.geojson", function(err, data) {
//   console.log(data);
//   $.each(data.features, function(i, feature) {
//     console.log(feature.geometry);
//     var name = feature.properties.name;
//     svg.append("path")
//         .datum(feature.geometry)
//         .attr("class", "border")
//         .attr('data-name', name)
//         .attr("d", path);
//   });
// });

// d3.json("new_zipcodes.json", function(err, data) {
//   console.log(data);
//   $.each(data.features, function(i, feature) {
//     console.log(feature.geometry);
//     var name = feature.properties.ZIPCODE;
//       svg.append("path")
//         .datum(feature.geometry)
//         .attr("class", "border")
//         .attr('data-name', name)
//         .attr("d", path);
//   });
// });

d3.json("zcta5.geojson", function(err, data) {
  console.log(data);
  $.each(data.features, function(i, feature) {
    console.log(feature.geometry);
    var name = feature.properties.ZCTA5E10;
    svg.append("path")
        .datum(feature.geometry)
        .attr("class", "border")
        .attr('data-name', name)
        .attr("d", path);
  });
});
