from osgeo import gdal

# Open the source DEM file
# source_dem_path = 'path_to_your_dem.tif'  # Replace with the path to your DEM file
source_dem_path = "../../data/DEM_cropped_extent_v01/file_I_want.tif"

source_dem = gdal.Open(source_dem_path, gdal.GA_ReadOnly)

# Get the GeoTransform and update it for the downsampled DEM
geo_transform = list(source_dem.GetGeoTransform())
geo_transform[1] *= 2  # Double the pixel resolution (width) for downsampling
geo_transform[5] *= 2  # Double the pixel resolution (height) for downsampling

# Get the raster band and no data value
source_band = source_dem.GetRasterBand(1)
no_data_value = source_band.GetNoDataValue()

# Calculate the new dimensions
new_width = source_band.XSize // 2
new_height = source_band.YSize // 2

# Create the destination DEM file
driver = gdal.GetDriverByName('GTiff')
downsampled_dem_path = 'path_to_downsampled_dem.tif'  # Replace with the desired output path
downsampled_dem = driver.Create(downsampled_dem_path, new_width, new_height, 1, source_band.DataType)
downsampled_dem.SetGeoTransform(geo_transform)
downsampled_dem.SetProjection(source_dem.GetProjection())

# Perform the downsampling - this uses nearest neighbor resampling method
gdal.ReprojectImage(source_dem, downsampled_dem, None, None, gdal.GRA_NearestNeighbour)

# If the source DEM has a no data value, set it for the downsampled DEM as well
if no_data_value is not None:
    downsampled_dem.GetRasterBand(1).SetNoDataValue(no_data_value)

# Close the DEMs
source_dem = None
downsampled_dem = None

# Output the path to the downsampled DEM
print(f'Downsampled DEM saved to: {downsampled_dem_path}')
