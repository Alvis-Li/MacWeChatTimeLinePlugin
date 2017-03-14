//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "MMChatLogBaseCellView.h"

@class MMTextView, NSImageView;

@interface MMChatLogVoiceCellView : MMChatLogBaseCellView
{
    MMTextView *_titleTxtView;
    MMTextView *_timeTxtView;
    NSImageView *_voiceIconImageView;
}

+ (double)cellHeightWithFavItemDataField:(id)arg1 parentMessage:(id)arg2 parentFavItem:(id)arg3 constrainedToWidth:(double)arg4;
@property(retain, nonatomic) NSImageView *voiceIconImageView; // @synthesize voiceIconImageView=_voiceIconImageView;
@property(retain, nonatomic) MMTextView *timeTxtView; // @synthesize timeTxtView=_timeTxtView;
@property(retain, nonatomic) MMTextView *titleTxtView; // @synthesize titleTxtView=_titleTxtView;
- (void).cxx_destruct;
- (id)initWithFrame:(struct CGRect)arg1;

@end
