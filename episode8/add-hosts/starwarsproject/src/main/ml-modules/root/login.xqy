(:
 : Copyright (c) 2004 Mark Logic Corporation
 :
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 :
 : http://www.apache.org/licenses/LICENSE-2.0
 :
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
 :
 : The use of the Apache License does not indicate that this project is
 : affiliated with the Apache Software Foundation.
 :)


declare default element namespace "http://www.w3.org/1999/xhtml";

(: import module "http://www.w3.org/2003/05/xpath-functions" at "/user-lib.xqy"; :)

xdmp:set-response-content-type("text/html; charset=utf-8"),
<html>
  <head>
    <title>ml-gradle Demo Application</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />

		<!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
  </head>
 <body>
   <div id="main">
    <div class="container">
      <div class="row">
       <div class="col-md-12" style="border-bottom:1px solid #ccc;">
         <h1 class="nomargin">Star Wars Character Heights</h1>
         <h3 class="nomargin">Please login here.</h3>
         <p></p>
       </div>
      </div>
      <div class="row" style="margin-top:10px;">
        <div class="col-md-12 text-left" style="padding: 10px;">
          <div>
          <form action="/checklogin.xqy" method="post" class="form-inline">
          <label for="username">Username:&nbsp;</label>
          <input type="username" class="form-control" id="user" placeholder="Enter username" name="user"></input>&nbsp;
          <label for="pwd">Password:&nbsp;</label>
          <input type="password" class="form-control" id="password" placeholder="Enter password" name="password"></input>&nbsp;
          <button type="login" class="btn btn-default">Login</button>
          </form>
          </div>
        </div>
      </div>
    </div>
   </div>

<!--
  <form action="checklogin.xqy" method="post">
  User Name: <br />
  <input type="text" name="user" size="20" />
  <br />
   Password: <br />
    <input type="password" name="password" size="20" />
  <br />
  <input type="submit" name="submit" value="Submit" />
  <input type="reset" name="reset" value="Clear" />
  </form>
-->

 </body>
</html>
