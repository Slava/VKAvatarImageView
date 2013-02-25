//
//  VKTemplatedPreviewView.m
//  VKAvatarImageView
//
//  Created by Vyacheslav Kim on 2/24/13.
//  Copyright (c) 2013 Vyacheslav Kim. All rights reserved.
//

#import "VKTemplatedPreviewView.h"
#import "NSImage+CCDAdditions.h"

@implementation VKTemplatedPreviewView


#define actual(x,X,ax) ((ax)*(x)/(X))
#define RGBA(R,G,B,A) [NSColor colorWithCalibratedRed:(R)/255. green:(G)/255. blue:(B)/255. alpha:(A)]

- (void)drawRect:(NSRect)dirtyRect {
    NSRect fullRect = [self bounds];
    float width = fullRect.size.width;
    float height = fullRect.size.height;
    width = height = MIN(width, height);
    
    NSImage *canvas = [[NSImage alloc] initWithSize:NSMakeSize(width, height)];
    [canvas lockFocus];
    {
        NSRect canvasRect = NSZeroRect;
        canvasRect.size = canvas.size;
        
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 8;
        shadow.shadowColor = RGBA(40, 40, 40, 0.6);
        shadow.shadowOffset = NSSizeFromString(@"0 0 0 0");
        
        
        [NSGraphicsContext saveGraphicsState];{
            // set light shadow around icon
            [shadow set];
            
            // Draw base
            [[NSImage scaleImage:[[NSBundle mainBundle] imageForResource:@"document_icon_base"] toSize:[canvas size] proportionally:YES] drawCenteredinRect:canvasRect operation:NSCompositeSourceOver fraction:1];
            
        }[NSGraphicsContext restoreGraphicsState];
        
        
        // Draw scaled image
        [[NSImage scaleImage:[self image] toSize:NSMakeSize(actual(284, 512, width), actual(350, 512, height)) proportionally:YES] drawAtPoint:NSMakePoint(actual(123, 512, width), actual(122, 512, height)) fromRect:NSZeroRect operation:NSCompositeCopy fraction:1];
        
        // Draw top
        [[NSImage scaleImage:[[NSBundle mainBundle] imageForResource:@"document_icon_top"] toSize:[canvas size] proportionally:YES] drawCenteredinRect:canvasRect operation:NSCompositeSourceAtop fraction:1];
    }
    [canvas unlockFocus];
    
    [canvas drawCenteredinRect:fullRect operation:NSCompositeSourceOver fraction:1];
}

@end
