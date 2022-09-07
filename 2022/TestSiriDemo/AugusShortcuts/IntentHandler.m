//
//  IntentHandler.m
//  AugusShortcuts
//
//  Created by Augus on 2022/8/11.
//

#import "IntentHandler.h"
#import "HotListHandler.h"

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"


// INPlayMediaIntentHandling
@interface IntentHandler () <INSendMessageIntentHandling, INSearchForMessagesIntentHandling, INSetMessageAttributeIntentHandling, INPlayMediaIntentHandling>

@end

@implementation IntentHandler

- (id)handlerForIntent:(INIntent *)intent {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.
    
    NSLog(@"%@---%@---%@",@(__func__),@(__LINE__),NSStringFromClass([intent class]));

//    if ([intent isKindOfClass:[HotListIntent class]]) {
//        return [HotListHandler new];
//    } else if([intent isKindOfClass:[INStartWorkoutIntent class]]) {
//        return [INStartWorkoutIntent new];
//    }else
//    if([intent isKindOfClass:[INPlayMediaIntent class]]) {
//        return [SNPlayMediaIntentHandler new];
//    }
    
    return self;
}

#pragma mark - INSendMessageIntentHandling

// Implement resolution methods to provide additional information about your intent (optional).
- (void)resolveRecipientsForSendMessage:(INSendMessageIntent *)intent with:(void (^)(NSArray<INSendMessageRecipientResolutionResult *> *resolutionResults))completion {
    NSArray<INPerson *> *recipients = intent.recipients;
    // If no recipients were provided we'll need to prompt for a value.
    if (recipients.count == 0) {
        completion(@[[INSendMessageRecipientResolutionResult needsValue]]);
        return;
    }
    NSMutableArray<INSendMessageRecipientResolutionResult *> *resolutionResults = [NSMutableArray array];
    
    for (INPerson *recipient in recipients) {
        NSArray<INPerson *> *matchingContacts = @[recipient]; // Implement your contact matching logic here to create an array of matching contacts
        if (matchingContacts.count > 1) {
            // We need Siri's help to ask user to pick one from the matches.
            [resolutionResults addObject:[INSendMessageRecipientResolutionResult disambiguationWithPeopleToDisambiguate:matchingContacts]];

        } else if (matchingContacts.count == 1) {
            // We have exactly one matching contact
            [resolutionResults addObject:[INSendMessageRecipientResolutionResult successWithResolvedPerson:recipient]];
        } else {
            // We have no contacts matching the description provided
            [resolutionResults addObject:[INSendMessageRecipientResolutionResult unsupported]];
        }
    }
    completion(resolutionResults);
}

- (void)resolveContentForSendMessage:(INSendMessageIntent *)intent withCompletion:(void (^)(INStringResolutionResult *resolutionResult))completion {
    NSString *text = intent.content;
    if (text && ![text isEqualToString:@""]) {
        completion([INStringResolutionResult successWithResolvedString:text]);
    } else {
        completion([INStringResolutionResult needsValue]);
    }
}

// Once resolution is completed, perform validation on the intent and provide confirmation (optional).

- (void)confirmSendMessage:(INSendMessageIntent *)intent completion:(void (^)(INSendMessageIntentResponse *response))completion {
    // Verify user is authenticated and your app is ready to send a message.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSendMessageIntent class])];
    INSendMessageIntentResponse *response = [[INSendMessageIntentResponse alloc] initWithCode:INSendMessageIntentResponseCodeReady userActivity:userActivity];
    completion(response);
}

// Handle the completed intent (required).

- (void)handleSendMessage:(INSendMessageIntent *)intent completion:(void (^)(INSendMessageIntentResponse *response))completion {
    // Implement your application logic to send a message here.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSendMessageIntent class])];
    INSendMessageIntentResponse *response = [[INSendMessageIntentResponse alloc] initWithCode:INSendMessageIntentResponseCodeSuccess userActivity:userActivity];
    completion(response);
}

// Implement handlers for each intent you wish to handle.  As an example for messages, you may wish to also handle searchForMessages and setMessageAttributes.

#pragma mark - INSearchForMessagesIntentHandling

- (void)handleSearchForMessages:(INSearchForMessagesIntent *)intent completion:(void (^)(INSearchForMessagesIntentResponse *response))completion {
    // Implement your application logic to find a message that matches the information in the intent.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSearchForMessagesIntent class])];
    INSearchForMessagesIntentResponse *response = [[INSearchForMessagesIntentResponse alloc] initWithCode:INSearchForMessagesIntentResponseCodeSuccess userActivity:userActivity];
    // Initialize with found message's attributes
    response.messages = @[[[INMessage alloc]
        initWithIdentifier:@"identifier"
        content:@"I am so excited about SiriKit!"
        dateSent:[NSDate date]
        sender:[[INPerson alloc] initWithPersonHandle:[[INPersonHandle alloc] initWithValue:@"sarah@example.com" type:INPersonHandleTypeEmailAddress] nameComponents:nil displayName:@"Sarah" image:nil contactIdentifier:nil customIdentifier:nil]
        recipients:@[[[INPerson alloc] initWithPersonHandle:[[INPersonHandle alloc] initWithValue:@"+1-415-555-5555" type:INPersonHandleTypePhoneNumber] nameComponents:nil displayName:@"John" image:nil contactIdentifier:nil customIdentifier:nil]]
    ]];
    completion(response);
}

#pragma mark - INSetMessageAttributeIntentHandling

- (void)handleSetMessageAttribute:(INSetMessageAttributeIntent *)intent completion:(void (^)(INSetMessageAttributeIntentResponse *response))completion {
    // Implement your application logic to set the message attribute here.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSetMessageAttributeIntent class])];
    INSetMessageAttributeIntentResponse *response = [[INSetMessageAttributeIntentResponse alloc] initWithCode:INSetMessageAttributeIntentResponseCodeSuccess userActivity:userActivity];
    completion(response);
}



#pragma mark - INPlayMediaIntentHandling

- (void)resolveMediaItemsForPlayMedia:(INPlayMediaIntent *)intent withCompletion:(void (^)(NSArray<INPlayMediaMediaItemResolutionResult *> * _Nonnull))completion {
    
    NSLog(@"%@---%@---%@",@(__func__),@(__LINE__), intent.mediaSearch.mediaName);
    
    NSString *title = nil;
    if (intent.mediaSearch) {
        title = intent.mediaSearch.mediaName;
    }

    // 描述媒体类型
    INMediaItem *item = [[INMediaItem alloc] initWithIdentifier:nil title:title type:INMediaItemTypeNews artwork:nil];
 
    // 媒体项目类型的解析结果
    INMediaItemResolutionResult *mediaResult = [INMediaItemResolutionResult successWithResolvedMediaItem:item];
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    INPlayMediaMediaItemResolutionResult *playResult = [[INPlayMediaMediaItemResolutionResult alloc] initWithMediaItemResolutionResult:mediaResult];
    [mutableArray addObject:playResult];
    
    completion(mutableArray);
}


- (void)handlePlayMedia:(INPlayMediaIntent *)intent completion:(void (^)(INPlayMediaIntentResponse * _Nonnull))completion {
    
    
    NSLog(@"%@---%@",@(__func__),@(__LINE__));
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INPlayMediaIntent class])];
    INMediaItem *item = [intent.mediaItems firstObject];
    
    // 容错处理
    // 如果等于则是，是别错误则默认打开，某个要闻频道
    if (item.title.length > 0) {
        userActivity.userInfo = @{@"title":item.title,@"source":@"siri"};
    } else {
        userActivity.userInfo = @{@"title":@"真人播报",@"source":@"siri"};
    }
    
    // media intent的回应
    INPlayMediaIntentResponse *response = [[INPlayMediaIntentResponse alloc] initWithCode:INPlayMediaIntentResponseCodeContinueInApp userActivity:userActivity];
    completion(response);
}

@end
