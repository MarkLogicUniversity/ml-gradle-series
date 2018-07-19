// Add a property named "NEWPROP" to any JSON input document.
// Otherwise, input passes through unchanged.

function setPermissions(content, context)
{
  const permissions = (context.permissions == undefined)
                 ? "UNDEFINED" : context.permissions;

  if (xdmp.nodeKind(content.value) == 'document' &&
      content.value.documentFormat == 'JSON') {
    // Convert input to mutable object and add new property
    const newDoc = content.value.toObject();

    // xdmp.log('Doc uri = ' + content.uri);
    // xdmp.log('Doc permissions = ' + JSON.stringify(permissions));

    let docPermissions = [];
    if (newDoc.alliance === 'rebel') {
      docPermissions = [{"capability":"read","roleId": xdmp.role('rebel-reader')},{"capability":"update","roleId": xdmp.role('starwars-writer')}];
    }
    else if (newDoc.alliance === 'empire') {
      docPermissions = [{"capability":"read","roleId": xdmp.role('empire-reader')},{"capability":"update","roleId": xdmp.role('starwars-writer')}];
    }
    else {
      docPermissions = [{"capability":"read","roleId": xdmp.role('starwars-reader')},{"capability":"update","roleId": xdmp.role('starwars-writer')}];
    }
    context.permissions = docPermissions;

    // Convert result back into a document
    content.value = xdmp.unquote(xdmp.quote(newDoc));
  }
  return content;
};

exports.setPermissions = setPermissions;
