//
//  MovieController.h
//  mySimpleMovieSearchObjC
//
//  Created by Uzo on 1/31/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieController : NSObject

+(NSString *)retrieveAPIKey;

+(void)searchForMovieUsingSearchTerm:(NSString *)searchTerm completion:(void (^) (NSArray<Movie *> *movies, NSError * _Nullable error))completion;

+(void)getImageFor:(Movie *)movie completion:(void (^)(UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
