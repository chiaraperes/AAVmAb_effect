//This macro applies a threshold to a single channel image,
//to evaluate the number of suprathreshold pixels 
filename=getTitle();
selectWindow(filename+".tif");
run("Duplicate...", " ");
run("Gaussian Blur...", "sigma=20");
imageCalculator("Subtract create", filename+".tif",filename+"-1.tif");
selectWindow("Result of "+filename+".tif");
directory=getDirectory("Choose where to save the image");
saveAs("Tiff", directory+"/Subtracted"+filename+".tif");
run("Threshold...");
setThreshold(8000, 65535);
setOption("BlackBackground", true);
run("Convert to Mask");
run("Divide...", "value=255.000");
saveAs("Tiff", directory+filename+"Mask.tif");

imageCalculator("Multiply create", filename+".tif",filename+"Mask.tif");
saveAs("Tiff", directory+"/Masked"+filename+".tif");

open(directory+"/Subtracted"+filename+".tif");
imageCalculator("Multiply create", "Subtracted"+filename+".tif",filename+"Mask.tif");
saveAs("Tiff", directory+"/SubtractedMasked"+filename+".tif");
run("Close All");