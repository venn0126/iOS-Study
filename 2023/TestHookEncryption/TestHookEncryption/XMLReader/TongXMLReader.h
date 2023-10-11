//
//  TongXMLReader.h
//  TestHookEncryption
//
//  Created by Augus on 2023/10/10.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    TongXMLParserOptionsProcessNamespaces           = 1 << 0, // 指定接收器呈现命名空间和指定的标签名称,
    TongXMLParserOptionsReportNamespacePrefixes     = 1 << 1, // 指定接收器呈现命名空间的范围,
    TongXMLParserOptionsResolveExternalEntities     = 1 << 2, // 指定接收器呈现外部实体的声明,
} TongXMLParserOptions;

NS_ASSUME_NONNULL_BEGIN

@interface TongXMLReader : NSObject

/// NSData格式的XML转换成字典
/// @param data NSData格式的XML
/// @param error 错误码
+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError *)error;


///  NSString格式的XML转换成字典
/// @param string  NSString格式的XML
/// @param error 错误码
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError *)error;

/// NSData格式的XML按照指定的形式转换成字典
/// @param data NSData格式的XML
/// @param options  指定的形式
/// @param error 错误码
+ (NSDictionary *)dictionaryForXMLData:(NSData *)data options:(TongXMLParserOptions)options error:(NSError *)error;


/// NSString格式的XML按照指定的形式转换成字典
/// @param string NSString格式的XML
/// @param options 指定的形式
/// @param error 错误码
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string options:(TongXMLParserOptions)options error:(NSError *)error;

/// NSData格式的XML转换成JSON字符串
/// @param data NSData格式的XML
/// @param error 错误码
+ (NSString *)jsonStringForXMLData:(NSData *)data error:(NSError *)error;


/// NSString格式的XML转换成JSON字符串
/// @param string NSString格式的XML
/// @param error 错误码
+ (NSString *)jsonStringForXMLString:(NSString *)string error:(NSError *)error;

/// NSData格式的XML按照指定的形式转换成JSON字符串
/// @param data NSData格式的XML
/// @param options 指定的形式
/// @param error 错误码
+ (NSString *)jsonStringForXMLData:(NSData *)data options:(TongXMLParserOptions)options error:(NSError *)error;


/// NSString格式的XML按照指定的形式转换成JSON字符串
/// @param string NSString格式的XML
/// @param options 指定的形式
/// @param error 错误码
+ (NSString *)jsonStringForXMLString:(NSString *)string options:(TongXMLParserOptions)options error:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
