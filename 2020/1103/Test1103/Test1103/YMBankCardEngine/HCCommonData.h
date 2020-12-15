/////////////////////////////////////////////////////////////////////////
//
//	File:		HCCommonData.h
//  
//	Author:		Hotcard Technology Pte. Ltd.
//				CDZ			
//
//	Purpose :	Define Hotcard Common Data Used In All Application(BCR,DOC,OCR):
//              1. base datas 
//              2. datas used in the ocr common apis
//              3. ocr result data
//              4. image data
//              5. ocr engine data
//
//	Date:		20100121
//
/////////////////////////////////////////////////////////////////////////

#ifndef _HC_COMMON_DATA_H
#define _HC_COMMON_DATA_H

/**
 *	For compiling Setting: V8.2.0
 **/
#include "tdef_active.h"

/***********************************************************************************************
 *
 *
 *------------------------------------------1. base datas --------------------------------------
 *
 *
 ************************************************************************************************/

typedef char	Char;
typedef unsigned char	UChar;

typedef short	Short;
typedef unsigned short	UShort;
#ifndef U_SHORT
#define U_SHORT
typedef unsigned short	Ushort;
#endif
typedef int	Int;
typedef unsigned int	UInt;

typedef long	Long;
typedef unsigned long	ULong;

typedef short	Sint;
typedef unsigned short	Suit;

typedef UChar	uch;
typedef UShort	ush;

typedef float   Float;
typedef UChar	SByte;

#ifdef _VIDEO_REC_SWITCH
#define THREAD_NUM 1
#define MAX_TIME ((THREAD_NUM * 3) <10? 10: (THREAD_NUM * 3) )
#endif
/***********************************************************************************************
 *
 *
 *------------------------------2. datas used in the ocr common apis-----------------------------
 *
 *
 ************************************************************************************************/

//for error definition
typedef enum
{ 
    BERR_CLEAR				= 0,
    BERR_OK					= 1,
    
    BERR_NO_MEM				= 2,
    BERR_OTHER				= 3,
    
    BERR_MEM_ALLOC			= 4,
    BERR_MEM_LOCK			= 5,
    BERR_MEM_UNLOCK			= 6,
    
    BERR_VEM_INIT			= 7,
    BERR_PARAMETER			= 8,
    
    BERR_FILE_NOT_EXIST		= 20,
    BERR_FILE_READ			= 21,
    BERR_FILE_WRITE			= 22,
    
    BERR_IMAGE				= 30,
    BERR_IMG_PROCESS			= 31,
    BERR_IMG_TRN				= 32,
    BERR_IMG_CARDNUM_POS		= 33,
    BERR_IMG_G2B				= 34,
    BERR_IMG_SEG		    	= 35,
    
    BERR_OCR					= 40,
    BERR_OCR_INIT			= 41,
    BERR_OCR_TPM_INIT		= 42,
    BERR_OCR_RECOGNIZE		= 43,
    BERR_OCR_CHAR_REC		= 44,
    BERR_OCR_BLOCK_REC		= 45,
    BERR_OCR_DETECT			= 46,
    BERR_OCR_GET_RESULT		= 47,
    
    BERR_OPP					= 50,
    
    BERR_TRIAL				= 100,
}
ERR_Code;

enum
{
	OCR_ERR,
		OCR_OK,
		OCR_IMG_BLURED,
		OCR_STOPPED,
		OCR_SUSPEND
};

#define OCR_FALSE			OCR_ERR
#define OCR_TRUE			OCR_OK

//for OCR language definition
typedef enum {
	
	OCR_LAN_NIL				= 0x00,	// NIL
		OCR_LAN_ENGLISH			= 0x01,	// English
		OCR_LAN_CHINESE			= 0x02,	// chinese
		OCR_LAN_EUROPEAN		= 0x03,	// English + European
		OCR_LAN_RUSSIAN 		= 0x04,	// Russian
		OCR_LAN_TAMIL	 		= 0x05,	// Tamil
		OCR_LAN_JAPAN 			= 0x06,	// Japan
		OCR_LAN_CENTEURO        = 0x07, // Central European
		OCR_LAN_KOREA           = 0x08, // KOREA
		OCR_LAN_TURKISH         = 0x09, // English + Turkish
		OCR_LAN_MixedEC			= 0x10,	// mixed chinese/english
		
		OCR_LAN_MAX	 			= 0x12
		
} OCR_Language;

//for image orientation definition
typedef enum {
	
    OCR_ORIE_AUTO	= 0, 	// Auto orientation
	OCR_ORIE_HORI	= 1, 	// Horizontal 
	OCR_ORIE_VERT	= 2, 	// Vertical 
	OCR_ORIE_MAX	= 2
		
} OCR_Orientation;


//for char code definition
#ifndef __se
typedef enum {
	
    OCR_CODE_NIL= 0, 		// default
		OCR_CODE_GB	= 1, 		// GB code
		OCR_CODE_B5	= 2, 		// B5 code 
		OCR_CODE_GB2B5	= 3, 	// GB to Big5 code converter 
		OCR_CODE_B52GB	= 4, 	// Big5 to GB code converter 
		OCR_CODE_GB2PY	= 5,	// GB to Pinyin
		OCR_CODE_B52PY	= 6		// Big5 to Pinyin
		
} OCR_Codec;
#else
typedef enum {
	
    OCR_CODE_B5	= 0, 		// B5 code
	OCR_CODE_GB	= 1, 		// GB code
		
} OCR_Codec;
#endif

//for flip method definition
typedef enum {
	
    OCR_FLIP_NIL	= 0, 	// Default from config file
		OCR_FLIP_YES	= 1, 	// Auto detect 
		OCR_FLIP_NO		= 2, 	// Do not flip
		OCR_FLIP_MAX	= 2
		
} OCR_Flip;

//for ocr application type definition
typedef enum {
	
    OCR_READ_DEF	= 0, 	// Default from config file
		OCR_READ_BCR	= 1, 	// BCR 
		OCR_READ_OCR	= 2, 	// Line OCR
		OCR_READ_DOC	= 3		// Doc OCR
		
} OCR_Reader;

//for image input type definition
typedef enum
{ 	
	OCR_IMG_SCAN	= 0,	// scan image
	OCR_IMG_CAMERA	= 1,	// camera image
	OCR_IMG_PHOTO	= 2,	// photo
}
OCR_ImageType;

//for bussiness card image type definition
typedef enum
{ 	
	OCR_CARD_BAK		= 0,	// back
		OCR_CARD_FNT		= 1,	// front
}
OCR_CardFace;

//for OCR method type definition
typedef enum
{ 	
	OCR_READ_AUTO		= 0,	// auto BCR
		OCR_READ_MANUAL		= 1,	// manual select block
}
OCR_Reading;

//for OCR result's case type definitioon
typedef enum
{ 	
	OCR_CASE_DEF	= 0,	// default
		OCR_CASE_UPPER	= 1,	// UPPER CASE
		OCR_CASE_LOWER	= 2,	// lower case
		OCR_CASE_TITLE	= 3,	// Title Case
}
OCR_LetterCase;

//for OCR memo setting type definition
typedef enum 
{
	OCR_MEMO_NIL       = 0,	// no memo
		OCR_MEMO_OCR	   = 1,	// copy OCR to memo
		OCR_MEMO_UNDEFINED = 2,	// memo for undefined field
}
OCR_MemoSetting;

//for image blue type definition
typedef enum
{
	OCR_BLUR_NORMAL = 0,	// normal detection
		OCR_BLUR_WEAK   = 1,	// weak detection
		OCR_BLUR_SRICT  = 2,	// strict detection
}
OCR_Blur;

//for OCR read method type definition
typedef enum
{
	OCR_STEP_SINGLE	= 0,	// Single step
		OCR_STEP_MULTI	= 1		// Multi-steps
}
OCR_ReadSteps;

//for image process method type definition
typedef enum
{
	OCR_IMG_NON    = 0x00000000,	// no action for original image
		OCR_IMG_CROP   = 0x00000001,	// Crop original image
		OCR_IMG_ROT    = 0x00000002,	// do rotate for original image
		OCR_IMG_DESK   = 0x00000004,	// do deskew for original image
		OCR_IMG_BORDER  =0x00000008,
		OCR_IMG_DEF    = 0x0000000F,	// default value ( crop, rotate, deskew)
		OCR_IMG_SRC    = 0x00000010,	// Process original image 
		
		OCR_IMG_BW     = 0x00000000,	// require B/W image
		OCR_IMG_GRY    = 0x00010000,	// require gray image
		OCR_IMG_RGB    = 0x00020000,	// require rgb image
}
OCR_ImageWork;

//for base method definition
#define ASK_IMAGE(a, b)			(((a) & 0x000f0000) == (b))
#define ASK_ACTION(a, b)		(((a) & (b)) == (b))
#define ASK_ACTION_SET(a, b)	((a) |= (b))
#define ASK_ACTION_CLR(a, b)	((a) &= ~(b))

//for OCR method switch type definition
typedef enum
{
	SET_NIL            =  0,	// nil
		SET_OCR_IMAGE      =  1,	// set image type
		SET_OCR_FLIP       =  2,	// set flip control
		SET_OCR_ORIENT     =  3,	// set text orientation
		SET_CARD_FACE      =  4,	// set side of cad to read
		SET_READER         =  5,	// set recognizer
		SET_READING        =  6,	// set recognition mode
		SET_CHINESE_CODE   =  7,	// set chinese codec
		SET_LETTER_CASE    =  8,	// set output format
		SET_MEMO           =  9,	// set memo option
		SET_MULTI_STEPS    = 10,	// set multi steps mode
		SET_IMG_WORK       = 11,	// set work for original gray image
		SET_CUR_DETECT     = 12,     // set mode to detect mouse position
		SET_IMG_BORDER       = 13	// set work for original gray image
}
OCR_Switch;


/***********************************************************************************************
 *
 *
 *------------------------------3. ocr result data-----------------------------
 *
 *
 ************************************************************************************************/


//for FID type(FID ID definition)
typedef enum
{
	BFID_NON,			// Blank field
		BFID_NAME,			// Name
		BFID_NAME_FIRST,	// First Name
		BFID_NAME_LAST,		// LAST Name
		BFID_DESIGNATION,	// Designation
		BFID_TITLE,			// Title for education/certificate degree
		BFID_DEPARTMENT,	// Department 
		BFID_COMPANY,		// Company name
		BFID_ADDRESS,		// Address
		BFID_POSTCODE,		// Postal code
		BFID_CITY,			// City
		BFID_STATE,			// State
		BFID_COUNTRY,		// Country
		BFID_POBOX,			// P. O. Box number
		BFID_TEL,			// Telephone number
		BFID_TELH,			// Home telephone number
		BFID_HP,			// Mobile phone number
		BFID_DID,			// Direct international dial number
		BFID_FAX,			// Fax number
		BFID_PAGER,			// Pager number
		BFID_EMAIL,			// Email address
		BFID_WEB,			// Web site
		BFID_TAXCODE,		// Reference code for tax
		BFID_ACCOUNT,		// Account number
		BFID_BANK,			// Name of the bank
		BFID_CHEQUE,		// Title issued on cheque
		BFID_CABLE,			// Telegraph number
		BFID_TELEX,			// Telex number
		BFID_ICQ,			// ICQ number
		BFID_ADD_COUNTRY,   //add by Greener 20090415
		BFID_ADD_PROVINCE,
		BFID_ADD_CITY,
		BFID_ADD_STREET,
		BFID_ADD_BUILDING,
		BFID_ADD_NO,
		BFID_EXTRA,			// Feild can be defined by user
		BFID_MEMO,			// memo field

		BFID_PRENAME,		// prename keyword
		BFID_NONESENSE,		// following ones are keyword specific
}
BFieldID;
#define BFID_MAX	(BFID_MEMO + 1)
#define BFID_MAXLIST	(BFID_NONESENSE + 1)


//block type definition
#define COMPOSITE   0
#define TEXT_BLOCK  1
#define NON_TEXT    2
#define PRINTED     3
#define HANDWRIT    4
#define COMPONENT   5
#define LINE_TEXT   7
#define NOT_KNOWN   8
#define ROOT_BLOCK  9
#define TEXT_TABLE	10

#define DEF_FLABEL_DEL		-1	// not used field
#define DEF_FLABEL_OK		0	// normal field
#define DEF_FLABEL_FMT		1	// formated field
#define MAX_NUM_LENGTH 32
#define MIN_NUM_LENGTH 7

#define BINNUM_LENGTH 20       //BIN 码的长度
#define BINUM_STR_LENGTH 20 //BIN码字符串的存储长度
#define BANK_NAME_LENGTH 64   //发卡行的长度
#define CARD_NAME_LENGTH 64   //卡种类的长度
#define CARD_TYPE_LENGTH 16   //卡类型的长度
typedef struct B_Rect
{
	Short	lx;
	Short	ly;
	Short	rx;
	Short	ry;
}
BRect;

//for char position output
#define DEF_BTOP_CHARS	10
typedef struct B_Char
{
	Short	size;
	Short	ntops;
	Char	topchars[(((DEF_BTOP_CHARS + 3) >> 2) << 2)][4];
	BRect	rect; //is offset of block position
	Short   conf[(((DEF_BTOP_CHARS + 3) >> 2) << 2)];
	Short      reserved;
}
BChar;
typedef struct _point
{
	Short x;
	Short y;
}THCPoint;
typedef struct B_Line
{
	Int		nchars;
	BChar	*pchars;
	char	*text;
#ifdef FONT_TYPE
	UChar   *pTraFont;
	Int  iFontType;
#endif
}
BLine;

typedef struct B_Lines
{
	Short	nsize;		// size of line buffer
	Short	nlines;		// actual number of lines
	BLine	*plines;	// line buffer
}
BLines;


//for font type definition
typedef enum
{
	CHFONT_SONGTI = 1,
		CHFONT_HEITI,
		CHFONT_KAITI,
		CHFONT_YUANTI,
		CHFONT_LISHU,
		CHFONT_FANGSONG,
		CHFONT_XINGKAI,
		CHFONT_WEIBEI,
		CHFONT_ZONGYI
}Font_Type;

#ifdef __IDCR
typedef enum
{
	TUNKNOW           = 0x00,
		TIDCARD       = 0x10,   //身份证
		TIDCARD2      = 0x11,   //二代证
		TIDCARD1      = 0x12,   //一代证
		TIDCARDBACK   = 0x14,   //二代证背面   
		TIDCARDTEMP   = 0x18,   //临时身份证
		TPASSCARD     = 0x20,   //护照
		TPASSCARDINTR = 0x21,   //国际护照
		TPASSCARDCHN  = 0x22,   //中国护照
		TPASSCARDHK   = 0x24,   //港澳通行证 
		TPASSCARDTW   = 0x28,   //台胞证
		TDRIVERCARD   = 0x40,   //驾照
		TDRIVINGPERMIT= 0x41,  //行驶证
		TOTHERCARD    = 0X80,   //其它证件   
		TMILITARYCARD = 0x81,   //士兵证
		THOUSEHOLDBOOK = 0x82   //户口本
} CARD_TYPE;
#endif

typedef struct B_Field
{
//	union
//	{
		Short	fid;		// Field ID,for BCR result
		Short   blocktype;  //for OCR result
//	};	
	Short	mem;
	
#ifdef __IDCR
	Int     cardtype;
	BLine *pline;
	Char *poritext; //save originally text
	BRect headImgRect;     //the position of head image on id_card image * tjh add 20111208
#endif
	
	Char	*text;		// Field text
	int     conf;		// Field conf
	int     addconf;		// Field conf
	BRect	rect;		// Field position on image
	BRect	rectint;	// Field position on internal image
	Short	label;
	Short	size;		// Field text buffer size
	int		i1;
 	int		i2;
	Int     rotationAngle;  // i
#ifdef _HC_POSITION
	Int		nchars;
	BChar	*pchars;
	Int     angle;	
#endif
	
#ifdef WITH_PINYIN
	Char	*textpy;		// Field text
#endif
	
	
#ifdef FONT_TYPE
	UChar *pTraFont;  //for T_CH case: one GB code accord with muti GIG5 codes
	Font_Type iFontType;
#endif
	
	Char   reserve[32];
	
	struct B_Field	*child;
	struct B_Field	*prev;
	struct B_Field	*next;
}
BField;
typedef struct bankcard_info
{
	BRect       numRect;         /* Card num rect info in bankcard image */
	BRect       imgRect;         /* Prospect area rect or Video rect info in bankcard image */
	THCPoint    aUnionpayPos[4]; /* Unionpay logo position */
	
	Char		nPerTra;         //if nPerTra=1,means image is perspective transformation,or else nPerTra = 0 ;          
	Char		isConvex;        /*if isConvex = 1, means bankcard numbers is convex, isConvex = 0 ,bankcard numbers isn't convex*/  
	Short		nFormat;		 /*bankcard numbers format*/
}
BC_INFO;
#ifdef __IDCR
typedef enum
{
	BIDC_NON,                  //non
		BIDC_NAME,              //姓名
		BIDC_NAME_CH,           //姓名（中文）
		BIDC_CARDNO,            //证号
		BIDC_SEX,               //性别
		BIDC_BIRTHDAY,          //出生日期
		BIDC_ADDRESS,           //地址
		BIDC_ISSUE_AUTHORITY,   //签发机构
		BIDC_ISSUE_DATE,        //签发日期
		BIDC_VALID_PERIOD,      //有效期限
		BIDC_COUNTRY,           //国籍
//#ifdef __ID_CARD
		BIDC_FOLK,              //民族
//#endif
//#ifdef __PASSPORT
		BIDC_PN,                //个人号码
//#endif
//#ifdef __DRIVING_LICENSE
		BIDC_DRIVING_TYPE,      //准驾车型
//#endif
#ifdef __DRIVING_PERMIT
		BIDC_VEHICLE_TYPE,      //车辆类型
		BIDC_USE_CHARACTE,      //使用性质
		BIDC_MODEL,             //品牌型号
		BIDC_VIN,               //车辆识别代号
		BIDC_ENGINE_PN,         //发动机号码
		BIDC_REGISTER_DATE,     //注册日期		
#endif


		BIDC_MEMO
}
BIDCard;

#define BIDC_MAX		(BIDC_MEMO + 1)

#endif

typedef struct T_Rect
{
    Short    lx;
    Short    ly;
    Short    rx;
    Short    ry;
}
TRect;

typedef struct T_MastImage {
    
    Short    width;
    Short    height;
    Short    xres;
    Short    yres;
    SByte    **pixels;
    
    UShort    type;
    UChar    status;
    UChar    key;
    
    Short x1, x2;    //
    Short y1, y2;    //
    TRect CropRect;//added by CZ for getting exact position in the end.20090205
    void  *ptr;        // can be used to pass user defined struct
    
    struct T_MastImage    *secImage;
    
    SByte    msk[24];
}TMastImage,BImage,SCAN_IMAGE;

#ifndef DEFINE_BCR_RESULT
#define DEFINE_BCR_RESULT
typedef struct bcr_result
{
    Int      nFormat;                      //银行卡号格式类型 1:19 2:6+13 3:4*3+7 4:4*4+3 5:4*4 6:6+3+3+7 7:6+4+7
    Int            nChar;                            //卡号个数
    Char        text[MAX_NUM_LENGTH];         //识别结果
    BChar       bChar[MAX_NUM_LENGTH];          //候选集和位置信息
    Char      binnum[BINUM_STR_LENGTH];          //BIN 码
    Char      bankname[BANK_NAME_LENGTH];      //发卡行
    Char      cardname[CARD_NAME_LENGTH];      //卡种类
    Char      cardtype[CARD_TYPE_LENGTH];      //卡类型
    Int          nIsRight;                       //判断识别结果是否正确
    BRect     numRect;                        /* Card num rect info in bankcard image */
    BImage    *pTrnImg;
    
}BCR_RESULT;
#endif
/***********************************************************************************************
 *
 *
 *------------------------------4. image data---------------------------------------------------
 *
 *
 ************************************************************************************************/

#define IMG_BMP		0x0001
#define IMG_BIN		0x0002
#define IMG_GRY		0x0004
#define IMG_RGB		0x0008
#define IMG_CCA		0x0010

#define IMG_SRK		0x8000
#define IMG_SRC		0x4000
#define IMG_VMM		0x2000		// virtual memory

#define IMG_MASK_TYPE	0x00ff
#define IMG_MASK_STAT	0xff00

#define IMG_TYPE(a)		((a)->type & IMG_MASK_TYPE)
#define IMG_STAT(a)		((a)->type & IMG_MASK_STAT)

typedef struct T_blur
{
	int 	color;
	int	    value;
	int     x1;
	int    x2;
	int  x3;
	int x4;
	int mid;
 
}
Tblur;
#define IMG_MASK0(a)	((a)->msk)
#define IMG_MASK1(a)	((a)->msk + 8)
#define IMG_MASK2(a)	((a)->msk + 16)

//typedef TMastImage	SCAN_IMAGE;
typedef TMastImage	OCR_IMAGE;
//typedef TMastImage	BImage;
typedef TMastImage	TImage;

//for image converting
typedef struct B_Convert
{
	void	*pOption;       
	void	*pGlobalData;   //tjh add at 20130204
	Int		nLanguage;		// Language of text
	Int		nCamera;		// 1 for camera image
	Int		nBlurDetect;	// 1 to turn ON blur detection
	
	Int		nBlurImage;		// it is 1 if image is blur
	Int     cardType;       //card type 	
	Int		nQuality;		// control what function to do 
	
	BImage			*pImg;
	UChar	*buf;
	Int				row;
	Int				fm;
	
	Int				**strip;
	Char			**revers;
	UInt	*hist;
	UInt	sum;
	Int				num;
	Int				step;
}
BConvert;


/***********************************************************************************************
 *
 *
 *------------------------------5. ocr engine data---------------------------------------------------
 *
 *
 ************************************************************************************************/


typedef struct _BCR_Engine
{
	void		*pBcrEngine;
	
	Char		pBuffer[4096];
}
BEngine;
typedef struct L_Point
{
    Int	x, y;
}
LPoint;
typedef struct T_QUADRILATERAL
{
    LPoint stLeftup;
    LPoint stRightup;
    LPoint stLeftdown;
    LPoint stRightdown;
    Int nBorderLineLen;//组成四边形四条直线长度
    Int nAreaLen;//四边形面积
    Int nDisConnectLineLen;//四边形间断直线长度
}TQuadrilateral;

typedef struct T_Point
{
	Short	x;
	Short	y;
}
TPoint;

struct BANK_CARD_INFO
{
    LPoint stQuadrilateralPoints[4];
    LPoint stUnionPayPoints[4];
    TRect stLineRect;//视频给定直线
    TRect stCardRect;//
    TRect stBorderLineRect[4];//边框线
    SByte unionPosition;//银联位置
};

#endif
