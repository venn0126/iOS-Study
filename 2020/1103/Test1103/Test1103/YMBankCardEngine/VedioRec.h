/////////////////////////////////////////////////////////////////////////
//
//	File:	VedioRec.h
//
//	Author:	Yunmai Technology Pte. Ltd. (tjh)
//
//	Purpose :	Define bankcard recognize major functions of header file
//
//	Date:	Jun. 09, 2014
//
/////////////////////////////////////////////////////////////////////////

#ifndef _VEDIO_REC_H_
#define _VEDIO_REC_H_

#include "tdef_active.h"
#include "HCCommonData.h"

//#define _VIDEO_REC_SWITCH
#ifdef EXPORT
#undef EXPORT
#endif
//#define __EXPORT
#ifdef __EXPORT
#define EXPORT __declspec(dllexport)
#else
#define EXPORT
#endif


#ifdef __cplusplus
extern "C"
{
#endif
    
    //function define
#ifdef _VIDEO_REC_SWITCH
    EXPORT Int  YMVR_RecognizeVedio_BK(UChar *pData,Int width,Int height, Int set, BRect *pRect, Int(*func1)(Int), Int(*func2)(Int), char *pLicense, char *pPathIos);
    EXPORT Int  YMVR_RecognizeVedioVertical_BK(UChar *pData,Int width,Int height, Int set, BRect *pRect, Int(*func1)(Int), Int(*func2)(Int), char *pLicense, char *pPathIos);
    EXPORT Int YMVR_GetResult_BK(BCR_RESULT *pResult);
    EXPORT BImage *YMVR_GetTrnImage_BK();
    EXPORT Int YMVR_GetNumRect_BK(BRect *pRect);
    EXPORT Int  YMVR_RecognizeVedio_VIN(UChar *pData,Int width,Int height, Int set, BRect *pRect, Int(*func)(Int),Int(*func1)(Int),int language, char *pLicense);
	EXPORT Int YMVR_GetResult_VIN(Char *pResult, Int size);
	EXPORT BImage *YMVR_CarImage_VIN();
	EXPORT BImage *YMVR_CarImage_VinImage();
	EXPORT BImage * YMVR_HeadInfo(TRect *outRect);	
	EXPORT SByte* YMVR_YuvToRgb(char *pYuvMem, short width, short height, Int nRgbToGry);
#endif
	Int c(BField *pResult);
	EXPORT Int YMClearAll();
#ifdef __cplusplus
}
#endif


#endif//_VEDIO_REC_H_

