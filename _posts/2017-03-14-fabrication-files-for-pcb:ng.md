---
layout: post
title: fabrication files for PCB:ng
---

[PCB.ng](http://pcb.ng) is a great new prototype manufacturing house that are
working hard to offer a full "no touch" ordering system.

While they provide a lot of [support for Kicad
users](https://support.pcb.ng/support/solutions/articles/9000099316-for-kicad-users),
I could not find good info on how to generate BOMs and component
position files that were compatible with their platform.

These are the steps that ended up working for me.

 1. In the schematic, add new fields for each part in your design:

    * *MPN:* The Manufacturer Part Number 
    * *DISTPN:* The Distributor Part Number
    * *Config:* If the part is not to be populated, set this value to `DNF`
    * *MFR, DIST:* (Optional) The manufacturer and the distributor 
    * *MPN2, MPN3, DISTPN2, DISTPN3:*  For alternate part numbers or distributors

 2. Generate the BOM.  We use
 [KiBoM](https://github.com/SchrodingersGat/KiBoM), which can be tuned to
 generate your BOM in many different ways.

 3. Edit bom.ini (which is created in step 2) and add `References` at the end
 of the GROUPS_FIELDS.  This ensures that the components are not grouped, or
 otherwise PCB.ng will fail to map components to positions in the position
 file.

 4. Regenerate BOM. Check that parts are not grouped.

 5. Remove footer summary from the csv file and upload to PCB:ng
 
 6. Map the `Identifier` (->`References`), `Manufacturer Part Number` (->`MPN`) and `Digikey-SKU` (->`DISTPN`) fields.

 7. Generate Position File from Kicad/Pcbnew (File -> Fabrication Outputs)
    -> Footprint Position) with one file per board.  Make sure you
    remove the `INSERT` attribute on `DNF` components or else they will appear
    in your Position File.

    Note: Make sure you have not moved your origin point for gerbers and
    positioning away from the default (0,0) or else your parts will be
    [floating in space](https://support.pcb.ng/support/solutions/articles/9000101344-parts-floating-in-space-can-t-find-parts-in-placement-window).
    In Kicad, this can be moved via the "Bullseye-on-axis" tool on the right
    tool menu (tooltip: "Place the origin point...").

 8. Upload that file as a `Pick and Place` file and confirm that the placement
    information is all correct in the `Placement` tab.  All parts should appear
    as `Placed but unconfirmed`.  If some show as not placed, check that the
    `INSERT` attribute was set on that footprint.

And that's all.

Thanks to the [inimitable Kyle Manna](https://blog.kylemanna.com/) for
figuring out most of this before I did.
