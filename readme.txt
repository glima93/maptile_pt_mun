There are two ways to run the code that builds this maptile geo template:

1. Build using -project-

* Install the project command using `ssc install project`.
* Then run `project, setup` and choose the do-file that begins with "build_".
* Then run `project build_<geoname>, build`.

2. Build interactively

* Open the do-file that begins with "build_"
* Edit the line that reads `global root "C:/Users/Gonçalo/Documents/GitHub/maptile_pt_mun/geo_pt_mun_creation"`.  Replace the folder in that line with the folder on your computer that contains this do-file.
* Run this do-file.

Templates based on the amazing work of Michael Stepner, stepner@mit.edu.