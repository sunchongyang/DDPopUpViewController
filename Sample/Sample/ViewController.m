//
//  ViewController.m
//  Sample
//
//  Created by Sun chongyang on 14-11-4.
//
//

#import "ViewController.h"
#import "UIViewController+DDPopUpViewController.h"
#import "TestViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_optionsListView;
    NSArray *_options;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _options = @[@"show in center with fade animation",
                 @"show in center without animation",
                 @"show in center with slide animation",
                 @"show in center with offset",
                 @"show in left with slide left to right animation",
                 @"show in right with slide right to left animation",
                 ];
    
    _optionsListView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _optionsListView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _optionsListView.delegate = self;
    _optionsListView.dataSource = self;
    [self.view addSubview:_optionsListView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)showPopUpViewControllerWithPosition:(DDPopUpPosition)popupPositon size:(CGSize)size offset:(CGPoint)offset animationType:(DDPopUpAnimationType)animationType
{
    TestViewController *testVc = [[TestViewController alloc] initWithNibName:nil bundle:nil];
    testVc.popUpPosition = popupPositon;
    testVc.popUpViewSize = size;
    testVc.popUpOffset = offset;
    
    [self showPopUpViewController:testVc animationType:animationType dismissWhenTouchBackground:YES];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger index = indexPath.row;
    switch (index) {
        case 0:
            [self showPopUpViewControllerWithPosition:DDPopUpPositionCenter size:CGSizeMake(300, 300) offset:CGPointZero animationType:DDPopUpAnimationTypeFade];
            break;
        case 1:
            [self showPopUpViewControllerWithPosition:DDPopUpPositionCenter size:CGSizeMake(300, 300) offset:CGPointZero animationType:DDPopUpAnimationTypeNone];
            break;
        case 2:
            [self showPopUpViewControllerWithPosition:DDPopUpPositionCenter size:CGSizeMake(300, 300) offset:CGPointZero animationType:DDPopUpAnimationTypeSlideVertical];
            break;
        case 3:
            [self showPopUpViewControllerWithPosition:DDPopUpPositionCenter size:CGSizeMake(300, 200) offset:CGPointMake(0, -100) animationType:DDPopUpAnimationTypeFade];
            break;
        case 4:
            [self showPopUpViewControllerWithPosition:DDPopUpPositionLeft size:CGSizeMake(250, CGRectGetHeight(self.view.bounds)) offset:CGPointZero animationType:DDPopUpAnimationTypeSlideLTR];
            break;
        case 5:
            [self showPopUpViewControllerWithPosition:DDPopUpPositionRight size:CGSizeMake(250, CGRectGetHeight(self.view.bounds)) offset:CGPointZero animationType:DDPopUpAnimationTypeSlideRTL];
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [cell.textLabel setText:[_options objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
