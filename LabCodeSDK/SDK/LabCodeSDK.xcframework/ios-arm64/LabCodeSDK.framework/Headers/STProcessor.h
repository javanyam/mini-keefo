#ifndef STProcessor_h
#define STProcessor_h

#ifdef __cplusplus

#include "Preprocessor.h"
#include "GeometricTransform.h"
#include "Config.h"
#include "RandomNumberGenerator.h"
#include "LabelReader.h"
#include "Embedder.h"
#include "Utils.hpp"
#include "stdafx.h"
#endif

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>




@interface STFrameDetector : NSObject

- (NSString *)detect:(CGImageRef)frame seed:(int)seed;
- (NSString *)weverse:(CGImageRef)frame;
- (NSString *)kumon:(CGImageRef)frame;

@end

@interface STImageEmbedder : NSObject

- (UIImage *)embed:(CGImageRef)image
                seed:(int)seed
                codeArray:(NSArray*) codeArray
                scale:(int)scale
                alpha:(int)alpha
                embVersionStr:(NSString*)embVersionStr
                channelStr:(NSString*)channelStr
                resize:(float)resize
                orientation:(UIImageOrientation)orientation;


@end

@interface STUtils : NSObject

#ifdef __cplusplus

- (void)CGImageToMat:(CGImageRef)image mat:(cv::Mat&)mat;
- (UIImage *)UIImageFromCVMatWithOrientation:(cv::Mat)cvMat orientation:(UIImageOrientation)orientation;

#endif

@end

@interface STImageDetector : NSObject

- (NSString *)detect:(CGImageRef)image seed:(int)seed;

@end

#endif /* STProcessor_h */
