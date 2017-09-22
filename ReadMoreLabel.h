//
//  ReadMoreLabel.h
//  ReadMore
//
//  Created by anhtu on 9/21/17.
//  Copyright © 2017 anhtu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadMoreLabel : UILabel

- (void)setTruncationToken:(NSString *)token;
- (void)listenTappedOnTruncationToken:(void(^)())callback;

- (void)updateLayout;
- (void)updateLayoutAndText:(NSString *)text;

@end
