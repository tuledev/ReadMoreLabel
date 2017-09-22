//
//  ReadMoreLabel.m
//  ReadMore
//
//  Created by anhtu on 9/21/17.
//  Copyright © 2017 anhtu. All rights reserved.
//

#import "ReadMoreLabel.h"

@interface ReadMoreLabel() {
  void(^_truncationTappedCallback)();
}

@property (nonatomic, strong) NSString * truncationToken;
@property (nonatomic, strong) NSString * fullText;
@property (nonatomic, strong) UIButton * readMoreBtn;

@end

@implementation ReadMoreLabel

- (void)setTruncationToken:(NSString *)token {
  _truncationToken = token;
}

- (void)listenTappedOnTruncationToken:(void(^)())callback {
  _truncationTappedCallback = callback;
}

- (void)updateLayoutAndText:(NSString *)text {
  _fullText = text;
  [self updateLayout];
}

- (void)updateLayout {
  if (self.numberOfLines <= 0) {
    [self expandAll];
    return;
  }
  
  if (self.superview) {
    NSString *  willDisplayString = @"";
    NSArray * words = [[self fullTextString] componentsSeparatedByString:@" "];
    for (NSString * word in words) {
      if ([self  checkStringIsFitInLabel:[NSString stringWithFormat:@"%@ %@%@",
                                          willDisplayString,
                                          word,
                                          [self truncationToken]]]) {
        willDisplayString = [NSString stringWithFormat:@"%@ %@",
                             willDisplayString,
                             word];
      }
      else {
        [self displayText:willDisplayString andTruncation:[self truncationToken]];
        [self displayMoreBtnFromLastWord:word andTruncation:[self truncationToken]];
        return;
      }
    }
    self.text = [self fullTextString];
  }
}

#pragma mark -

- (NSString *)truncationTokenString {
  if (_truncationToken == nil) {
    _truncationToken = @"... More";
  }
  return _truncationToken;
}

- (NSString *)fullTextString {
  if (_fullText == nil) {
    _fullText = self.text;
  }
  return _fullText;
}

- (void)expandAll {
    self.text = [self fullTextString];
  if (_readMoreBtn) {
    [_readMoreBtn setEnabled:NO];
  }
}

- (BOOL)checkStringIsFitInLabel:(NSString *)string {
  NSDictionary * attributes = @{NSFontAttributeName: self.font};
  CGRect rectText = [string boundingRectWithSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes
                                         context:nil];
  if (rectText.size.height <= self.font.lineHeight * self.numberOfLines) {
    return YES;
  }
  return NO;
}

- (void)displayText:(NSString *)text andTruncation:(NSString *)truncation {
  self.text = @"";
  NSString * displayText = [NSString stringWithFormat:@"%@%@", text, truncation];
  NSMutableAttributedString * att = [[NSMutableAttributedString alloc] initWithString:displayText];
  [att addAttribute:NSForegroundColorAttributeName
              value:[[UIColor blueColor] colorWithAlphaComponent:0.7]
              range:NSMakeRange(displayText.length-truncation.length, truncation.length)];
  self.attributedText = att;
}

- (void)displayMoreBtnFromLastWord:(NSString *)word andTruncation:(NSString *)truncation {
  if (_readMoreBtn == nil) {
    UIButton * btn = [self createMoreBtn];
    btn.frame = [self btnMoreFrameFromLastWord:word andTruncation:truncation];
    [self.superview addSubview:btn];
    _readMoreBtn = btn;
  }
  else {
    _readMoreBtn.frame = [self btnMoreFrameFromLastWord:word andTruncation:truncation];
  }
}

- (UIButton *)createMoreBtn {
  UIButton * btn = [UIButton new];
//  btn.backgroundColor = [UIColor redColor];
//  btn.alpha = 0.5;
  [btn addTarget:self action:@selector(tappedLink) forControlEvents:UIControlEventTouchUpInside];
  return btn;
}

- (CGRect)btnMoreFrameFromLastWord:(NSString *)word andTruncation:(NSString *)truncation {
  CGSize sizeTruncation = [truncation sizeWithAttributes:@{NSFontAttributeName: self.font}];
  CGFloat lenghtOfLastWord = [word sizeWithAttributes:@{NSFontAttributeName: self.font}].width;
  if ([word containsString:@"\n"]) {
    lenghtOfLastWord = self.frame.size.width;
  }
  
  /// 16, 8: expand tapable area for ez touching
  return CGRectMake(self.frame.origin.x + self.frame.size.width - sizeTruncation.width - lenghtOfLastWord - 4,
                    self.frame.origin.y + self.frame.size.height- sizeTruncation.height - 8,
                    sizeTruncation.width + lenghtOfLastWord + 8,
                    sizeTruncation.height + 16);
}

- (void)tappedLink {
  if (_truncationTappedCallback) {
    _truncationTappedCallback();
  }
}


@end
