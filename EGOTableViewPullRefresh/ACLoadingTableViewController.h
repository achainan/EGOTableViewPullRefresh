//
//  SRLoadingTableViewController.h
//  sonar
//
//  Created by Ajay Chainani on 4/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@class EGORefreshTableHeaderView;

@interface ACLoadingTableViewController : UITableViewController <EGORefreshTableHeaderDelegate> {

  EGORefreshTableHeaderView *_refreshHeaderView;
  BOOL _reloading;
  BOOL _initalLoad;  

}

- (void)animatePull;
- (void)loadData;
- (void)doneLoadingTableViewData;
- (void)reloadTableViewDataSource;

@property(assign,getter=isReloading) BOOL reloading;
@property(assign,getter=isinitalLoad) BOOL initalLoad;

@end
