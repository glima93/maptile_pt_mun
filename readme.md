# Maptile Geography: pt_mun, v.0.1

Mainland Portuguese municipalities for Stata's [maptile](https://michaelstepner.com/maptile/) package. 
Maptile, written by [Michael Stepner](https://github.com/michaelstepner/maptile), provides a simple method to map a variable in Stata. 

## How to install it?
First, if you haven't done it aleady, install maptile and spmap:
`ssc install maptile`
`ssc intall spmap`

For now, the only option to install this geography is manually. 
Unzip "geo_pt_mun.rar" and save it in PERSONAL/maptile_geographies, which is where maptile loads geographies automatically.
Alternatively you can save it in any folder in your computer and pass it on to the `, geofolder(folder_path)` option in the `maptile` command. 

## Using the geography

 1. Choose your dataset wisely. Make sure it has data by municipality level, identified by official 4-digit DICO municipality codes for mainland Portugal. (There is a toy dataset in the "geo_pt_mun_creation" folder.)

2. Choose the variable you want to map. 

 3. Run maptile and specify the geography name (pt_mun):
    `maptile [varname], geo(pt_mun)`
    
 4. To see the geography's help file, use: 
    `maptile_geohelp pt_mun`
    
 ## Example

Here's how it looks! To create a pretty plot like this, you simply run `maptile [varname], geo(pt_mun)`.
![Sample map plot](/geo_pt_mun_creation/tests/pt_mun/pt_mun_test_real1.png) 

## Further
I plan to roll out tiles for additional administrative boundaries (NUTSII, NUTSIII, districts, parishes), as time permits.

## For the replication files

There are two ways to run the code that builds this maptile geo template:

1. Build using -project-

- Install the project command using `ssc install project`.
- Then run `project, setup` and choose the do-file that begins with "build_".
- Then run `project build_<geoname>, build`.

2. Build interactively

- Open the do-file that begins with "build_"
- Edit the line that reads `global root "/Users/Gonçalo/Documents/GitHub/maptile_pt_mun/geo_pt_mun_creation"`.  Replace the folder in that line with the folder on your computer that contains this do-file.
- Run this do-file.

All templates based on the amazing work of Michael Stepner, stepner@mit.edu.
