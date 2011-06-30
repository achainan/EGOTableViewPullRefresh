//
//  SRLoadingTableViewController.m
//  sonar
//
//  Created by Ajay Chainani on 4/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ACLoadingTableViewController.h"


@implementation ACLoadingTableViewController

@synthesize reloading=_reloading;

@synthesize initalLoad=_initalLoad;

- (void) viewDidLoad {
  [super viewDidLoad];
  
  
	if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
        view.backgroundColor = [UIColor blackColor];
        view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
    
    _reloading = NO;
    
    _initalLoad = YES;
    
}

- (void)loadData {
  
  if(_initalLoad) {
    [self animatePull];
  }
}

- (void)animatePull
{
  
  if (!_reloading) {
    
    _initalLoad = NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    self.tableView.contentOffset = CGPointMake(0,-66);
    [UIView commitAnimations];
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:self.tableView];
  }
}

- (void)reloadTableViewDataSource{
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
  
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  
  _refreshHeaderView = nil;
  
	[super viewDidUnload];
}

- (void)dealloc {
  
	_refreshHeaderView = nil;
  
  [super dealloc];
}

@end

