/// 屏蔽网易新闻头条频道的广告

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

%hook NTESFeedListAdLargeImageCellModel

- (void)calculateCellHeight {

}


/// 需要添加到数组，导致崩溃，放弃
// - (id)initWithIdentifierForSection:(id)arg1 adInfo:(id)arg2 configModel:(id)arg3
// {
// 	return nil;
// }

%end


%hook NTESFeedListAdThreeImageCellModel

- (void)calculateCellHeight {

}

%end

// 对行高进行清空操作
%hook NTESFeedListAdSingleImageCellModel


- (void)calculateCellHeight {

}

%end


// 未知方法的声明
// @interface NTESTableViewAdapter

// -(id)sectionModelList;

// @end


/// 对数据源进行剔除操作
// %hook NTESTableViewAdapter

// - (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2
// {

// 	NSMutableArray *modelList = [NSMutableArray arrayWithArray:[self sectionModelList]];;
// 	NSMutableArray *tempAdModelList = [NSMutableArray array];

// 	for (id model in modelList) {
// 		if([model isKindOfClass:%c(NTESFeedListAdLargeImageCellModel)]) {
// 			[tempAdModelList addObject:model];
// 		}
// 	}

// 	[modelList removeObjectsInArray:tempAdModelList];

// 	return %orig;
// }

// %end


/// 对模型进行赋值的清空操作
// %hook SSComentListView

// - (void)setDetailTipModel:(id)arg {


// }

// %end


// 世界杯频道右侧易起竞猜的浮动icon
%hook NTESNBFloatAdsView


- (id)initWithFrame:(struct CGRect)arg1 {
	return nil;
}

%end


// 频道顶部右上角的小红点图标
%hook NTESNBChannelSlideViewCell

- (UIImageView *)spot {
	return nil;
}

%end


// 去除控制器中的view
%hook NHHomeMixViewController

- (void)viewWillAppear:(_Bool)arg1 
{
	%orig;
	// 添加之后，显示之前进行移除操作
	[[self refreshView] removeFromSuperview];
	[self setRefreshView:nil];

}

%end




