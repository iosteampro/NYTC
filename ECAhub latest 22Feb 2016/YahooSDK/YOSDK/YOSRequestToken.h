//
//  YOSRequestToken.h
//  YOSSocial
//
//  Created by Zach Graves on 2/14/09.
//  Updated by Michael Ho on 8/21/14.
//  Copyright 2014 Yahoo Inc.
//  
//  The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license.
//

#import "YOAuthToken.h"

/**
 * YOSRequestToken is a sub-class of YOAuthToken that contains the request token key and secret, along 
 * with extensions for the request_auth URL and token expiration dates.
 */
@interface YOSRequestToken : YOAuthToken

/**
 * Returns the URL generated by the service-provider to redirect the user to allow access to the application.
 */
@property (nonatomic, readwrite, strong) NSString *requestAuthUrl;
/**
 * Returns an integer of the UNIX time that the token will expire.
 */
@property (nonatomic, readwrite) NSInteger tokenExpires;
/**
 * Returns a NSDate representing the expiry date of this token.
 */
@property (nonatomic, readwrite, strong) NSDate *tokenExpiresDate;
/**
 * Returns a Boolean indicating whether the callback was received by the service provider.
 */
@property (nonatomic, readwrite) BOOL callbackConfirmed;
/**
 * Return the verifier token from user authorization.
 */
@property (nonatomic, strong) NSString *verifier;

/**
 * Returns a new request token for the specified response data object.
 * @param responseData		A NSData object containing the response from the service provider.
 * @return					The initialized request token.
 */
+ (instancetype)tokenFromResponse:(NSData *)responseData;

/**
 * Returns a new request token for the specified dictionary.
 * @param tokenDictionary	A dictionary object containing the request token data.
 * @return					The initialized request token.
 */
+ (instancetype)tokenFromStoredDictionary:(NSDictionary *)tokenDictionary;

/**
 * Creates a mutable dictionary containing the token data. 
 * @return					A dictionary containing request token variables. 
 */
- (NSMutableDictionary *)tokenAsDictionary;

/**
 * Returns true if the token has expired.
 */
- (BOOL)tokenHasExpired;

@end
