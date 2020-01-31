//
//  Movie.m
//  mySimpleMovieSearchObjC
//
//  Created by Uzo on 1/31/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithTitle:(NSString *)title rating:(NSInteger)rating overview:(NSString *)overview posterpath:(NSString *)posterpath
{
    self = [super init];
    
    if (self) {
        _title = title;
        _rating = rating;
        _overview = overview;
        _posterpath = posterpath;
    }
    
    return self;
}

@end

@implementation Movie (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    // given dict containing key/values that I want to use to create a movie
    NSString *title = dictionary[@"title"];
    NSInteger rating = [dictionary[@"vote_average"] intValue];
    NSString *overview = dictionary[@"overview"];
    NSString *posterpath = dictionary[@"poster_path"];
    
    return [self initWithTitle:title rating:rating overview:overview posterpath:posterpath];
}

@end
