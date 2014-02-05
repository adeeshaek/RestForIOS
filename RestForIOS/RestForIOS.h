//
//  RestForIOS.h
//  RestForIOS
//
//  Created by Adeesha on 2/4/14.
//  Copyright (c) 2014, Adeesha Ekanayake, Distributed under MIT License.
//

#import <Foundation/Foundation.h>

/**
 *	@brief	extend this class to use the framework
 *
 *	@author	Adeesha Ekanayake
 *
 *	@date	2014-02-04
 */
@interface RestForIOS : NSObject

#pragma mark-
#pragma mark POST methods

/**
 *	@brief	POSTS the provided JSON with the given data
 *
 *	@param 	dataDict 	dictionary with key/value pairs to be converted to JSON
 *	@param 	url 	target URL
 *
 *	@return	response from server
 *
 *	@author	Adeesha Ekanayake
 *
 *	@date	2014-02-05
 */
+(NSString*)postJSONWithData:(NSDictionary *)dataDict andURL:(NSString *)url andCallback:(void (^)(void))errorCallback;

/**
 *	@brief	POSTS the provided JSON with the given data, and calls the given callback on error
 *
 *	@param 	url 	target URL
 *	@param 	parameters 	dictionary with key/value pairs to be converted to JSON
 *  @errorCallback  callback method invoked on error with call
 *
 *	@return	response from server
 *
 *	@author	Adeesha Ekanayake
 *
 *	@date	2014-02-05
 */
+(NSString*)postHTTPDataWithUrl:(NSString *)url andParameters:(NSDictionary *)parameters andCallback:(void (^)(void))errorCallback;

#pragma mark-
#pragma mark GET methods

/**
 *	@brief	GETS the given url with the specified parameters
 *
 *	@param 	url 	target URL
 *	@param 	parameters 	dictionary of parameters to be converted to URL parameters
 *  @param  errorCallback callback method invoked on error with call
 *
 *	@return	response from server, in string form
 *
 *	@author	Adeesha Ekanayake
 *
 *	@date	2014-02-05
 */
+(NSString*)getHTTPDataWithUrl:(NSString *)url andParameters:(NSDictionary *)parameters andCallback:(void (^)(void))errorCallback;

/**
 *	@brief	GETS the given url with the specified paramters
 *
 *	@param 	url 	target URL
 *  @param  errorCallback   callback method invoked on error with call
 *
 *	@return response from server, in string form
 *
 *	@author	Adeesha Ekanayake
 *
 *	@date	2014-02-05
 */
+(NSString*)getHTTPDataWithUrl:(NSString*)url andCallback:(void (^)(void))errorCallback;

#pragma mark-
#pragma mark JSON parsing methods

/**
 *	@brief	parses JSON dict to NSDictionary
 *
 *	@param 	dataString 	string to convert to NSDictionary
 *
 *	@return	NSDictionary from string
 *
 *	@author	Adeesha Ekanayake
 *
 *	@date	2014-02-05
 */
+(NSDictionary*)parseJSONToDict:(NSString *)dataString;

/**
 *	@brief	parses JSON dict to NSArray
 *
 *	@param 	dataString 	string to convert to NSArray
 *
 *	@return	NSArray from string
 *
 *	@author	Adeesha Ekanayake
 *
 *	@date	2014-02-05
 */
+(NSArray*)parseJSONToArray:(NSString *)dataString;

#pragma mark-
#pragma mark crypto related methods

/**
 *	@brief	hashes provided string in SHA512
 *
 *	@param 	source 	string to hash
 *
 *	@return	hashed string
 *
 *	@author	Adeesha Ekanayake
 *
 *	@date	2014-02-05
 */
+(NSString*)convertToSHA512:(NSString *)source;

@end
