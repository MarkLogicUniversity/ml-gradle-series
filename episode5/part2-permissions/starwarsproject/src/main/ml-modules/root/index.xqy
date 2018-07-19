xquery version "1.0-ml";

declare function local:show-charts()
{
	local:load-dashboard()
};

declare function local:load-dashboard()
{
	<div id="dashboard_div">
		<table width="100%">
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="80%"><div id="filter_div"></div></td>
				<td width="20%">&nbsp;</td>
			</tr>
			<tr>
				<td width="100%"><div id="table_div"></div></td>
			</tr>
			<tr>
				<td width="100%" style="padding-left: 5px; align=top;"><div id="chart_div"></div></td>
			</tr>
		</table>
	</div>
};

(: get the current logged in user. if the user is the default-user for the app server, redirect
	to the login xquery page.
:)
let $current-user := xdmp:get-current-user()
return
	if ($current-user = "starwars-reader") then
		xdmp:redirect-response ("login.xqy")
	else
xdmp:set-response-content-type("text/html; charset=utf-8"),
'<!DOCTYPE html>',

<html xmlns="http://www.w3.org/1999/xhtml" class="no-js" lang="en-US">

<head>
    <title>ml-gradle Demo Application</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />

		<!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script type="text/javascript" src="/modules/loadDashboard.js"></script>
</head>

<body>

<div class="header-bar"> </div>

<div id="main">
    <div class="container">
        <div class="row">
            <div class="col-md-12" style="border-bottom:1px solid #ccc;">
                <h1 class="nomargin">Star Wars Character Heights</h1>
                <p></p>
            </div>
        </div>

				<!-- display who is logged in and a logout button -->
				<div class="row" style="margin-top:10px;">
            <div class="col-md-12 text-left" style="padding: 10px;">
                <div>
									<p>Welcome { xdmp:get-current-user() }! You are successfully logged in.</p>
                  <p><a href="logout.xqy"><button type="default" class="btn btn-default">Logout</button></a></p>
                </div>
            </div>
        </div>
				<!-- end of logged-in/logout  div area -->

				<!-- display starwars character data in google charts -->
        <div class="row padding-top-1">
	          <div class="col-md-12">
                { local:show-charts() }
            </div>
        </div>
				<!-- end of google charts div area -->
				<div class="row padding-top-1" style="padding: 20px;">
            <div class="col-md-12">
                &nbsp;
            </div>
        </div>
    </div>
</div>

<footer id="footer">
    <div class="container">
        <div class="row copyright">
            <div class="col-sm-12">
                Copyright<sup>&copy;</sup> &nbsp;{fn:year-from-date(fn:current-date())} &nbsp;MarkLogic Corporation.        MARKLOGIC<sup>&reg;</sup> is a registered trademark of MarkLogic Corporation.
            </div>
        </div>
    </div>
</footer>

</body>
</html>
