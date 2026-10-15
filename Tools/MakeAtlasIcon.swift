// SPDX-License-Identifier: MIT
// Copyright (c) 2026 Gediminas (@aktoriukas)
import AppKit
let destination = CommandLine.arguments[1]

// Explicit pixels keep output identical on Retina displays and headless CI.
func canvas(_ width: Int, _ height: Int) -> NSBitmapImageRep {
    let bitmap = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: width, pixelsHigh: height,
                                 bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true,
                                 isPlanar: false, colorSpaceName: .deviceRGB,
                                 bytesPerRow: 0, bitsPerPixel: 0)!
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmap)
    return bitmap
}
for size in [16,32,128,256,512] {
    for scale in [1,2] {
        let pixels=size*scale
        let bitmap = canvas(pixels, pixels)
        let d=CGFloat(pixels)
        NSColor(calibratedRed:0.065,green:0.085,blue:0.09,alpha:1).setFill()
        NSBezierPath(roundedRect:NSRect(x:0,y:0,width:d,height:d),xRadius:d*0.22,yRadius:d*0.22).fill()
        let pts=[CGPoint(x:d*0.5,y:d*0.52),CGPoint(x:d*0.27,y:d*0.72),CGPoint(x:d*0.76,y:d*0.68),CGPoint(x:d*0.32,y:d*0.25),CGPoint(x:d*0.73,y:d*0.31)]
        NSColor(calibratedRed:0.4,green:0.76,blue:0.63,alpha:0.5).setStroke()
        for i in 1..<pts.count{let path=NSBezierPath();path.move(to:pts[0]);path.line(to:pts[i]);path.lineWidth=d*0.018;path.stroke()}
        for (i,p) in pts.enumerated(){(i==0 ? NSColor.white:NSColor(calibratedRed:0.4,green:0.76,blue:0.63,alpha:1)).setFill();let r=d*(i==0 ? 0.075:0.045);NSBezierPath(ovalIn:NSRect(x:p.x-r,y:p.y-r,width:r*2,height:r*2)).fill()}
        NSGraphicsContext.restoreGraphicsState()
        try bitmap.representation(using:.png,properties:[:])!.write(to:URL(fileURLWithPath:destination+"/icon_\(size)x\(size)\(scale==2 ? "@2x":"").png"))
    }
}

let output = URL(fileURLWithPath: destination).deletingLastPathComponent()
for (name, width, height) in [("MenuBarIcon", 26, 20), ("MenuBarIcon@2x", 52, 40), ("BrandMark", 128, 128)] {
    let bitmap = canvas(width, height)
    let symbol = NSImage(systemSymbolName: "point.3.connected.trianglepath.dotted", accessibilityDescription: "Atlas Bar")!
    let inset = max(2, height / 10)
    symbol.draw(in: NSRect(x: inset, y: inset, width: width - inset * 2, height: height - inset * 2))
    NSGraphicsContext.restoreGraphicsState()
    try bitmap.representation(using: .png, properties: [:])!.write(to: output.appendingPathComponent(name + ".png"))
}
