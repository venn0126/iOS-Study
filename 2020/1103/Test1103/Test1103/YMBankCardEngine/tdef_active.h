
// tdef_active file

#ifndef _T_DEF_ACTIVE
#define _T_DEF_ACTIVE

#if defined DEBUG && !defined _DEBUG
#define _DEBUG
#endif

// Here define the active definitions

// For specific platform, you can modify this file to define the 
// key words for compiling if they are not able to be defined in 
// compiler environment

/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

			--------------------- TOP Definition!!! -----------------------------------

  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
#ifndef __pcbcr
//#define __pcbcr
#endif

#ifndef _API_ALL
#define _API_ALL //
#endif

#ifndef FONT_TYPE
#define FONT_TYPE //
#endif

#ifndef _HC_POSITION
#define _HC_POSITION //
#endif
#ifndef __NN
#define  __NN  //neural network
#endif

#ifndef __CAS_DETECT
#define  __CAS_DETECT  //cascade detect
#endif
#ifndef _MOB_ANDROID
#define  __IOS
#endif

// NDK R10 SWITCH
#ifdef _MOB_ANDROID
#define __NDK_R_10
#endif
#ifndef SIMPLE_MLINE_DOC
//#define SIMPLE_MLINE_DOC 
#endif
/****************************************************************************************************
*****************************************************************************************************/


#ifdef __pcbcr
#define __pc  // 
#endif

//#define __OCR_SP	// For ScanPen OCR, __OCR_SP is required	

#ifndef __OCR_SP
//#define __BCR		// define it for BCR and OCR
#define __OCR		// define it if only OCR required
#endif

// For BCR engine, __IDCR is required
//
#if !defined __OCR_SP && !defined __OCR && !defined __IDCR
#define __IDCR
#endif

// For many platforms, __dev is enough for porting. 
//
#if !defined __pc
#define __mydev  //??
#endif


// For benchmark, this is required to get information
// FOR real device, remove SIM_FILES,, so the engine can use
// SIM_* functions.
//
//#define SIM_FILES		

// If the platform does not support global variable, define _NO_GLOBAL.
//
//#define _NO_GLOBAL

#if !defined SIM_FILES && !defined _NO_GLOBAL
#define _NO_GLOBAL
#endif

// For real device, DO NOT define _DEBUG_DEV and _PROMPT_DEV
//

//tjh modify 20110803
//#if defined _DEBUG 
#ifndef _DEBUG_DEV
#define _DEBUG_DEV
#endif

#define _PROMPT_DEV

// For real device, DO NOT define CLOCK_ON
#ifdef WIN32
//#define CLOCK_ON			// speed checking
#endif

//Defines for using data/cfg as  C files
//
//#define _HEADER_DATA			// using c files for both config and data
#define _HEADER_CONFIG_DATA	// using c file for config
#define _HEADER_HCDAT_DATA	// using c file for data
//#define _HEADER_DATA_INT		// define this if config/data is int array

//#define __MULTI_STEPS



//#define _compacted_tst	// compacted size for TST module

#define CHINESE_CODE
#define WITH_DOCIMG_PROCESS
#ifndef __pcbcr
#define _NEW_OCR
#endif
#define _compacted_tst	// compacted size for TST module
#ifdef __mydev	// device
#define _PLATFORM_VER	"dv"
#define __arms
#define _DEBUG_LYT	// draw blocks on BW image
#endif

#define __IDCR
//#define PASSPORT 
//#define DRIVING_LICENSE 

#define __ID_CARD  //���֤

#ifdef __ID_CARD
#define __ID_CARD_1
#define __ID_CARD_2
#define __ID_CARD_2_BACK
#define __ID_CARD_TEMP
#endif

//#define __PASSPORT       //����

#ifdef __PASSPORT
#define __PASSPORT_CHN   //�й�����
#define __PASSPORT_INTE  //���ʻ���
#define __PASSPORT_HK    //�۰�ͨ��֤
#define __PASSPORT_TW    //̨��֤
#endif

//#define __HK_REENTRY_PERMIT //����֤
#define __DRIVING_LICENSE   //����
#define __DRIVING_PERMIT      //��ʻ֤
//#define __HOUSEHOLD_BOOK    //���ڱ�
//#define __MILITARY_CARD     //ʿ��֤
#define __SRV_TIME_LIMITE // ������ʱ�����ƿ���

#ifdef __IDCR
#define __PAPER
#endif


// for PC BCR
#ifdef __pcbcr
//#define __IDCR
//#define WITH_PINYIN
#endif
//#define _HC_POSITION	// define this to export character candidates
#ifndef _HC_POSITION
#define _HC_POSITION	// define this to export character candidates
#endif

#ifdef __IDCR
//#define SEL_FIELDS
//#define TWO_FIELDS
#endif

//#define __ONE_LINE // only for BBK project, don't use the define in OCR test.

#ifdef __OCR
//#define LYX_POST  //������
#endif

#ifdef __OCR_SP
//#define LYX_POST
#endif

#ifndef FONT_TYPE
//#define FONT_TYPE
#endif
#define __WINPC // ������ʱ�����ƿ���
//#define __NO_NETWORK//�����粻����
//#define __LISENSE_CHECK // ��������ſ���
//#define __OCR_JSON
//#define  DEBUG_PRINTF
#define __VIDEO_JSON
//#define __SAVEJPG
//#define __OCRTIMES //ͳ��ʶ�����
#define  __HEADANDRGBIMAGE
#define _VIDEO_REC_SWITCH //���߳���Ƶʶ�𿪹�
//#define __ACTION
//#define  _MOB_ANDROID
#ifdef _VIDEO_REC_SWITCH //androidƽ̨���߳���Ƶʶ�𿪹�
#define __LINE_REC  //����ʶ��
#define __IOS
#define __RGBIMAGE
#endif
#endif