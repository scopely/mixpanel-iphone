#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MPSurveyQuestionType) {
    MPSurveyQuestionTypeMultipleChoice,
    MPSurveyQuestionTypeText,
};

@interface MPSurveyQuestion : NSObject

@property(nonatomic,readonly) NSUInteger ID;
@property(nonatomic,readonly,retain) NSString *prompt;
@property(nonatomic,readonly) MPSurveyQuestionType type;
@property(nonatomic,readonly,retain) NSDictionary *extraData;

+ (MPSurveyQuestion *)questionWithJSONObject:(NSObject *)object;

@end
