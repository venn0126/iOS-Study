//
//  YMUtility.m
//  BCR
//
//  Created by bigfish on 9/9/09.
//  Copyright 2009 hyugahinat. All rights reserved.
//

#import "YMUtility.h"
#import "HCCommonAPI.h"
#import "HCCommonData.h"
//#import <CoreGraphics/CGColorSpace.h>



#define SIZE_BMPFILEHEADER	14
#define SIZE_BMPINFOHEADER	40
typedef struct ComBITMAPFILEHEADER 
{ // bmfh 
	unsigned short	   bfType; 
	unsigned long      bfSize; 
	unsigned short     bfReserved1; 
	unsigned short     bfReserved2;	
	unsigned long      bfOffBits; 
} 
COMBITMAPFILEHEADER; 


typedef struct ComBITMAPINFOHEADER
{ // bmih 
	unsigned int  biSize; 
	signed int   biWidth; 
	signed int   biHeight; 
	unsigned short   biPlanes; 
	unsigned short   biBitCount; 
	unsigned int  biCompression; 
	unsigned int  biSizeImage; 
	signed int   biXPelsPerMeter; 
	signed int   biYPelsPerMeter; 
	unsigned int  biClrUsed; 
	unsigned int  biClrImportant; 
} 
COMBITMAPINFOHEADER; 

typedef struct ComRGBQUAD 
{ // rgbq 
	unsigned char    rgbBlue; 
	unsigned char    rgbGreen; 
	unsigned char    rgbRed; 
	unsigned char    rgbReserved; 
} 
COMRGBQUAD;




@implementation YMUtility


+ (void)warningAlertWithMessage:(NSString *)mes {
	
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:NSLocalizedString(@"Warning", nil)
						  message: mes
						  delegate: nil 
						  cancelButtonTitle:NSLocalizedString(@"OK", nil)
						  otherButtonTitles:nil];
	[alert show];
}

+ (void)informationAlertWithMessage:(NSString *)mes {
	
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:NSLocalizedString(@"Information", nil)
						  message: mes
						  delegate: nil 
						  cancelButtonTitle:NSLocalizedString(@"OK", nil)
						  otherButtonTitles:nil];
	[alert show];
}



typedef unsigned char byte;
typedef struct RGBPixel {
	byte    red;
	byte    green;
	byte    blue;
	byte	alpha;
} RGBPixel;

+ (CGContextRef) CreateARGBBitmapContext:(CGImageRef) inImage {	
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
	
	// Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
	
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
	
    // Use the generic RGB color space.
    //colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
	colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
	
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL) 
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
	
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits 
    // per component. Regardless of what the source image format is 
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
									 pixelsWide,
									 pixelsHigh,
									 8,      // bits per component
									 bitmapBytesPerRow,
									 colorSpace,
									 kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
	
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
	
    return context;
}

+ (BOOL) GetYDataFromImage:(UIImage *)inImage
					pixels:(unsigned char **)pixels {

	// convert UIImage* to CGImageRef
//	NSData *pngData = UIImagePNGRepresentation(inImage);
//	CFDataRef imgData = (CFDataRef)pngData;
//	CGDataProviderRef imgDataProvider = CGDataProviderCreateWithCFData (imgData);
//	CGImageRef imageRef = CGImageCreateWithPNGDataProvider(imgDataProvider, NULL, true, kCGRenderingIntentDefault);
	CGImageRef imageRef = inImage.CGImage;
	
	// Create the bitmap context
    CGContextRef cgctx = [YMUtility CreateARGBBitmapContext:imageRef];
	
    if (cgctx == NULL) 
    { 
        // error creating context
        return NO;
    }
	
	// Get image width, height. We'll use the entire image.
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    CGRect rect = {{0,0},{width,height}}; 
		
    // Draw the image to the bitmap context. Once we draw, the memory 
    // allocated for the context for rendering will then contain the 
    // raw image data in the specified color space.
    CGContextDrawImage(cgctx, rect, imageRef); 
	
    // Now we can get a pointer to the image data associated with the bitmap
    // context.
    unsigned char *data = (unsigned char *)CGBitmapContextGetData (cgctx);
	
	// result flag
	BOOL bRet = YES;
	
    if (data != NULL)
    {
        // **** You have a pointer to the image data ****
        // **** Do stuff with the data here ****
//		unsigned char r = 0, g = 0, b = 0;
		int offset = 0;
		for(int i = 0; i < height; i++) {
			for(int j = 0; j < width; j++) {
				//if(j < 100)
				{
//				r = data[offset + j * 4 + 1];
//				g = data[offset + j * 4 + 2];
//				b = data[offset + j * 4 + 3];
//				pixels[i][j] = (r * 30 + g * 59 + b * 11) / 100;
                pixels[i][j*3] = data[offset + j * 4 + 1];
                pixels[i][j*3+1] = data[offset + j * 4 + 2];
                pixels[i][j*3+2] = data[offset + j * 4 + 3];
				}
			}
			offset += width * 4;
        }
		bRet = YES;
    }
	else
		bRet = NO;
	
    // When finished, release the context
    CGContextRelease(cgctx); 
    // Free image data memory for the context
    if (data)
    {
        free(data);
    }

	return bRet;
}

//+ (BOOL) GetYDataFromImageVideo:(UIImage *)inImage
//                    pixels:(unsigned char **)pixels
//{
//    CGImageRef imageRef = inImage.CGImage;
//    
//    // Create the bitmap context
//    CGContextRef cgctx = [YMUtility CreateARGBBitmapContext:imageRef];
//    
//    if (cgctx == NULL)
//    {
//        // error creating context
//        return NO;
//    }
//    
//    // Get image width, height. We'll use the entire image.
//    size_t width = CGImageGetWidth(imageRef);
//    size_t height = CGImageGetHeight(imageRef);
//    CGRect rect = {{0,0},{width,height}};
//    
//    // Draw the image to the bitmap context. Once we draw, the memory
//    // allocated for the context for rendering will then contain the
//    // raw image data in the specified color space.
//    CGContextDrawImage(cgctx, rect, imageRef);
//    
//    // Now we can get a pointer to the image data associated with the bitmap
//    // context.
//    unsigned char *data = (unsigned char *)CGBitmapContextGetData (cgctx);
//    
//    // result flag
//    BOOL bRet = YES;
//    
//    if (data != NULL)
//    {
//        // **** You have a pointer to the image data ****
//        // **** Do stuff with the data here ****
//        //        unsigned char r = 0, g = 0, b = 0;
//        int offset = 0;
//        for(int i = 0; i < height; i++) {
//            for(int j = 0; j < width; j++) {
//                //if(j < 100)
//                {
//                    pixels[i][j*3+2] = data[offset + j * 4 + 1];
//                    pixels[i][j*3+1] = data[offset + j * 4 + 2];
//                    pixels[i][j*3] = data[offset + j * 4 + 3];
//                }
//            }
//            offset += width * 4;
//        }
//        bRet = YES;
//    }
//    else
//        bRet = NO;
//    
//    // When finished, release the context
//    CGContextRelease(cgctx); 
//    // Free image data memory for the context
//    if (data)
//    {
//        free(data);
//    }
//    
//    return bRet;
//}

+ (int) SaveImageBMP:(NSString *)filename
	data:(unsigned char **)data
	width:(int) width
	height:(int) height
{
	// get bmp file's full path
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *fullpath = [NSString stringWithFormat:@"%@/%@", [paths objectAtIndex:0], filename];
	char bmpPath[256] = { 0 };
	strcpy(bmpPath, [fullpath cStringUsingEncoding:NSUTF8StringEncoding]);
	//alloc
	unsigned char * pYDataBuf = (unsigned char *)malloc(width*height);
	memset(pYDataBuf, 0, width*height);
	for(int i = 0; i < height; i++)
	{
		memcpy(pYDataBuf+width*i, data[i], width);
		//for(int j = 0; j < width; j++)
			//pYDataBuf[i*width + j] = data[i][j];
	}
	
	int ret = 1;
	
	COMBITMAPFILEHEADER	ph;
	COMBITMAPINFOHEADER	pi;
	FILE *file = NULL;
	unsigned int dwCOMBITMAPINFOSize = 0, dwFileHeaderSize = 0;
	int image_size = 0, writeBytes = 0, i = 0;
	unsigned char colorPalette[1024] = { 0 }, diffBuf[5] = { 0 }, hbuf[100] = { 0 };
	unsigned char *pColorPalette = NULL, *p = NULL;
	int scanWidth = (width + 3) >> 2 << 2; // bytes per line
	int diff = scanWidth - width; // should be in the range [0, 4]
	int offset = 0;
	
	if (!pYDataBuf) return 0;
	
	file = fopen(bmpPath, "wb");
	if (!file) 
	{
		//		printf("fail to open the file: %s\n", bmpPath);
		//return 0;
		ret = 0;
		goto END;
	}
	
	dwCOMBITMAPINFOSize = SIZE_BMPINFOHEADER + 256 * sizeof(COMRGBQUAD);
	image_size = scanWidth * height;
	dwFileHeaderSize = SIZE_BMPFILEHEADER + dwCOMBITMAPINFOSize;
	
	//
	// Fill in the fields of the file header & write to file
	//
	pi.biBitCount   = 8; // this is a 8bits bmp image
	ph.bfType       = 0x4d42;
	ph.bfSize       = dwFileHeaderSize + image_size;
	ph.bfReserved1  = 0;
	ph.bfReserved2  = 0;
	ph.bfOffBits    = dwFileHeaderSize;
	
	p = (unsigned char *)hbuf;
	memcpy(p, &(ph.bfType), 2); p += 2;
	memcpy(p, &(ph.bfSize), 4); p += 4;
	p += 4;
	memcpy(p, &(ph.bfOffBits), 4); p += 4;
	
	writeBytes = fwrite((void *)hbuf, 1, SIZE_BMPFILEHEADER, file);
	if (writeBytes != SIZE_BMPFILEHEADER)
	{
		//		printf("fail to write the file header\n");
		fclose(file);
		ret = 0;
		goto END;
		//return 0;
	}
	
	
	//
	// fill in the fields of the info header & write to file
	//
	pi.biSize = SIZE_BMPINFOHEADER;
	pi.biWidth = width;
	pi.biHeight = height;
	pi.biPlanes = 1;
	pi.biCompression = 0;
	pi.biClrImportant = 0;
	pi.biSizeImage = 0;
	pi.biXPelsPerMeter = 0;
	pi.biYPelsPerMeter = 0;
	pi.biClrUsed = 0;
	
	p = (unsigned char *)hbuf;
	memcpy(p, &(pi.biSize), 4);          p += 4;
	memcpy(p, &(pi.biWidth), 4);         p += 4;
	memcpy(p, &(pi.biHeight), 4);        p += 4;
	memcpy(p, &(pi.biPlanes), 2);        p += 2;
	memcpy(p, &(pi.biBitCount), 2);      p += 2;
	memcpy(p, &(pi.biCompression), 4);   p += 4;
	memcpy(p, &(pi.biSizeImage), 4);     p += 4;
	memcpy(p, &(pi.biXPelsPerMeter), 4); p += 4;
	memcpy(p, &(pi.biYPelsPerMeter), 4); p += 4;
	memcpy(p, &(pi.biClrUsed), 4);       p += 4;
	memcpy(p, &(pi.biClrImportant), 4);  p += 4;
	
	writeBytes = fwrite((void *)hbuf, 1, SIZE_BMPINFOHEADER, file);
	if (writeBytes != SIZE_BMPINFOHEADER)
	{
		//		printf("fail to write info header\n");
		fclose(file);
		ret = 0;
		goto END;
		//return 0;
	}
	
	
	//
	// creat the color palette & write it to the file
	//
	pColorPalette = colorPalette;
	for (i = 0; i < 256; i++)
	{
		*pColorPalette++ = (unsigned char)i;
		*pColorPalette++ = (unsigned char)i;
		*pColorPalette++ = (unsigned char)i;
		*pColorPalette++ = (unsigned char)0;
	}
	writeBytes = fwrite(colorPalette, 1, 1024, file);
	if (writeBytes != 1024)
	{
		//		printf("fail to write the color palette\n");
		fclose(file);
		ret = 0;
		goto END;
		//return 0;
	}
	
	
	//
	// write the Y data to the file
	//
	offset = width * (height - 1); // copy Y data from the bottom cause the format of bmp image data storage  
	for (i = 0; i < height; i++)
	{
		writeBytes = fwrite(pYDataBuf + offset, 1, width, file);
		if (writeBytes != width)
		{
			//			printf("fail to write the Y Data to the file\n");
			fclose(file);
			ret = 0;
			goto END;
			//return 0;
		}
		if (diff)
		{
			writeBytes = fwrite(diffBuf, 1, diff, file);
			if (writeBytes != diff)
			{
				//				printf("fail to write the diff bytes to the file\n");
				fclose(file);
				ret = 0;
				goto END;
				//return 0;
			}
		}
		offset -= width; // NOTE, this maybe diff from other image format
	}
	
	//	printf("successfully\n");
	fclose(file);
	ret = 1;
END:
	if(pYDataBuf)
		free(pYDataBuf);
	return ret;
}

+ (CGFloat) distanceBetweenPoints: (CGPoint) first toPoint: (CGPoint) second
{
	CGFloat deltaX = second.x - first.x;
	CGFloat deltaY = second.y - first.y;
	return sqrt(deltaX*deltaX + deltaY*deltaY );
}







static void addRoundedRectToPath(CGContextRef context, 
                                 CGRect rect, 
                                 float ovalWidth,
                                 float ovalHeight) {
    
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
#pragma mark change the corner size below...
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


+ (UIImage *) createRoundedRectImage:(UIImage*)image size:(CGSize)size {
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, 10, 10);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), image.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}






//	==============================================================
//	resizedImage
//	==============================================================
// Return a scaled down copy of the image.  

UIImage* resizedImage(UIImage *inImage, CGRect thumbRect)
{
	CGImageRef			imageRef = [inImage CGImage];
	CGImageAlphaInfo	alphaInfo = CGImageGetAlphaInfo(imageRef);
	
	// There's a wierdness with kCGImageAlphaNone and CGBitmapContextCreate
	// see Supported Pixel Formats in the Quartz 2D Programming Guide
	// Creating a Bitmap Graphics Context section
	// only RGB 8 bit images with alpha of kCGImageAlphaNoneSkipFirst, kCGImageAlphaNoneSkipLast, kCGImageAlphaPremultipliedFirst,
	// and kCGImageAlphaPremultipliedLast, with a few other oddball image kinds are supported
	// The images on input here are likely to be png or jpeg files
	if (alphaInfo == kCGImageAlphaNone)
		alphaInfo = kCGImageAlphaNoneSkipLast;
	
	// Build a bitmap context that's the size of the thumbRect
	CGContextRef bitmap = CGBitmapContextCreate(
												NULL,
												thumbRect.size.width,		// width
												thumbRect.size.height,		// height
												CGImageGetBitsPerComponent(imageRef),	// really needs to always be 8
												4 * thumbRect.size.width,	// rowbytes
												CGImageGetColorSpace(imageRef),
												alphaInfo
												);
	
	// Draw into the context, this scales the image
	CGContextDrawImage(bitmap, thumbRect, imageRef);
	
	// Get an image from the context and a UIImage
	CGImageRef	ref = CGBitmapContextCreateImage(bitmap);
	UIImage*	result = [UIImage imageWithCGImage:ref];
	
	CGContextRelease(bitmap);	// ok if NULL
	CGImageRelease(ref);
	
	return result;
}

@end
