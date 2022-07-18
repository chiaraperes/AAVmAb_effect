run("Close All");

directory0=getDirectory("Choose the directory of ROI for image crop");
roiManager("Open", directory0+"Arrossamento_2.roi");
roiManager("Open", directory0+"Arrossamento_carta.roi");

directory=getDirectory("Choose image directory");
tag="1227"; //insert mouse tag
num="05_"; //insert number of observation
filename=tag+"_5_40_WL.tif"
open(directory+num+tag+"_5_40_WL.tif");
//open(directory+"02_1438_5_40_WL.tif");
run("Z Project...", "projection=[Average Intensity]");

roiManager("Select", 0);
run("Duplicate...", " ");
run("Rotate 90 Degrees Left");
saveAs("Tiff", directory+tag+"\\"+filename);
selectWindow(filename);

run("Split Channels");

selectWindow("AVG_"+num+tag+"_5_40_WL.tif");
roiManager("Select", 1);
run("Duplicate...", " ");
run("Split Channels");

imageCalculator("Divide create 32-bit", "AVG_"+num+tag+"_5_40_WL-1.tif (red)","AVG_"+num+tag+"_5_40_WL-1.tif (blue)");
selectWindow("Result of AVG_"+num+tag+"_5_40_WL-1.tif (red)");
run("Select All");
run("Measure");
close();
selectWindow("AVG_"+num+tag+"_5_40_WL-1.tif (red)");
run("Select All");
run("Measure");
close();
selectWindow("AVG_"+num+tag+"_5_40_WL-1.tif (green)");
run("Select All");
run("Measure");
close();
selectWindow("AVG_"+num+tag+"_5_40_WL-1.tif (blue)");
run("Select All");
run("Measure");
close()
saveAs("Results", directory+tag+"\\Results.txt");

selectWindow(filename+" (green)");
close();
selectWindow(filename+" (red)");
run("Duplicate...", " ");
run("Threshold...");
setThreshold(48, 255);
setOption("BlackBackground", true);
run("Convert to Mask");
run("Analyze Particles...", "size=5000-Infinity display clear include add");
roiManager("Save", directory+"//"+tag+"//MouseMask.roi");
roiManager("Delete");
run("Divide...", "value=255");
saveAs("Tiff", directory+"//"+tag+"//MouseMask.tif");

////////////////////////////////////////////////////////////////////////////

imageCalculator("Divide create 32-bit", filename+" (red)",filename+" (blue)");
run("Enhance Contrast...", "saturated=0 normalize");
saveAs("Tiff", directory+"//"+tag+"//RedOverBlue.tif");

//////////////////////////////////////////////////////////////////////////

selectWindow("RedOverBlue.tif");
run("Duplicate...", " ");
run("Median...", "radius=60");
imageCalculator("Subtract create 32-bit", "RedOverBlue.tif","RedOverBlue-1.tif");
imageCalculator("Multiply create 32-bit", "MouseMask.tif","Result of RedOverBlue.tif");
selectWindow("Result of MouseMask.tif");
selectWindow("RedOverBlue.tif");
close();
selectWindow("RedOverBlue-1.tif");
close();
selectWindow("Result of MouseMask.tif");
run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
run("Enhance Contrast", "saturated=0.35");
saveAs("Tiff", directory+"//"+tag+"//RedOverBlueMinusMedian.tif");

setOption("ScaleConversions", true);
run("8-bit");
saveAs("Tiff", directory+"//"+tag+"//RedMinusBlueMinusMedian_8bit.tif");

selectWindow("Result of RedOverBlue.tif");
close();

///////////////////////////////////////////////////////////////////////////

setAutoThreshold("Default dark");
run("Threshold...");
//setThreshold(95, 255);
setThreshold(110, 255);
setOption("BlackBackground", true);
run("Convert to Mask");
run("Set Measurements...", "area redirect=None decimal=3");
run("Analyze Particles...", "size=35-3500 display clear include add");

