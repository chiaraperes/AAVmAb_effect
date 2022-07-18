getDimensions(a, b, channels, slices, frames)
run("8-bit");
setAutoThreshold("Default dark");
run("Threshold...");
setThreshold(255, 255);
setOption("BlackBackground", true);
run("Convert to Mask");
run("Invert");

doWand(398, 700); //Select area with wand
roiManager("Add"); //save the ROI on ROI manager

newImage("Untitled", "8-bit black", a, b, 1);
roiManager("Select", 0);
setForegroundColor(255, 255, 255);
run("Fill", "slice");
run("Distance Map");
roiManager("Delete");