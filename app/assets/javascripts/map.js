// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var width = 960,
    height = 1160;

var svg = d3.select("#map").append("svg")
    .attr("width", width)
    .attr("height", height);

$('#map').attr("width", width).attr("height", height);

var center = [30.25, -97.75];


