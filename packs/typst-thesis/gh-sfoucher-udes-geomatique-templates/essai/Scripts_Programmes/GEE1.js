// 1. Sherbrooke avec une zone tampon de 500 m
var bufferedTable = sherbrooke.map(function(feature) { 
  return feature.buffer(500); 
}); 
var geom = bufferedTable.geometry();

// 2. Mosaïque à partir de l'image satellite de Sherbrooke
var mosaique = ee.Image('COPERNICUS/S2_SR_HARMONIZED/20210904T153809_20210904T154631_T18TYR')
  .clip(geom); 

// 3. Calcul et affichage du NDVI
var ndvi = mosaique.normalizedDifference(['B8', 'B4']).rename('NDVI'); 
Map.addLayer(ndvi, {min: 0, max: 1, palette: ['blue', 'white', 'green']}, 'Sherbrooke - NDVI'); 

// 4. Exporter le NDVI vers Google Drive 
Export.image.toDrive({ 
  image: ndvi, 
  description: 'sherbrooke_NDVI_500m', 
  folder: 'NDVI_500m', 
  fileNamePrefix: 'sherbrooke_NDVI_500m', 
  region: geom.bounds(), 
  scale: 10, 
  crs: 'EPSG:4326', 
  maxPixels: 1e13 
});