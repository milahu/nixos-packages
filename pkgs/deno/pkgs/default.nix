{ lib
, newScope
}:

lib.makeScope newScope (self: with self; {

  udd = callPackage ./udd {};

  webview_deno = callPackage ./webview_deno {};

})
