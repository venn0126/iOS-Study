//
//  NSObject+NWModel.h
//  NWModel
//
//  Created by Augus on 2021/2/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (NWModel)

/**
 Creates and return a new instance of receiver from a json
 This method is thread-safe
 
 @param json A json object in `NSDictionary`,`NSString`,`NSData`.
 
 @return A new instance created from the json,or nil if an error occurs
 
 */

+ (nullable instancetype)nw_modelWithJSON:(id)json;

/**
 Create a new instance from dictionary
 
 @param dictionary A key-value dictionary mapped to the instance 's properties
 Any invalid key-value pair in dictionary will be ignored
 
 
 @return A new instance created from the dictionary,or nil if an error occurs
 @discussion The key in `dictionary` will mapped to the receiver's property name ,
 and the value will set to the property. if the value's type does not match the property
 this method will try to convert the value based on these rules:
 
     `NSString` or `NSNumber` -> c number,such as BOOL,int,long,float,double,NSUInteger...
     `NSString` ->NSDate,parsed with format "yyyy-MM-dd'T'HH:mm:ssZ","yyyy-MM--dd HH:mm:ss" or"yyyy-MM-dd".
     `NSString` -> NSURL.
     `NSValue` -> struct or union,such as CGRect,CGSize,...
     'NSString' -> SEL,Class
 */
+ (nullable instancetype)nw_modelWithDictionary:(NSDictionary *)dictionary;

/**
 Set the receiver's properties with a json object
 @discussion Any invalid data in json will be ignored.
 
 @param json A json object  of  `NSDictionary`,`NSString` or `NSData`,mapped to the receiver's properties.
 
 @return Whether succed.
 
 */
- (BOOL)nw_modelSetWithJSON:(id)json;

/**
 Set the receiver's properties with a key-value dictionary.
 
 @param dictionary  A key-value dictionary mapped to the receiver's properties.
 Any invalid key-value pair in dictionary will be ignored.
 
 @discussion The key in `dictionary` will mapped to the reciever's property name,
 and the value will set to the property. If the value's type doesn't match the
 property, this method will try to convert the value based on these rules:
 
     `NSString`, `NSNumber` -> c number, such as BOOL, int, long, float, NSUInteger...
     `NSString` -> NSDate, parsed with format "yyyy-MM-dd'T'HH:mm:ssZ", "yyyy-MM-dd HH:mm:ss" or "yyyy-MM-dd".
     `NSString` -> NSURL.
     `NSValue` -> struct or union, such as CGRect, CGSize, ...
     `NSString` -> SEL, Class.
 
 @return Whether succeed.
 */
- (BOOL)nw_modelSetWithDictionary:(NSDictionary *)dictionary;

/**
 Create a json object from the receiver's propertyes.
 @return A json object `NSDictionary` or `NSArrar`,or nil if an error occurs.
 See [NSJSONSerizalzaiton isValidJSONObject] for more information.
 
 @discussion Any of the invalid property is ignored.
 If the receiver's is `NSArray`,`NSDictionary` or `NSSet`,it just convert
 the inner object to json object
 */
- (nullable id)nw_modelToJSONOBject;

/**
 Create a json string's data from the receiver's properties.
 
 @return A json string's data,or nil if an error occurs.
 
 @discussion Any of the invalid property is ignored.
 If the reciver is `NSArray`, `NSDictionary` or `NSSet`, it will also convert the
 inner object to json string.
 */
- (nullable NSData *)nw_modelToJSONData;

/**
 Generate a json string from the receiver's properties.
 
 @return A json string,or nil if error occurs.
 
 @discussion Any of the invalid property is ignored.
 If the reciver is `NSArray`, `NSDictionary` or `NSSet`, it will also convert the
 inner object to json string.
 */
- (nullable NSString *)nw_modelToJSONString;

/**
 Copy a instance with receiver's properties.
 
 @return A copied instance, or nil if an error occurs.
 */
- (nullable id)nw_modelCopy;

/**
 Encode the receiver's properties to a coder
 
 @param aCoder An archiver object
 */
- (void)nw_modelEncodeWithCoder:(NSCoder *)aCoder;

/**
 Decode the receiver's properties from a decoder
 
 @param aDecoder An archiver object
 
 @return self
 */
- (id)nw_modelInitWithCoder:(NSCoder *)aDecoder;

/**
 Get a hash code with the receiver's properties.
 
 @return Hash code.
 */
- (NSUInteger)nw_modelHash;

/**
 Compares the receiver's with another object for equality,based on properties.
 
 @param model Another object
 
 @return `YES` if the receiver is equal to the object,otherwise `NO`
 */
- (BOOL)nw_modelIsEqual:(id)model;

/**
 Description method for debugging purposes based on properties.
 
 @return A string that describes the contents of the receiver.
 */
- (NSString *)nw_modelDescription;

@end



/**
 Provide some data-model method for NSArray
 */
@interface NSArray (NWModel)

/**
 Creates and returns an array from a json-array.
 This method is thread-safe.
 
 @param cls The instance's class in array.
 @param json A json array of `NSArray`,`NSString` or `NSData`.
             Example [{"name":"Augus"},{"name":"Joe"}]
 */
+ (nullable NSArray *)nw_modelArrayWithClass:(Class)cls json:(id)json;

@end



@interface NSDictionary (NWModel)

/**
 Creates and returns a dictionary from a json.
 This method is thread-safe.
 
 @param cls  The value instance's class in dictionary.
 @param json  A json dictionary of `NSDictionary`, `NSString` or `NSData`.
              Example: {"user1":{"name","Mary"}, "user2": {name:"Joe"}}
 
 @return A dictionary, or nil if an error occurs.
 */
+ (nullable NSDictionary *)nw_modelDictionaryWithClass:(Class)cls json:(id)json;

@end



/**
 If the default model transform does not fit to your model class,implement one or
 more method in this protocol to change the default key-value transform process.
 There's no need to '<NWModel>' to your class header.
 */
@protocol NWModel <NSObject>
@optional

/**
 Custom property mapper
 
 @discussion If the key in JSON/Dictionary dose not match to the model's property name,
 implements this method and returns the additional mapper.
 
 Example:
 
    json:
        {
            "n":"Gao Tian",
            "p":255,
            "ext":{
                "desc":"a book written by Augus."
            },
            "ID": 10010

        }
 
    model:
    @code
        @interface NWBook : NSObject
        @property NSString *name;
        @property NSInteger page;
        @property NSString *desc;
        @property NSString *bookID;
        @end
 
        @implementation NWBook
        + (NSDictionary *)nw_modelCustomPropertyMapper {
            return @{
                    @"name"    :   @"n",
                    @"page"     :   @"p",
                    @"desc"     :   @"ext.desc",
                    @"bookID"   :   @[@"id",@"ID",@"book_id"]
 
                    };
        }
        @end
    @endcode
 
 @return A custom mapper for properties.
 */
+ (nullable NSDictionary<NSString *,id> *)nw_modelCustomPropertyMapper;

/**
 The generic class mapper for container properties.
 
 @discussion If the property is a container object,such as NSArray/NSSet/NSDictionary,
 implements this method and returns a property->class mapper,tells which kind of object
 will be add to the array/set/dictionary
 
 Example:
 @code
        @class NWShadow,NWBorder,NWAttachment;
        @interface NWAttributes
        @property NSString *name;
        @property NSArray *shadows;
        @property NSSet *borders;
        @property NSDictionary *attachments;
        @end
        
        @implementation NWAttributes
        + (NSDictionary *)nw_modelContainerPropertyGenericClass {
            return @{
                    @"shadows" : [NWShadow class],
                    @"borders" : NWborder.class,
                    @"attachments" : @"NWAttachment"
                    };
        }
        @end
 @endcode
 Generic -> 泛型
 @return A class mapper
 */
+ (nullable NSDictionary<NSString *,id>  *)nw_modelContainerPropertyGenericClass;

/**
 If you need to create instances of different classes during json->object transform,
 use the method to choose custom class based on dictionary data.
 
 @discussion If the model implements this method,it will be called to determine resulting class
 during `+nw_modelWithJSON:`,`+nw_modelWithDictionary:`,converting object of properties of parent objects
 (both singular and containsers via `nw_modelContainerPropertyGenericClass`).
 
 Example:
 @code
        @class NWCircle,NWRectangle,NWLine;
        @implementation NWShape
        + (Class)modelCustomClassForDictionary:(NSDictionary *)dictionary {
            if(!dictionary[@"radius"] != nil){
                return [NWCircle Class];
            }else if(dictionary[@"width"] != nil){
                return [NWRectangle class];
            }else if(dictionary[@"y2"] != nil){
                return [NWLine class];
            }else {
                return [self class];

            }
        }
        @end
 @endcode
 
 @param dictionary The json/kv dictionary
 
 @return Class to create from this dictionary,`nil` to use current class.
 */

+ (nullable Class)nw_modelCustomClassForDictionary:(NSDictionary *)dictionary;

/**
 All the properties in black list will be ignored in model transfrom process.
 Returns nil to ignore this feature.
 
 @return An array of property's name.
 */
+ (nullable NSArray<NSString *> *)nw_modelPropertyBlacklist;

/**
 If a property is not in the whitelist,it will be ignored in model transform process.
 Returns nil to ignore this future.
 
 @return An array of property's name.
 */
+ (nullable NSArray<NSString *> *)nw_modelPropertyWhitelist;

/**
 This method's behavior is similar to `-(BOOL)nw_modelCustomTransformFromDictionary:(NSDictionary *)dictionary;`,
 but be call before the model transform.
 
 @discussion If the model implements this method,it will be called before
 `+nw_modelWithJSON:`,`+nw_modelWithDictionary:`,`-nw_modelSetWithJSON:` and `-nw_modeSetWithDictionary:`.
 If this method returns nil,the transform process will ignore this model.
 
 @param dic The json/kv dictionary
 
 @return Returns the modified dictionary, or nil to ignore this model.
 */
- (NSDictionary *)nw_modelCustomWillTransformFromDictionary:(NSDictionary *)dic;

/**
 If the default json-to-model transform does not fit to your model object,implement
 this method to do additional process. You can also use this method to validate the
 model's properties.
 
 @discussion If the model implements this method,it will be called at the end of
 `+nw_modelWithJSON:`,`+nw_modelWithDictionary:`,`-nw_modelSetWithJSON:`, and `-nw_modelSetWithJSON:`.
 If this method returns NO, the transform process will ignore this model.
 
 @param dic The json/kv dictionary.
 
 @return Returns YES if the model is valid,or NO to ignore this model.
 */
- (BOOL)nw_modelCustomTransformFromDictionary:(NSDictionary *)dic;

/**
 If the default model-to-json transform dose not fit to your model class,implement
 this method to do additional process. You can also use this method to validate the
 json dictionary.
 
 @discussion If the model implements this method,it will be called at the end of
 `-nw_modelToJSONObject` and `-nw_modelToJSONString`.
 If this method returns NO,the transform process will ignore this json dictionary.
 
 @param dic The json dictionary
 
 @return Returns YES if the model is valid,or NO to ignode this model.
 */
- (BOOL)nw_modelCustomTransformToDictionary:(NSMutableDictionary *)dic;
@end
NS_ASSUME_NONNULL_END
