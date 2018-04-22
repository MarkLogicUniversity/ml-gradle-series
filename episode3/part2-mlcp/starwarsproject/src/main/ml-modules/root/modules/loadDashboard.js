// Load the Visualization API and the controls package.
google.charts.load('current', {'packages':['corechart', 'controls', 'table']});

// Set a callback to run when the Google Visualization API is loaded.
google.charts.setOnLoadCallback(drawDashboard);

// Callback that creates and populates a data table,
// instantiates a dashboard, a range slider and a pie chart,
// passes in the data and draws it.
function drawDashboard() {

  // Create our data table.
  var jsonData = $.ajax({
    headers: { 'X-DataSource-Auth': 'localhost:8090' },
    url: "http://localhost:8090/v1/resources/starwarsChartData",
    dataType: "json",
    async: false
    }).responseText;

  // Create our data table out of JSON data loaded from server.
  var data = new google.visualization.DataTable(jsonData);

  // Create a dashboard.
  var dashboard = new google.visualization.Dashboard(
      document.getElementById('dashboard_div'));

  // Create a range slider, passing some options

  var viewRangeSlider = new google.visualization.ControlWrapper({
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
  var tableChart = new google.visualization.ChartWrapper({
    'chartType': 'Table',
    'containerId': 'table_div',
    'options': {
      'width': 300,
      'height': 300,
      'page': 'enable',
      'alternatingRowStyle': true,
      'showRowNumber' : true
    }
  });

  // Create a pie chart, passing some options
/*  var pieChart = new google.visualization.ChartWrapper({
    'chartType': 'PieChart',
    'containerId': 'chart_div',
    'options': {
      'width': 500,
      'height': 500,
      'pieSliceText': 'value',
      'legend': 'right'
    }
  });
*/
  var pieChart = new google.visualization.ChartWrapper({
    'chartType': 'ColumnChart',
    'containerId': 'chart_div',
    'options': {
      'title': 'Character Heights (meters)',
      'width': 500,
      'height': 500,
      'legend': 'left'
    }
  });

  // Establish dependencies, declaring that 'filter' drives 'pieChart',
  // so that the pie chart will only display entries that are let through
  // given the chosen slider range.
  dashboard.bind(viewRangeSlider, [tableChart, pieChart]);
  //dashboard.bind(viewRangeSlider, pieChart);

  // Draw the dashboard.
  dashboard.draw(data);

}
