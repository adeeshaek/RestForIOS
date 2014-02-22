//
//  RestForIOS.m
//  RestForIOS
//
//  Created by Adeesha on 2/4/14.
//  Copyright (c) 2014, Adeesha Ekanayake, Distributed under MIT License.
//

#import "RestForIOS.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation RestForIOS

#pragma mark lower level methods
+(NSString*)postJSONWithData:(NSDictionary *)dataDict andURL:(NSString *)url andCallback:(void (^)(void))errorCallback
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:dataDict options:0 error:&error];
    
    NSString *postString = [[NSString alloc]initWithData:postData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", postString);
    
    [request setHTTPBody:postData];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPMethod:@"POST"];
    
    NSError *error2;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error2];
    
    NSString* response;
    
    if([responseCode statusCode] != 200){
        //if you need to use a callback method here, use the getHTTPDataWithCallback method
        NSLog(@"Error with JSON request"); //call the error handler
        errorCallback();
        
        return nil;
    }
    else{
        NSString* output = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
        response = output;
    }
    
    return response;
}


+(NSString*)postHTTPDataWithUrl:(NSString *)url andParameters:(NSDictionary *)parameters andCallback:(void (^)(void))errorCallback
{
    NSString* response;
    
    //create the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    
    //create the request body
    NSMutableData *body = [[NSMutableData alloc] init];
    
    //add data to the request body
    NSArray* keys = [parameters allKeys];
    NSArray* values = [parameters allValues];
    
    for (int i=0; i<keys.count; i++)
    {
        
        //only prepend the & operator if you are adding a new param
        if (i == 0)
        {
            [body appendData:[[NSString stringWithFormat:@"%@=%@", [keys objectAtIndex:i], [values objectAtIndex:i]]dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        else
        {
            [body appendData:[[NSString stringWithFormat:@"&%@=%@", [keys objectAtIndex:i], [values objectAtIndex:i]]dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        
    }
    
    //execute the request
    [request setHTTPBody:body];
    [request setURL:[NSURL URLWithString:url]];
    
    //test code
    NSString* logString = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    NSLog(@"%@",logString);
    
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        //if you need to use a callback method here, use the getHTTPDataWithCallback method
        NSLog(@"Error with JSON request"); //call the error handler
        errorCallback();
        
        return nil;
    }
    else{
        NSString* output = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
        response = output;
    }
    
    return response;
}

+(NSString*)getHTTPDataWithUrl:(NSString *)url andParameters:(NSDictionary *)parameters andCallback:(void (^)(void))errorCallback
{
    NSString* paramString = [RestForIOS parseParamsWithDictionary:parameters];
    
    //create url string
    NSString* urlStringWithParams = [[NSString alloc]initWithFormat:@"%@?%@", url, paramString];
    
    NSLog(@"urlstring: %@", urlStringWithParams);
    
    //perform request
    return [RestForIOS getHTTPDataWithUrl:urlStringWithParams andCallback:errorCallback];
}

+(NSString*)getHTTPDataWithUrl:(NSString*)url andCallback:(void (^)(void))errorCallback
{
    NSString* theData;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        //NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        
        errorCallback(); //call the error handler
        
        return nil;
    }
    else{
        NSString* output = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
        theData = output;
    }
    
    return theData;
}

+(NSDictionary*)parseJSONToDict:(NSString *)dataString
{
    NSError *error;
    NSDictionary* output;
    if (dataString != nil)
    {
         output = [NSJSONSerialization JSONObjectWithData:[dataString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    }
    
    else
    {
        output = nil;
    }

    return output;
}

+(NSArray*)parseJSONToArray:(NSString *)dataString
{
    NSError *error;
    NSArray* output;
    
    if (dataString != nil)
    {
        output = [NSJSONSerialization JSONObjectWithData:[dataString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    }
    
    else
    {
        output = nil;
    }
    

    return output;
}

+(NSString*)convertToSHA512:(NSString *)source
{
    const char *cstr = [source cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:source.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, data.length, digest);
    NSMutableString* output = [NSMutableString  stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return [output uppercaseString];
}

+(NSString*)parseParamsWithDictionary:(NSDictionary *)dictionary
{
    NSString* outputString = [[NSString alloc] init];
    NSString* tempString;
    for (id key in dictionary)
    {
        tempString = [[NSString alloc] initWithFormat:@"&%@=%@", key, [dictionary objectForKey:key]];
        
        outputString = [outputString stringByAppendingString:tempString];
    }
    
    //used to remove the first character.
    return [outputString substringFromIndex:1];
}


@end
