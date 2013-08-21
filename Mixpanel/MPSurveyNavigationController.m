#import "MPSurvey.h"
#import "MPSurveyNavigationController.h"
#import "MPSurveyQuestionViewController.h"

@interface MPSurveyNavigationController ()

@property(nonatomic,retain) MPSurvey *survey;
@property(nonatomic,retain) NSMutableArray *viewControllers;
@property(nonatomic,retain) UIButton *nextButton;
@property(nonatomic,retain) UIButton *previousButton;
@property(nonatomic,retain) UILabel *pageNumber;

@end

@implementation MPSurveyNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewControllers = [NSMutableArray array];
    for (NSUInteger i = 0; i < self.survey.questions.count; i++) {
		[self.viewControllers addObject:[NSNull null]];
    }
    [self loadQuestion:0];
    [self loadQuestion:1]; // preload next
}

- (void)loadQuestion:(NSUInteger)num
{
    if (num < self.survey.questions.count) {
        // replace the placeholder if necessary
        MPSurveyQuestionViewController *controller = self.viewControllers[num];
        if ((NSNull *)controller == [NSNull null]) {
            self.viewControllers[num] = [[MPSurveyQuestionViewController alloc] initWithQuestion:self.survey.questions[num]];
        }
    }
}

- (void)sendAnswer:(NSDictionary *)record andPresentNextQuestion:(BOOL)proceed
{

}

- (void)presentQuestion:(NSUInteger)index
{
    [self loadQuestion:index];
    MPSurveyQuestionViewController *controller;
    if (index > 0) {
        controller = self.viewControllers[index - 1];
        [controller willMoveToParentViewController:nil];
        [controller.view removeFromSuperview];
        [controller removeFromParentViewController];
    }
    if (index < self.survey.questions.count) {
        controller = self.viewControllers[index];
        controller.view.frame = self.view.frame;
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        [controller didMoveToParentViewController:self];
    }
    [self loadQuestion:index + 1]; // preload next
}

- (void)presentNextQuestion:(id)sender
{
}

- (void)presentPreviousQuestion:(id)sender
{

}

- (void)dismiss
{

}

@end
