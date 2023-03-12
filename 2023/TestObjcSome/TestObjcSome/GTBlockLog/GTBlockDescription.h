//
//  GTBlockDescription.h
//  TestObjcSome
//
//  Created by Augus on 2023/3/12.
//

#import <Foundation/Foundation.h>

struct GTBlockLiteral {
    void *isa; // initialized to &_NSConcreteStackBlock or &_NSConcreteGlobalBlock
    int flags;
    int reserved;
    void (*invoke)(void *, ...);
    struct block_descriptor {
        unsigned long int reserved;    // NULL
        unsigned long int size;         // sizeof(struct Block_literal_1)
        // optional helper functions
        void (*copy_helper)(void *dst, void *src);     // IFF (1<<25)
        void (*dispose_helper)(void *src);             // IFF (1<<25)
        // required ABI.2010.3.16
        const char *signature;                         // IFF (1<<30)
    } *descriptor;
    // imported variables
};

enum {
    GTBlockDescriptionFlagsHasCopyDispose = (1 << 25),
    GTBlockDescriptionFlagsHasCtor = (1 << 26), // helpers have C++ code
    GTBlockDescriptionFlagsIsGlobal = (1 << 28),
    GTBlockDescriptionFlagsHasStret = (1 << 29), // IFF BLOCK_HAS_SIGNATURE
    GTBlockDescriptionFlagsHasSignature = (1 << 30)
};
typedef int GTBlockDescriptionFlags;

NS_ASSUME_NONNULL_BEGIN

@interface GTBlockDescription : NSObject


@property (nonatomic, readonly) GTBlockDescriptionFlags flags;
@property (nonatomic, readonly) NSMethodSignature *blockSignature;
@property (nonatomic, readonly) unsigned long int size;
@property (nonatomic, readonly) id block;

- (id)initWithBlock:(id)block;

- (BOOL)isCompatibleForBlockSwizzlingWithMethodSignature:(NSMethodSignature *)methodSignature;


@end

NS_ASSUME_NONNULL_END
