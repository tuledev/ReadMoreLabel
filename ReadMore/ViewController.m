//
//  ViewController.m
//  ReadMore
//
//  Created by anhtu on 9/21/17.
//  Copyright © 2017 anhtu. All rights reserved.
//

#import "ViewController.h"
#import "ReadMoreLabel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ReadMoreLabel *lbContent;
@property (weak, nonatomic) IBOutlet ReadMoreLabel *lbContent2;
@property (weak, nonatomic) IBOutlet ReadMoreLabel *lbContent3;
@property (weak, nonatomic) IBOutlet ReadMoreLabel *lbContent4;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [_lbContent setTruncationToken:@"... Read More"];
  _lbContent.text = @"A wiki is run using wiki software, otherwise known as a wiki engine. A wiki engine is a type of content management system, but it differs from most other such systems, including blog software, in that the content is created without any defined owner or leader, and wikis have little implicit structure, allowing structure to emerge according to the needs of the users.";
  _lbContent.numberOfLines = 3;
  
  [_lbContent2 setTruncationToken:@"... Read Full Here"];
  [_lbContent3 setTruncationToken:@"... More"];
  [_lbContent4 setTruncationToken:@"... Learn More"];
  
  [self setupListeners];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [_lbContent updateLayout];
  [_lbContent2 updateLayout];
  [_lbContent3 updateLayout];
  [_lbContent4 updateLayout];
}

- (void)setupListeners {
  __weak typeof(_lbContent) weakLbContent = _lbContent;
  [_lbContent listenTappedOnTruncationToken:^{
    if (weakLbContent) {
      weakLbContent.numberOfLines +=1;
      [weakLbContent updateLayout];
    }
  }];
}

@end
