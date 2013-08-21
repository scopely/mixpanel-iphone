#import "MPSurveyQuestionViewController.h"

@interface MPSurveyQuestionViewController ()

@property(nonatomic,retain) MPSurveyQuestion *question;
@end

@implementation MPSurveyQuestionViewController

- (id)initWithQuestion:(MPSurveyQuestion *)question
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.question = question;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)dealloc
{
    self.question = nil;
    [super dealloc];
}

@end
