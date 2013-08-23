#import "MPSurvey.h"
#import "MPSurveyQuestion.h"

@interface MPSurvey ()

@property (nonatomic) NSUInteger ID;
@property (nonatomic, retain) NSArray *questions;

- (id)initWithID:(NSUInteger *)ID andQuestions:(NSArray *)questions;

@end

@implementation MPSurvey

+ (MPSurvey *)surveyWithJSONObject:(NSDictionary *)object
{
    if (object == nil) {
        NSLog(@"survey json object should not be nil");
        return nil;
    }
    NSNumber *ID = object[@"id"];
    if (!([ID isKindOfClass:[NSNumber class]] && [ID integerValue] > 0)) {
        NSLog(@"invalid survey id: %@", ID);
        return nil;
    }
    NSMutableArray *questions = [NSMutableArray array];
    for (NSDictionary *question in object[@"questions"]) {
        MPSurveyQuestion *q = [MPSurveyQuestion questionWithJSONObject:question];
        if (q) {
            [questions addObject:q];
        }
    }
    return [[[MPSurvey alloc] initWithID:[ID integerValue] andQuestions:[NSArray arrayWithArray:questions]] autorelease];
}

- (id)initWithID:(NSUInteger *)ID andQuestions:(NSArray *)questions
{
    if (questions == nil || [questions count] == 0) {
        NSLog(@"survey has no questions: %@", questions);
        return nil;
    }
    if (self = [super init]) {
        _ID = ID;
        self.questions = questions;
    }
    return self;
}

- (void)dealloc
{
    _ID = nil;
    self.questions = nil;
    [super dealloc];
}

@end
