'use strict';

function get(context, params) {

  // check for Google Chart API security header
  if (fn.empty(xdmp.getRequestHeader('X-DataSource-Auth'))) {
      xdmp.log('starwarsChartData: missing Google Chart header, X-DataSource-Auth');

      returnErrToClient(400, 'Bad Request',
       'Missing required Google Chart Data Source header');
    // unreachable - control does not return from fn.error
  }

  // star wars character name element
  const charNameElement = fn.QName("", "name");
  // star wars character height element
  const heightElement = fn.QName("","height");

  // create a query to limit the character name's returned to the given range of
  //  heights.
  // Default is all heights up equal to or less than 10.0 meters.
  const lowerBounds = xdmp.getRequestField('startHeight', '0.0');
  const upperBounds = xdmp.getRequestField('endHeight', '10.0');
  const viewQuery = cts.andQuery([ cts.elementRangeQuery(heightElement, '>=', lowerBounds),
      cts.elementRangeQuery(heightElement, '<=', upperBounds) ]);

  // an element reference to the character name element used
  // to get the character name values from indexed values
  const charNameElementRef = cts.elementReference(charNameElement);
  // same to get the height values from indexed values
  const heightElementRef = cts.elementReference(heightElement);

  // create the return data to Google Charts in the required JSON object structure
  let report =
  {
    "cols": [{
      "id": "character",
      "label": "Character Name",
      "type": "string"
    }, {
      "id": "height",
      "label": "Height (meters)",
      "type": "number"
    }],
    "rows": []
  };

  // return values sorted by frequency order, descending so sorted by most to least viewed courses
  let sortOrder = ['frequency-order','descending'];

  // get the sorted values of courses
  // for each character name, get it's height value
  for (let name of cts.values(charNameElementRef, null, sortOrder, viewQuery)) {
    let query = cts.andQuery([viewQuery,
        cts.elementValueQuery(charNameElement, name)]);

    // add a new row of data to the Google Chart JSON object
    let rowObj = {
      c: []
    };

    rowObj.c.push({
      v: name.toString()
    });

    // given a character name, get the height from the values index
    sortOrder = ['item-order','descending'];
    const charHeight = cts.values(heightElementRef, null, sortOrder, query);
    //xdmp.log("char name=" + name + " height=" + charHeight.toString());

    // save the character height to the returning row
    rowObj.c.push({
      v: Number(charHeight)
    });

    report.rows.push(rowObj);
  };

  // set the return mimetype to JSON data
  context.outputTypes = ["application/json"];

  //xdmp.log(JSON.stringify(report));
  return report;
};

// Helper function that demonstrates how to return an error response
// to the calling client.

// You MUST use fn.error in exactly this way to return an error to the
// client. Raising exceptions or calling fn.error in another manner
// returns a 500 (Internal Server Error) response to the client.
function returnErrToClient(statusCode, statusMsg, body)
{
  fn.error(null, 'RESTAPI-SRVEXERR',
           Sequence.from([statusCode, statusMsg, body]));
  // unreachable - control does not return from fn.error.
};

exports.GET = get;
