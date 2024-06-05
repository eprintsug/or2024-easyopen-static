# or2024-easyopen-static
Open Repositories 2024 - Super - Simple - Static - Sustainable

### EPrints to EasyOPEN static export

1. find a place to start
2. `~/tools/static_site.pl` looks like a useful starting point

### Things to do:

  - [x] Test to see if it does anything useful
  - [x] Understand the (emerging) format of EasyOPEN
  - [ ] Update above script to use expected paths
  - [ ] Supply a template that doesn't reference anything other than local resources
  - [ ] Check no `/cgi` URLs are referenced
  - [ ] Consider which metadata export formats to include in static content
  - [ ] Check views, especially variant versions which may have a semicolon in path (a Windows eek!?)
  - [ ] Check all URLs are relative
  - [ ] Implement a browser-side search function https://lunr.js/
  - [x] Create an export format that `lunr.js` can consume
