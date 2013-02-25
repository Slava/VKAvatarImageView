//
//  NSImage+CCDAdditions.h
//  VKAvatarImageView
//
//  Created by Vyacheslav Kim on 2/24/13.
//  Copyright (c) 2013 Vyacheslav Kim. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (CCDAdditions)
+ (NSImage *)scaleImage:(NSImage *)image toSize:(NSSize)newSize proportionally:(BOOL)prop;
// draws the passed image into the passed rect, centered and scaled appropriately.
// note that this method doesn't know anything about the current focus, so the focus must be locked outside this method
- (void)drawCenteredinRect:(NSRect)inRect operation:(NSCompositingOperation)op fraction:(float)delta;
+ (CGImageRef) createMaskWithImage:(CGImageRef) image;
    
@end
