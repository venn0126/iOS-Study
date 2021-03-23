//
//  UIImageView+NWBackground.m
//  YPYDemo
//
//  Created by Augus on 2021/3/16.
//

#import "UIImageView+NWBackground.h"

@implementation UIImageView (NWBackground)

/**
 
 - (void)drawTexture : (NSArray *)verticesPassed {

 CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();

 //This function gets the bounds or smallest rectangle required to generate a shape which
 //will be used as pattern
 CGRect shp = [self boundFromFrame:verticesPassed];


 //Generate the shape as image so that we can make pattern out of it.
 CGContextRef conPattern = CGBitmapContextCreate(NULL,
                                          shp.size.width,
                                          shp.size.height,
                                          8,
                                          0,
                                          rgbColorSpace,
                                          kCGImageAlphaPremultipliedFirst);

 CGColorSpaceRelease(rgbColorSpace);

 CGContextSetLineWidth(conPattern, 10);
 CGContextSetStrokeColorWithColor(conPattern, [UIColor blueColor].CGColor);

 Line * start = [verticesPassed objectAtIndex:0];
 CGContextMoveToPoint(conPattern, start.x-shp.origin.x , start.y-shp.origin.y);

 for (Line * vertice in verticesPassed) {
     CGContextAddLineToPoint(conPattern, vertice.x-shp.origin.x , vertice.y-shp.origin.y );
 }
 CGContextStrokePath(conPattern);

 //Make the main image and color it with pattern.
 CGImageRef cgImage = CGBitmapContextCreateImage(conPattern);

 UIImage *imgPattern = [[UIImage alloc]initWithCGImage:cgImage];
 //UIImageWriteToSavedPhotosAlbum(imgPattern, nil, nil, nil);


 UIColor *patternColor = [UIColor colorWithPatternImage:imgPattern];

 CGContextRef con = CGBitmapContextCreate(NULL,
                                          1000,
                                          1000,
                                          8,
                                          0,
                                          rgbColorSpace,
                                          kCGImageAlphaPremultipliedFirst);

 CGColorSpaceRelease(rgbColorSpace);

 CGContextSetLineWidth(con, 10);



 CGContextMoveToPoint(con, 0 , 0);
 CGContextAddLineToPoint(con, 1000 , 0 );
 CGContextAddLineToPoint(con, 1000 , 1000 );
 CGContextAddLineToPoint(con, 0 , 10000 );


 CGContextSetFillColorWithColor(con, patternColor.CGColor);

 CGContextFillPath(con);


 CGImageRef cgImageFinal = CGBitmapContextCreateImage(con);

 UIImage *newImage = [[UIImage alloc]initWithCGImage:cgImageFinal];

 UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);


 }
 */


//-(CGRect)boundFromFrame:(NSArray*)verticesPassed {
//
//float top,left,right,bottom;
//bool bFirst = YES;
//
//for (Line * vertice in verticesPassed) {
//    if(bFirst)
//    {
//        left = right = vertice.x;
//        top = bottom = vertice.y;
//        bFirst = NO;
//    }
//    else{
//        if (vertice.x<left) left = vertice.x;
//        if (vertice.x>right) right = vertice.x;
//        if (vertice.x<top) top = vertice.y;
//        if (vertice.x>bottom) bottom = vertice.y;
//    }
//
//}

//return CGRectMake(left, top, right - left, bottom-top);
//
//}


- (void)nw_setImage {
    
    size_t bytesPerRow = 4352;
    // Get the pixel buffer width and height
    size_t width = 1088; // w h bytesrow 1280  720 1280
    size_t height = 1905; //
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    NSData *data = [self imageForDataWithBundle:@"123"];
    void *dataBytes = (__bridge void *)(data);
    
    //
    CGContextRef newContext = CGBitmapContextCreate(dataBytes, width, height, 8, bytesPerRow, rgbColorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef newImage = CGBitmapContextCreateImage(newContext);
    
    // release
    CGContextRelease(newContext);
    CGColorSpaceRelease(rgbColorSpace);
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (newImage != NULL) {
            self.image = (__bridge UIImage * _Nullable)(newImage);
            
        } else {
            self.image = nil;
        }
        
        CGImageRelease(newImage);

    });
    
    
    
}

- (NSData *)imageForDataWithBundle:(NSString *)name {
    
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"ImgBundle.bundle"];
    NSBundle *nwBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *imagePath = [nwBundle pathForResource:@"china_big_img" ofType:@"jpg"];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    NSLog(@"data: %lu",data.length);
    return data;
}

@end
