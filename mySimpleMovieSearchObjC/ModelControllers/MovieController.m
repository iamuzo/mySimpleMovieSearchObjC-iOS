//
//  MovieController.m
//  mySimpleMovieSearchObjC
//
//  Created by Uzo on 1/31/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import "MovieController.h"
#import "Movie.h"

@implementation MovieController

// MARK: - Properties
static NSString *const baseString = @"https://api.themoviedb.org";
static NSString *const moviePathString = @"/3/search/movie";

static NSString *const fetchImageBaseString = @"https://image.tmdb.org";
static NSString *const tPathComponent = @"t";
static NSString *const pPathComponent = @"p";
static NSString *const sizePathComponent = @"w200";

+ (NSString *)retrieveAPIKey
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AuthKeys" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *apiKey = [[NSString alloc] init];
    apiKey = dict[@"movieDB"];
    return apiKey;
}

+ (void)searchForMovieUsingSearchTerm:(NSString *)searchTerm
                           completion:(void (^)(NSArray<Movie *> * _Nonnull))completion
{
    NSURL *url = [NSURL URLWithString:baseString];
    NSURL *moviePathURL = [url URLByAppendingPathComponent:moviePathString];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"api_key" value:[self retrieveAPIKey]];
    [queryItems addObject:apiKeyQuery];
    
    NSURLQueryItem *searchTermKeyQuery = [[NSURLQueryItem alloc] initWithName:@"query" value:searchTerm];
    [queryItems addObject:searchTermKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:moviePathURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    NSLog(@"this is the url for searching for a movie: %@", finalURL);
    
    [[[NSURLSession sharedSession]
      dataTaskWithURL:finalURL
      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching movies from the server: %@", error);
            //completion(nil);
            completion([NSArray new]);
            return;
        }
        
        if (!data) {
            NSLog(@"Error fetching any movie using the supplied search term: %@", error);
            completion([NSArray new]);
            return;
        }
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSLog(@"%@", topLevelDictionary);
        
        if (!topLevelDictionary || ![topLevelDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error with topLevelDictionary: %@", error);
            completion([NSArray new]);
            return;
        }
        
        NSArray *resultsArray = topLevelDictionary[@"results"];
        
        //we need to return an array of Movie Objects
        NSMutableArray *arrayOfMovies = [NSMutableArray array];
        
        for (NSDictionary *movieDictionary in resultsArray) {
            
            //use the key/values in movieDictionary to create a movie obj
            Movie *movie = [[Movie alloc] initWithDictionary:movieDictionary];
            //add the created movie to arrayOfMovies
            [arrayOfMovies addObject:movie];
        }
        //complete with the arrayOfMovies
        completion(arrayOfMovies);
    }] resume];
}

+ (void)getImageFor:(Movie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *url = [NSURL URLWithString:fetchImageBaseString];
    NSURL *tPathURL = [url URLByAppendingPathComponent:tPathComponent];
    NSURL *pPathURL = [tPathURL URLByAppendingPathComponent:pPathComponent];
    NSURL *sizePathURL = [pPathURL URLByAppendingPathComponent:sizePathComponent];
    NSURL *posterPathURL = [sizePathURL URLByAppendingPathComponent:movie.posterpath];
    NSLog(@"this is the url for searching for a movie: %@", posterPathURL);

    
    [[[NSURLSession sharedSession]
      dataTaskWithURL:posterPathURL
      completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //handle error
        if (error) {
            NSLog(@"Error fetching movie poster from server: %@", error);
            completion(nil);
            return;
        }
        
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            return completion(image);
        } else {
            UIImage *image = [UIImage systemImageNamed:@"rays"];
            return completion(image);
        }
        
    }] resume];
    
}

@end
