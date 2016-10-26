---
layout: post
title: kicad 3d models to solidworks
---

If you use kicad's 3d viewer you may already know that it cannot export models
into a format useable by mechanical engineers.  There is a [tool out there](https://sourceforge.net/projects/kicadstepup/) 
that apparently fixes this via a macro for FreeCAD.  The tool works well, but
the documentation is horrible.  My friend [Kyle Manna](https://about.me/manna)
took the time and effort to figure out how the script works and yesterday was
teaching me how to use it.

It turns out it's not that hard.  Here is the recipe:


## Setup

1. Download [kicad stepup](https://sourceforge.net/projects/kicadstepup/)
2. With FreeCad, create a blank project, and load the macro ```kicad-StepUp-tools.FCMacro```

![kicad-image]({{ site.baseurl }}/images/kicad-stepup.png)

## For each footprint

3. Click on load 'Kicad footprint module', and load the footprint for which you
   want to generate a dual 3D model (wrl and stepup).

4. Import the associated step or iges model for that footprint (File -> Import...)
   Note:  if the model is imported as multiple parts, select them all and 'Fuse' them.   
   Note 2: if FreeCad can't fuse the parts together, you have a problem.  Get help.

5. Using the rotation and offset controls in the Macro window, align the model with 
   the footprint.

6. Click on 'Export to Kicad' to generate your new .wrl and .step files.

## On Kicad

7. Open the footprint, and make sure it uses the newly generated .wrl file.
   Zero all rotations, offsets.  One all scaling.  Confirm that footprint
   and 3D model are aligned in the 3d view.

8. Export IDFv3 file format (File -> Export -> IDFv3...)

## On Freecad

9. Open 'Load kicad board with IDF *.emn'.  If all goes well, you should see how
   the 3d view of your board starts to appear on the screen.  All components
   for which you have generated a 3d model with step up should be populated.  A
   step model is now generated that you can hand out to your mechanical engineer.


![jst-image]({{ site.baseurl }}/images/jst-stepup.png)
