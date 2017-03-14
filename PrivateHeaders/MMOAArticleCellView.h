//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSTableCellView.h"

@class MMCTTextView, MMDivider, MMImageView, MMOAMessageItem;

@interface MMOAArticleCellView : NSTableCellView
{
    BOOL _selected;
    MMOAMessageItem *_messageItem;
    MMImageView *_thumbnailImageView;
    MMCTTextView *_titleTextView;
    MMDivider *_divider;
}

@property(retain, nonatomic) MMDivider *divider; // @synthesize divider=_divider;
@property(retain, nonatomic) MMCTTextView *titleTextView; // @synthesize titleTextView=_titleTextView;
@property(retain, nonatomic) MMImageView *thumbnailImageView; // @synthesize thumbnailImageView=_thumbnailImageView;
@property(retain, nonatomic) MMOAMessageItem *messageItem; // @synthesize messageItem=_messageItem;
@property(nonatomic) BOOL selected; // @synthesize selected=_selected;
- (void).cxx_destruct;
- (void)populateWithMessageItem:(id)arg1;
- (void)prepareForReuse;
- (void)dealloc;
- (id)initWithFrame:(struct CGRect)arg1;
- (void)drawRect:(struct CGRect)arg1;

@end
