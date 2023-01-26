//This macro works on a single channal image.
// It applies at first a a threshold to the immunofluorescence images. It then applies a sequence of image filters (“Smooth”, “Erode” and “Dilate”) to enhance the E-cadherin signal.
 //To extract cell border contours, the “Analyze particle” plugin is used.
 
setAutoThreshold("Default dark");
run("Threshold...");
run("Duplicate...", " ");
run("Smooth");
setThreshold(15000, 65535);
setOption("BlackBackground", true);
run("Convert to Mask");

run("Make Binary");
run("Invert");
run("Erode");
run("Dilate");
run("Erode");
run("Dilate");
run("Analyze Particles...", "size=10-200 circularity=0.50-1.00 show=Outlines display exclude add");