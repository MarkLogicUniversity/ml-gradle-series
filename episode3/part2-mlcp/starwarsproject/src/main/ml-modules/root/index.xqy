xquery version "1.0-ml";

declare function local:show-charts()
{
	local:load-dashboard()
};

declare function local:load-dashboard()
{
  <div>
  	<div class="row padding-top-1">
      <div class="col-md-12">
				<div id="dashboard_div">
					<table width="100%">
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td><div id="filter_div"></div></td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td><div id="table_div"></div></td>
							<td style="padding-left: 5px; align=top;"><div id="chart_div"></div></td>
						</tr>
					</table>
				</div>
			</div>
  	</div>
  </div>
 };

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
            <div class="col-md-12">
                <div id="post-31" class="post-31 page type-page status-publish hentry singular">
                    <div class="entry">
                        <div class="row"  style="border-bottom: 1px solid #eee;">
                            <div class="col-md-12">
                                <h1 class="nomargin">Star Wars Character Heights
                                </h1>
                                <p></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row padding-top-1">
            <div class="col-md-2  text-left">
                &nbsp;
            </div>
            <div class="col-md-10">
                { local:show-charts() }
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
