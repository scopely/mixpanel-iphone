#import "MPSurveyQuestion.h"

@interface MPSurveyQuestion ()

@property(nonatomic) NSUInteger ID;
@property(nonatomic,retain) NSString *prompt;
@property(nonatomic) MPSurveyQuestionType type;
@property(nonatomic,retain) NSDictionary *extraData;

- (id)initWithID:(NSUInteger *)ID prompt:(NSString *)prompt type:(MPSurveyQuestionType)type andExtraData:(NSDictionary *)extraData;

@end

@implementation MPSurveyQuestion

+ (MPSurveyQuestion *)questionWithJSONObject:(NSDictionary *)object
{
    if (object == nil) {
        NSLog(@"question json object should not be nil");
        return nil;
    }
    NSNumber *ID = object[@"id"];
    if (!([ID isKindOfClass:[NSNumber class]] && [ID integerValue] > 0)) {
        NSLog(@"invalid question id: %@", ID);
        return nil;
    }
    NSString *prompt = object[@"prompt"];
    if (![prompt isKindOfClass:[NSString class]]) {
        NSLog(@"invalid question prompt: %@", prompt);
        return nil;
    }
    NSString *type = object[@"type"];
    if (![type isKindOfClass:[NSString class]]) {
        NSLog(@"invalid question type: %@", type);
        return nil;
    }
    MPSurveyQuestionType enumType;
    if ([type isEqualToString:@"multiple_choice"]) {
        enumType = MPSurveyQuestionTypeMultipleChoice;
    } else if ([type isEqualToString:@"text"]) {
        enumType = MPSurveyQuestionTypeText;
    } else {
        NSLog(@"unknown question type: %@", type);
        return nil;
    }
    NSDictionary *extraData = object[@"extra_data"];
    if (![extraData isKindOfClass:[NSDictionary class]]) {
        NSLog(@"invalid question extra data: %@", extraData);
        return nil;
    }
    return [[[MPSurveyQuestion alloc] initWithID:[ID integerValue] prompt:prompt type:enumType andExtraData:extraData] autorelease];
}

- (id)initWithID:(NSUInteger *)ID prompt:(NSString *)prompt type:(MPSurveyQuestionType)type andExtraData:(NSDictionary *)extraData
{
    if (prompt == nil || prompt.length == 0) {
        NSLog(@"invalid question prompt: %@", prompt);
        return nil;
    }
    if (type != MPSurveyQuestionTypeMultipleChoice && type != MPSurveyQuestionTypeText) {
        NSLog(@"unknown question type: %d", type);
        return nil;
    }
    if (extraData == nil) {
        NSLog(@"invalid question extra data: %@", extraData);
        return nil;
    }
    if (self = [super init]) {
        _ID = ID;
        _type = type;
        self.prompt = prompt;
        self.extraData = extraData;
    }
    return self;
}

- (void)dealloc
{
    _ID = nil;
    _type = nil;
    self.prompt = nil;
    self.extraData = nil;
    [super dealloc];
}

@end
