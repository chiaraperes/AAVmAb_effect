//This macro works on a 3 channels image (RGB). We applied a threshold to the R channel of images to generate binary masks of the areas of interest. 
//We applied the masks to the corresponding B fluorescence channel and counted the number of cells in the masked area using the “Analyze particle” plugin.

filename=getTitle();
run("Duplicate...", "duplicate");
selectWindow(filename);
run("Split Channels");
selectWindow("C1-"+filename);
resetMinAndMax();
setOption("ScaleConversions", true);
run("8-bit");
run("Maximum...", "radius=25");
run("Minimum...", "radius=25");
setAutoThreshold("Default dark");
run("Convert to Mask");
run("Analyze Particles...", "size=250-Infinity show=Outlines display clear include add");
getDimensions(m, n, A, dummy, nFrames);
newImage("Untitled", "8-bit white", m, n, 1);
roiManager("Select", 0);
roiManager("Select", newArray(0));
run("Select All");
roiManager("Fill");
run("Invert");
run("Divide...", "value=255");
run("Set Scale...", "distance=2048 known=387.69 pixel=1 unit=micron"); //known from microscope images
selectWindow("C3-"+filename);
setAutoThreshold("Default dark");
run("Threshold...");
run("Convert to Mask");
imageCalculator("Multiply create", "Untitled","C3-"+filename);
selectWindow("Result of Untitled");
run("Smooth");
run("Make Binary");
run("Analyze Particles...", "size=5-100 circularity=0.0-1.0 show=Outlines display clear include add");

