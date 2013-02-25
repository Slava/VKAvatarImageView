//
//  VKAvatarImageView.m
//  VKAvatarImageView
//
//  Created by Vyacheslav Kim on 2/23/13.
//  Copyright (c) 2013 Vyacheslav Kim. All rights reserved.
//

#import "VKAvatarImageView.h"
#import "NSImage+CCDAdditions.h"

@implementation VKAvatarImageView


- (void)drawRect:(NSRect)dirtyRect {
    NSRect fullRect = [self bounds];
    float diameter = MIN(fullRect.size.width, fullRect.size.height) - 5;
    
    NSImage *img = [[NSImage alloc] initWithSize:fullRect.size];
    
    // drawing mask in img
    [img lockFocus];
    {
        
        [[NSColor whiteColor] setFill];
        NSRectFill(fullRect);
        
        //// Color Declarations
        NSColor* fillColor = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1];
        NSColor* strokeColor = [NSColor colorWithCalibratedRed: 0 green: 0 blue: 0 alpha: 1];
        
        //// Abstracted Attributes
        NSRect ovalRect = NSMakeRect((fullRect.size.width - diameter) / 2, (fullRect.size.height - diameter) / 2, diameter, diameter);
        
        
        //// Oval Drawing
        NSBezierPath* ovalPath = [NSBezierPath bezierPathWithOvalInRect: ovalRect];
        [fillColor setFill];
        [ovalPath fill];
        [strokeColor setStroke];
        [ovalPath setLineWidth: 1];
        [ovalPath stroke];
        
    }
    [img unlockFocus];
    
    // create mask
    CGImageRef maskImage = [img CGImageForProposedRect:&fullRect context:nil hints:nil];
    CGImageRef mask = [NSImage createMaskWithImage:maskImage];
    
    // draw targeted image in img
    [img lockFocus];
    {
        [[NSImage scaleImage:[self image] toSize:fullRect.size proportionally:YES] drawCenteredinRect:fullRect operation:NSCompositeCopy fraction:1];
    }
    [img unlockFocus];
    
    
    CGImageRef masked = CGImageCreateWithMask([img CGImageForProposedRect:&fullRect context:nil hints:nil], mask);
    CGContextDrawImage ([[NSGraphicsContext currentContext]
                         graphicsPort], fullRect, masked );
}

@end
