// set the host and port of the MarkLogic REST api server
// note: if you change the value of mlHost and/or mlRestPort
//  in the gradle.properties file, the host and port
//  values below will also have to reflect the new values and
//  this file will need to re-deployed to the project's module
//  database. See https://github.com/marklogic-community/ml-gradle/wiki/Watching-for-module-changes
const host = 'localhost';
const port = '9010';

// Load the Visualization API and the controls package.
google.charts.load('current', {'packages':['corechart', 'controls', 'table']});

// Set a callback to run when the Google Visualization API is loaded.
google.charts.setOnLoadCallback(drawDashboard);

// Callback that creates and populates a data table,
// instantiates a dashboard, a range slider and a pie chart,
// passes in the data and draws it.
function drawDashboard() {

  // Create our data table.
  let jsonData = $.ajax({
    headers: { 'X-DataSource-Auth': `${host}:${port}` },
    url: `http://${host}:${port}/v1/resources/starwarsChartData`,
    dataType: 'json',
    async: false
    }).responseText;

  // Create our data table out of JSON data loaded from server.
  let data = new google.visualization.DataTable(jsonData);

  // Create a dashboard.
  let dashboard = new google.visualization.Dashboard(
      document.getElementById('dashboard_div'));

  // Create a range slider, passing some options

  let viewRangeSlider = new google.visualization.ControlWrapper({
    'controlType': 'NumberRangeFilter',
    'containerId': 'filter_div',
    'options': {
      'filterColumnLabel': 'Height (meters)',
      'ui': {
        'label': 'Filter by Height (meters)',
        'labelSeparator': ':',
        'step' : 0.1,
        'unitIncrement' : 0.1,
        'showRangeValues' : true
      }
    }
  });

  // Create a table chart, passing some options
  let tableChart = new google.visualization.ChartWrapper({
    'chartType': 'Table',
    'containerId': 'table_div',
    'options': {
      'width': '100%',
      'height': '50%',
      'page': 'enable',
      'alternatingRowStyle': true,
      'showRowNumber' : true
    }
  });

  let colChart = new google.visualization.ChartWrapper({
    'chartType': 'ColumnChart',
    'containerId': 'chart_div',
    'options': {
      'title': 'Character Heights (meters)',
      'width': '50%',
      'height': '50%',
      'legend': 'left'
    }
  });

  colChart.setView({'columns': [0,1]});


  // Establish dependencies, declaring that 'filter' drives 'pieChart',
  // so that the pie chart will only display entries that are let through
  // given the chosen slider range.
  dashboard.bind(viewRangeSlider, [tableChart, colChart]);
  // dashboard.bind(viewRangeSlider, pieChart);
  // dashboard.bind(viewRangeSlider, tableChart);

  // Draw the dashboard.
  dashboard.draw(data);

}
