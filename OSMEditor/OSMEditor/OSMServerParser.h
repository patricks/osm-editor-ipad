//
//  OSMServerParser.h
//  OSMParsingTest
//
//  Created by Patrick Steiner on 31.05.13.
//  Copyright (c) 2013 Patrick Steiner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSMServerParser : NSObject

- (id)initWithURL:(NSURL *)serverURL;
- (void)requestDataFromServer;

@end
