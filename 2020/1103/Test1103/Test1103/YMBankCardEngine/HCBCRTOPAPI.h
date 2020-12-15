
/////////////////////////////////////////////////////////////////////////
//
//	File:		HCBCRTOPAPI.h
//  
//	Author:		Hotcard Technology Pte. Ltd.
//				CDZ			
//
//	Purpose :	Define Hotcard BCR API Functions In The Applicaton Moduler
//
//	Date:		20100121
//
/////////////////////////////////////////////////////////////////////////

#ifndef _T_HC_BCR_TOP_API_H
#define _T_HC_BCR_TOP_API_H

#include "HCCommonData.h"

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
//			Int HC_StartBCR_ID(BEngine **ppEngine, 
//							Char *pDataPath, 
//							Char *pConfigFile, 
//							Int nLanguage)
//
//			To initialize the BCR engine.
//
//	Return Value		
//			An interger to indicate the status of BCR initialization. 
//			0 - Fail;
//			1 - Success.
//
//	Parameters
//			ppEngine
//					A pointer to the BEngine pointer. Call this function
//					like:
//						BEngine	*pEngine = NULL;
//						HC_StartBCR_ID( &pEngine, ...);
//
//			pDataPath	
//					A pointer to the user-supplied buffer that contains 
//					the path where OCR data files stay.
//		
//			pConfigFile	
//					The BCR configuration file name. If pDataPath is NULL, 
//					the path of OCR data files is descriped in this configure
//					file.
//		
//			nLanguage
//					The OCR language:
//
/////////////////////////////////////////////////////////////////////////
  EXPORT int HC_SetSwitch_CP(BEngine *pEngine, int nSwitch, int mode);
EXPORT int HC_EnableMultiLine_CP(BEngine *pEngine,int mode);
EXPORT Int HC_StartBCR_JZ(BEngine **ppEngine, 
					   Char *pDataPath, 
					   Char *pConfigFile,
					   Int nLanguage);
EXPORT Int HC_StartBCR_ID(BEngine **ppEngine, 
					   Char *pDataPath, 
					   Char *pConfigFile,
					   Int nLanguage,char *ChannelNumber,char *iosfilename);
EXPORT Int HC_StartBCR_XS(BEngine **ppEngine, 
					   Char *pDataPath, 
					   Char *pConfigFile,
					   Int nLanguage);

/////////////////////////////////////////////////////////////////////////
//
//	Function	
//			Int HC_CloseBCR_ID(BEngine **pEngine)
//
//			To free the resources used by BCR engine.
//
//	Return Value		
//			Always return 1. 
//
//	Parameters
//			ppEngine
//					A pointer to the BEngine pointer. Call this function
//					like:
//						BEngine	*pEngine = NULL;
//						...
//						HC_CloseBCR_ID( &pEngine);
//
/////////////////////////////////////////////////////////////////////////
EXPORT Int HC_CloseBCR_JZ(BEngine **pEngine);
EXPORT Int HC_CloseBCR_ID(BEngine **pEngine);
EXPORT Int HC_CloseBCR_XS(BEngine **pEngine);
/////////////////////////////////////////////////////////////////////////
//
//	Function	
//			int HC_DoImageBCR_ID(BEngine *pEngine,
//							  BImage *pImage, 
//							  BField **ppField) 
//
//			To extract field information from an image.
//
//	Return Value		
//			An interger to indicate the status of BCR. 
//			0 - Fail;
//			1 - Success.
//
//	Parameters	
//			pEngine
//					A pointer to the engine.
//
//			pImage	
//					A pointer to the user-supplied BImage buffer that 
//					contains the gray level name card image.
//		
//			ppField	
//					Return a link of field information structures
//		
/////////////////////////////////////////////////////////////////////////
EXPORT  Int HC_DoImageBCR_JZ(BEngine *pEngine,
						  BImage *pImage, 
				          BField **ppField);
EXPORT  Int HC_DoImageBCR_ID(BEngine *pEngine,
						  BImage *pImage, 
				          BField **ppField,char *iosfilename);
EXPORT  Int HC_DoImageBCR_XS(BEngine *pEngine,
						  BImage *pImage, 
				          BField **ppField);


/////////////////////////////////////////////////////////////////////////
//
//	Function	
//			Int HC_GetFieldText_ID(BEngine *pEngine,
//							   BImage *pImage, 
//			                   BField *pField,
//			                   Char *text, 
//			                   Int size) 
//
//			In manual BCR mode, to extract field information from the specified  
//			field (defined by field structure).
//
//	Return Value		
//			An interger to indicate the status of BCR. 
//			0 - Fail;
//			1 - Success.
//
//	Parameters	
//			pEngine
//					A pointer to the engine.
//
//			pImage	
//					A pointer to the user-supplied BImage buffer that 
//					contains the gray level name card image.
//		
//			pField	
//					A pointer to a field information structures.
//		
//			text	
//					The buffer to contain text result.
//
//			size	
//					Size of the buffer text.
//
/////////////////////////////////////////////////////////////////////////
EXPORT Int HC_GetFieldText(BEngine *pEngine, 
						   BImage *pImage,
						   BField *pField, 
						   Char *text, 
						   Int size);
EXPORT Int HC_GetFieldText_ID(BEngine *pEngine, 
						   BImage *pImage,
						   BField *pField, 
						   Char *text, 
						   Int size);

EXPORT Int HC_GetFieldText_XS(BEngine *pEngine, 
						   BImage *pImage,
						   BField *pField, 
						   Char *text, 
						   Int size);

/////////////////////////////////////////////////////////////////////////
//
//	Function	
//			BField *HC_GetBField_ID(BField *pField, BFieldID fid)
//
//			To retreive the BField node with the given field ID. It 
//			searches the link downward only from the given BField node
//
//	Return Value		
//			A pointer to the found BField node.  
//			NULL if it is not found.
//
//	Parameters	
//			pField	
//					Pointer to a link of the field information 
//					structure.
//
//
//			fid		Specifies the BField ID
//
/////////////////////////////////////////////////////////////////////////

EXPORT  BField *HC_GetBField_ID(BField *pfield, BFieldID fid);
EXPORT  BField *HC_GetBField_XS(BField *pfield, BFieldID fid);
EXPORT  Int HC_isDrivingPermit_XS(BField *pResult);//判断是否为行驶证
EXPORT int HC_SetSwitch_XS(BEngine *pEngine, int nSwitch, int mode);



/////////////////////////////////////////////////////////////////////////
/**************
功能：判断前景区域是否在指定矩形框内
输入：原图像pImage以及区域坐标rect
输入：区域外扩和内缩大小threshold
输入：angle：取值范围[0, 5]的整数，容许角度差
输出返回值：result (4位)：
00000001(1)表示有左边框线
00000010(2)表示有右边框线
00000100(4)表示有上边框线
00001000(8)表示有下边框线
当返回值 -1时，threshold超界
***************/	
/////////////////////////////////////////////////////////////////////////
EXPORT Char HC_CheckCardEdgeLine_ID(BEngine *pEngine, BImage *pImage, TRect rect, int threshold, int angle,int ratio_outside,int ratio_inside);
//新的
EXPORT Char HC_GetBandCardBorder_ID(BImage *pImage, TRect rect);

EXPORT BImage *HC_DupImage_ID(BImage *src, BRect *rect);
EXPORT Int HC_GetFileBorder_ID(SCAN_IMAGE *pImgSrc,TQuadrilateral *pStQuadrilateral);
EXPORT Int HC_GetPerspectiveImg_ID( SCAN_IMAGE *pImgSrc, TQuadrilateral *pStQuadrilateral);
EXPORT Int HC_YMVR_RecognizeVedio_ID(UChar *pData,Int width,Int height, Int set, BRect *pRect, Int(*func)(Int), Int(*func2)(Int),char *ChannelNumber,char *iosfilename,Int version);
EXPORT Int HC_YMVR_RecognizeVedio_ID_Vertical(UChar *pData,Int width,Int height, Int set, BRect *pRect, Int(*func)(Int), Int(*func2)(Int),char *ChannelNumber,char *iosfilename,Int version);
EXPORT BField *HC_allocBField_ID(BEngine *pEngine, int n);
EXPORT unsigned char *YuvToRgb_ID(unsigned char*m_pYuvBuf,int m_Width,int  m_Height,int type);
EXPORT unsigned char *YuvToGry_ID(unsigned char*m_pYuvBuf,int m_Width,int  m_Height, int type);
#ifdef _VIDEO_REC_SWITCH
EXPORT Int HC_YMVR_GetResult_ID(Char *pResult);
EXPORT Int HC_CheckResult_ID(BField **ppFieldSorce ,BField *pFieldDest);
EXPORT BImage * HC_YMVR_GetHeadInfo_ID();
EXPORT char * HC_STD_strdup(char *text);
EXPORT BImage * HC_YMVR_GetPicInfo_ID();
#endif
#ifdef _VIDEO_REC_SWITCH
EXPORT Int HC_CheckBlocks_XS(BField *pResult);
EXPORT Int HC_SwiftBlocks_XS(BField **ppFieldSorce ,BField *pFieldDest);

EXPORT  Char HC_GetBandCardBorder_XS(BImage *pImage, TRect rect);

EXPORT Int HC_YMVR_RecognizeVedio_XS(UChar *pData,Int width,Int height, Int set, BRect *pRect, Int(*func1)(Int), Int(*func2)(Int));
EXPORT Int HC_YMVR_GetResult_XS(Char *pResult);
EXPORT Int HC_YMVR_RecognizeVedio_JZ(UChar *pData,Int width,Int height, Int set, BRect *pRect, Int(*func1)(Int), Int(*func2)(Int));
EXPORT Int HC_YMVR_GetResult_JZ(Char *pResult);
#ifdef _VIDEO_REC_SWITCH
EXPORT Int  YMVR_RecognizeVedio_CP(UChar *pData,Int width,Int height, Int set, BRect *pRect, Int(*func)(Int), Int(*func2)(Int));
EXPORT Int YMVR_GetResult_CP(Char *pResult, Int size);
EXPORT BImage * YMVR_HeadInfo_CP(TRect *outRect);
EXPORT SByte* YMVR_YuvToRgb_CP(char *pYuvMem, short width, short height, Int nRgbToGry);
#endif
#ifdef __SAVEJPG
EXPORT	int HC_YMVR_Image_XS(char* imagefilename);
EXPORT	int HC_YM_SaveImage_XS(BImage *pImage,char* imagefilename);
#endif
EXPORT unsigned char *YuvToGry_XS(unsigned char*m_pYuvBuf,int m_Width,int  m_Height, int type);
EXPORT unsigned char *YuvToRgb_XS(unsigned char*m_pYuvBuf,int m_Width,int  m_Height,int type);
EXPORT	BField *HC_allocBField_XS(BEngine *pEngine, int n);
#endif
//获取LicenseStr
EXPORT void HC_getLicenseStr_CP(char *pText);
EXPORT Int HC_CheckResult(BField **ppFieldSorce ,BField *pFieldDest);
EXPORT	BField *HC_allocBField(BEngine *pEngine, int n);

    EXPORT BImage *HC_LoadRGBImageMem(BEngine *pEngine, char *pBuffer, Int width, Int height);

#ifdef __IOS	
    EXPORT BImage *YM_LoadImageMemIOS(UChar *pIOSMem, short width, short height, Int nRgbToGry);
    EXPORT BImage *HC_DupImage(BImage *src, BRect *rect);
#endif

#if defined(__cplusplus)
}
#endif

#endif	// _T_HC_BCR_H


