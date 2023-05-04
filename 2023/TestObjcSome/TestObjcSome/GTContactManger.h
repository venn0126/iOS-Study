//
//  GTContactManger.h
//  TestObjcSome
//
//  Created by Augus on 2023/5/2.
//

#import <Foundation/Foundation.h>

#import <Contacts/CNContactStore.h>
#import <Contacts/CNContact.h>
#import <Contacts/CNContactFetchRequest.h>
#import <ContactsUI/CNContactViewController.h>
#import <ContactsUI/ContactsUI.h>

#define kNotificationContactsUpdated    @"ContactsUpdated"

NS_ASSUME_NONNULL_BEGIN

typedef void (^JSContactManagerCompletion)(BOOL success, NSError * __nullable error);
typedef void (^JSContactManagerFetchContactsCompletion)(NSArray * __nullable arrayContacts, NSError * __nullable error);
typedef void (^JSContactManagerUpdateContactsCompletion)(BOOL success, NSError * __nullable error);

@interface GTContactManger : NSObject

+(GTContactManger *)sharedContactManager;

@property (nonatomic) CNContactStore *store;
@property (nonatomic) NSMutableArray *arrayContacts;
@property (nonatomic) NSArray *keys;


- (void)requestContactManagerWithCompletion:(JSContactManagerCompletion)completion;

- (void)fetchContactsWithCompletion:(JSContactManagerFetchContactsCompletion)completion;

- (void)updateContact:(CNMutableContact*)mutableContact withCompletion:(JSContactManagerUpdateContactsCompletion)completion;

- (void)deleteContact:(CNMutableContact*)mutableContact withCompletion:(JSContactManagerUpdateContactsCompletion)completion;

- (void)addContact:(CNMutableContact*)mutableContact withCompletion:(JSContactManagerUpdateContactsCompletion)completion;

- (void)addOrUpdateContact:(CNMutableContact*)mutableContact withCompletion:(JSContactManagerUpdateContactsCompletion)completion;

- (BOOL)checkIfContactExist:(CNContact*)contact;

- (void)addDummyContacts;


@end

NS_ASSUME_NONNULL_END
