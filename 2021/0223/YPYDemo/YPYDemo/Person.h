//
//  Person.h
//  YPYDemo
//
//  Created by Augus on 2021/3/27.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
typedef void(^PersonSpeak) (void);
typedef void(^PersonSpeakName) (NSString *name);


__attribute__((objc_runtime_name("NWWPerson")))
@interface Person : NSObject{
    
    NSString *firstName;
}


//@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *name;

- (void)speak __attribute__((objc_requires_super));

//- (void)

@property (nonatomic, copy) PersonSpeak pSpeak;
@property (nonatomic, copy) PersonSpeakName pNameSpeak;



@end

NS_ASSUME_NONNULL_END
