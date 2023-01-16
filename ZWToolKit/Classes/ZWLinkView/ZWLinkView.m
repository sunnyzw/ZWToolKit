//
//  ZWLinkView.m
//  Sunny
//
//  Created by Sunny on 2022/7/1.
//  Copyright © 2022 Sunny. All rights reserved.
//

#import "ZWLinkView.h"
#import "NSString+Category.h"

@interface ZWLinkView () <UITextViewDelegate>

@end

@implementation ZWLinkView

- (instancetype)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.delegate = self;
    self.backgroundColor = nil;
    self.editable = false;
    self.scrollEnabled = false;
    self.textContainerInset = UIEdgeInsetsZero;
    self.textContainer.lineFragmentPadding = 0;
}

- (void)setLinkColor:(UIColor *)linkColor {
    self.linkTextAttributes = @{NSForegroundColorAttributeName:linkColor};
}

- (void)setLinks:(NSArray<NSDictionary *> *)links {
    NSMutableAttributedString *result;
    if (self.attributedText) {
        result = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    } else {
        result = [NSString getAttributedString:@[@{@"string":self.text,
                                                   @"color":self.textColor,
                                                   @"font":self.font}]
                                         style:@{@"lineSpace":@4,
                                                 @"paragraphSpace":@8}];
    }
    for (NSDictionary *link in links) {
        NSRange range = [self.text rangeOfString:link[@"title"]];
        [result addAttributes:@{NSLinkAttributeName:link[@"absolute"]} range:range];
        if ([link[@"underline"] boolValue]) {
            [result addAttributes:@{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle)} range:range];
        }
    }
    self.attributedText = result;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    if (self.didClickedBlock) {
        self.didClickedBlock(URL.absoluteString);
    }
    return false;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return false;
}

@end
