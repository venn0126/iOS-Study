/////////////////////////////////////////////////////////////////////////
//
//	File:		HCCommonAPI.h
//  
//	Author:		Hotcard Technology Pte. Ltd.
//				CDZ			
//
//	Purpose :	Define Hotcard Common API Used In All Application(BCR,DOC,OCR):
//
//
//	Date:		20100121
//
/////////////////////////////////////////////////////////////////////////

#ifndef _HC_COMMON_API_H
#define _HC_COMMON_API_H

#include "HCCommonData.h"

#define HC_allocBImage	HC_allocImage_ID
#define HC_freeBImage	HC_freeImage_ID
#undef EXPORT

#ifdef __JNI
#undef D_API_EXPORTS
#endif

#if defined D_API_EXPORTS
#define EXPORT __declspec(dllexport)
#else
#define EXPORT
#endif

#if defined(__cplusplus)
extern "C" {
#endif

/////////////////////////////////////////////////////////////////////////
//
//	Function	
//			Int HC_allocImage_ID(BEngine *pEngine, 
//							  BImage **ppImage, 
//							  Int width, 
//							  Int height, 
//							  Int setting)
//
//			Allocate a space for a 2D image buffer.
//
//	Return Value		
//			0 - Fail;
//			1 - Success. 
//
//	Parameters	
//			pEngine
//					A pointer to BEngine. 
//
//			ppImage	
//					A pointer to a variable of BImage pointer. It will 
//					receive the address of a BImage structure.
EXPORT  Int HC_SetSwitch(BEngine *pEngine, Int nSwitch, Int mode);
//
//			width	
//					The width of image buffer.
//
//			height	
//					The height of image buffer.
//
//			Setting	
//					The initial value for each pixel.
//
/////////////////////////////////////////////////////////////////////////

EXPORT  Int HC_GetSwitch(BEngine *pEngine, Int nSwitch);

#define HC_SetMemoSetting(pEngine, setting)		HC_SetSwitch(pEngine, SET_MEMO. setting)
#define HC_GetProcessStep(pEngine)				HC_GetSwitch(pEngine, SET_MULTI_STEPS)
EXPORT  Int HC_allocImage(BEngine *pEngine, 
						  BImage **ppImage, 
						  Int width, 
						  Int height,
						  Int setting);
EXPORT  Int HC_allocImage_ID(BEngine *pEngine, 
						  BImage **ppImage, 
						  Int width, 
						  Int height,
						  Int setting);
EXPORT  Int HC_allocImage_XS(BEngine *pEngine, 
						  BImage **ppImage, 
						  Int width, 
						  Int height,
						  Int setting);

    EXPORT  Int HC_SetSwitch_ID(BEngine *pEngine, int nSwitch, int mode);
/////////////////////////////////////////////////////////////////////////
//
//	Function	
//			Int HC_freeImage_ID(BEngine *pEngine, BImage **ppImage)
//
//			Release the memory of a BImage structure.
//
//	Return Value		
//			0 - Fail;
//			1 - Success. 
//
//	Parameters	
//			pEngine
//					A pointer to BEngine. 
//
//			ppImage	
//					A pointer to a variable of BImage pointer. It is set
//					to NULL after the image has been released.
//
/////////////////////////////////////////////////////////////////////////

EXPORT  Int HC_freeImage_ID(BEngine *pEngine, BImage **ppImage);
EXPORT  Int HC_freeImage_JZ(BEngine *pEngine, BImage **ppImage);
EXPORT  Int HC_freeImage_XS(BEngine *pEngine, BImage **ppImage);
/////////////////////////////////////////////////////////////////////////
//
//	Function	
//			BImage *HC_LoadImageMem_ID(BEngine *pEngine, Char *pBuffer, Int width, Int height)
//
//			Read BImage from a memory space. It contains the image lines  
//			top line to bottom line. Each pixel takes one byte.
//
//	Return Value		
//			A pointer to a BImage structure if success to read the file;
//			NULL - if fail. 
//
//	Parameters	
//			pEngine
//					A pointer to BEngine. 
//
//			pBuffer	
//					A pointer to the image data.
//
//			width, height
//					Size of the image buffer in pixels.
//
/////////////////////////////////////////////////////////////////////////

EXPORT  BImage *HC_LoadImageMem_ID(BEngine *pEngine, Char *pBuffer, Int width, Int height);
EXPORT  BImage *HC_LoadImageMem(BEngine *pEngine, char *pBuffer, Int width, Int height, Int depth);
EXPORT  BImage *HC_LoadGRYImageMem_ID(BEngine *pEngine, char *pBuffer, Int width, Int height);//灰度流
EXPORT  BImage *HC_LoadRGBImageMem_ID(BEngine *pEngine, char *pBuffer, Int width, Int height);//彩色流
EXPORT  BImage *HC_LoadRGB2GryImageMem_ID(BEngine *pEngine, char *pBuffer, Int width, Int height);


EXPORT  Int HC_SaveImage_ID(BEngine *pEngine, BImage *pImage, Char *filename);
EXPORT  BImage *HC_IMG_DupTMastImage_ID(BImage *pImage, TRect *rect);
EXPORT  BImage *HC_LoadImage_BMP(BEngine *pEngine, Char *filename);
    
EXPORT  Int HC_CheckingCopyID(BImage *pImage);

EXPORT  Int HC_SaveImage_BMP(BEngine *pEngine, BImage *pImage, Char *filename);
EXPORT  Int HC_SaveImage(BEngine *pEngine, BImage *pImage, Char *filename);
/////////////////////////////////////////////////////////////////////////
//
//	Function	
//			BImage *HC_LoadImageBMP_ID(BEngine *pEngine, Char *pBitmap)
//
//			Read BImage from memory with bmp structure.
//
//	Return Value		
//			A pointer to a BImage structure if success to read the file;
//			NULL - if fail. 
//
//	Parameters	
//			pEngine
//					A pointer to BEngine. 
//
//			pBitmap	
//					The memory with bmp structure.
//
/////////////////////////////////////////////////////////////////////////

EXPORT  BImage *HC_LoadImageBMP_ID(BEngine *pEngine, Char *pBitmap);

EXPORT  BImage *HC_LoadImageByteStream(BEngine *pEngine, char *pimgBitmap,int imgSize);

EXPORT  Int HC_PrintOcrInfo(BEngine *pEngine, Char *pText, Int size);


EXPORT int HC_IsBlurImage(SCAN_IMAGE *pImage);
	EXPORT Int YM_GetBankResult(BCR_RESULT *pResult, char *BankResult, int len);
/////////////////////////////////////////////////////////////////////////
//
//	Function	
//			int HC_PrintFieldInfo_ID(BEngine *pEngine, 
//									BField *pField, Char *pText, Int size)
//
//			Export the filed information into a text buffer (multi lines).
//			Each field takes one line.
//
//	Return Value		
//			0 - Fail;
//			1 - Success. 
//
//	Parameters	
//			pFields	
//					Pointer to the field information structure
//
typedef	Int (*f_progress_func)(Int progress, Int relative);
EXPORT  Int HC_SetProgressFunc(BEngine *pEngine, Int (*func)(Int progress, Int relative));

//			pText	
//					Text buffer to receive the field information
//
//			size
//					The size of text buffer pText
//
/////////////////////////////////////////////////////////////////////////

EXPORT  Int HC_PrintFieldInfo_ID(BEngine *pEngine, BField *pField, Char *pText, Int size);
EXPORT  Int HC_PrintFieldDetail_ID(BEngine *pEngine, BField *pField);
EXPORT  Int HC_PrintOcrInfo_ID(BEngine *pEngine, Char *pText, Int size);
EXPORT  Int HC_PrintFieldInfo_JSON_ID(BEngine *pEngine, BField *pField, Char *pText, Int size);
EXPORT  Int HC_PrintFieldInfo_CP(BEngine *pEngine, BField *pField, Char *pText, Int size);
EXPORT  Int HC_PrintFieldDetail_CP(BEngine *pEngine, BField *pField);
EXPORT  Int HC_PrintOcrInfo_CP(BEngine *pEngine, Char *pText, Int size);
EXPORT  Int HC_PrintFieldInfo(BEngine *pEngine, BField *pField, Char *pText, Int size);
EXPORT  Int HC_PrintFieldDetail(BEngine *pEngine, BField *pField);
EXPORT  Int HC_PrintOcrInfo(BEngine *pEngine, Char *pText, Int size);
    
EXPORT Int YMClearAll_ID();
EXPORT Int YMClearAll_JZ();
EXPORT Int YMClearAll_XS();
EXPORT Int YMClearAll_CP();
    
/////////////////////////////////////////////////////////////////////////
//
//	Function	
//			void HC_freeBField_ID(BEngine *pEngine, BField *pField, Int once)
//
//			Release field memory.
//
//	Return Value		
//			void
//
//	Parameters	
//			pField	
//					Pointer to a link of the field information 
//					structure.
//
//
//			once	= 1 to release one node only
//					= 0 to release all the nodes in field link
//
/////////////////////////////////////////////////////////////////////////

EXPORT  void HC_freeBField_ID(BEngine *pEngine, BField *pfield, Int once);
EXPORT  void HC_freeBField_JZ(BEngine *pEngine, BField *pfield, Int once);

EXPORT  void HC_freeBField_XS(BEngine *pEngine, BField *pfield, Int once);
EXPORT  void HC_freeBField_CP(BEngine *pEngine, BField *pfield, Int once);
EXPORT  Int HC_ImageChecking_ID(BEngine *pEngine, BImage *pImage, Int level);


/////////////////////////////////////////////////////////////////////////
EXPORT  Int HC_GetCardType_ID(BEngine *pEngine, BImage *pImage);


EXPORT int YuvToRgb420(unsigned char*m_pYuvBuf,unsigned char *m_pRgbBuf,int  m_Width,int m_Height);
EXPORT int YuvToRgb422 (unsigned char*m_pYuvBuf,unsigned char *m_pRgbBuf,int m_Width,int m_Height);
//EXPORT Int YM_SaveImage_ID(BImage *pImage, Char *pFileName);
EXPORT  BImage *HC_LoadImageMem_CP(BEngine *pEngine, char *pBuffer, Int width, Int height);
EXPORT  BImage *HC_LoadRGBImageMem_CP(BEngine *pEngine, char *pBuffer, Int width, Int height);

EXPORT Int YM_SaveImage(BImage *pImage, Char *pFileName);
EXPORT Int YM_SaveImage_CP(BImage *pImage, Char *pFileName);
EXPORT Int YM_SaveImage_BK(BImage *pImage, Char *pFileName);
EXPORT BImage * HC_YMVR_ImageNew();
EXPORT BImage * HC_YMVR_ImageNew_XS();

EXPORT int YuvToRgb420_CP(unsigned char*m_pYuvBuf,unsigned char *m_pRgbBuf,int  m_Width,int m_Height);
EXPORT int YuvToRgb422_CP (unsigned char*m_pYuvBuf,unsigned char *m_pRgbBuf,int m_Width,int m_Height);
EXPORT Int HC_SetOption(BEngine *pEngine, Char *pKey, Char *pContent);
EXPORT Int HC_SetCardNumRect(BEngine *pEngine, BRect *pRect);
EXPORT Int HC_ProspectAreaRect(BEngine *pEngine, BRect *pRect);

EXPORT int HC_ReleaseClockSet();
EXPORT int CheckAndRectTheVin(BField *pField,int *nRepariNum);
        EXPORT   int CheckVins(char *text);
#ifdef _MOB_ANDROID
EXPORT int HC_GetResult(BEngine *pEngine, BCR_RESULT *pResult);
EXPORT int FreeRgbBuf(unsigned char *m_pYuvBuf);
EXPORT unsigned char *YuvToRgb(unsigned char*m_pYuvBuf,int m_Width,int  m_Height,int type);
#endif //_MOB_ANDROID

EXPORT BImage *HC_GetTrnImage(BEngine *pEngine);
EXPORT Int HC_GetCardNumRect(BEngine *pEngine, Int *pRect);
EXPORT Int HC_GetCharInfo(BEngine *pEngine, Int *pCharInfo, Int size);
EXPORT Char HC_CheckCardEdgeLine(BEngine *pEngine, BImage *pImage, BRect rect, int threshold, int angle, int ratio_outside, int ratio_inside);
#if defined(__cplusplus)
}
#endif

#endif
