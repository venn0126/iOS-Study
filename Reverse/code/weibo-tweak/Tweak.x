#import <UIKit/UIkit.h>


/// 前置声明

@interface WBS3CollectionViewManager

@property(nonatomic) __weak id context;

@end


@interface WBS3CategoryDummyGroupModel

@property(retain, nonatomic) NSMutableDictionary *extraProperties;
@property(retain, nonatomic) NSArray *subItems;

@end


@interface WBS3DataSource

@property(readonly, nonatomic) NSMutableArray *datas;

@end


@interface WBS3BaseContext

@property(readonly, nonatomic) id dataSource;

@end



@interface WBStatus

- (id)statusRecordItem;

@property(nonatomic) long long adState; 

@end


@interface WBS3FeedCardData

@property(retain) WBStatus *timelineItem;


@end


@interface WBS3CategoryCellModel

@property(retain, nonatomic) WBS3FeedCardData *viewData;

@end




/// 勾子文件

%hook WBS3CollectionViewManager


- (id)collectionView:(id)arg1 cellForItemAtIndexPath:(id)arg2 {


	// UICollectionViewCell
	// 临时存放广告模型的数组
	NSMutableArray *tempAdModelList = [NSMutableArray array];

	 WBS3DataSource *dataSource = [[self context] dataSource];

	 // 总的模型数组
	 NSMutableArray *datas= [dataSource datas];

	// 获取到现有的模型数组
	for (id model in datas) {
		if([model isKindOfClass:%c(WBS3CategoryDummyGroupModel)]) {

			WBS3CategoryCellModel *cellModel = [[model subItems] firstObject];
			// if (![cellModel isKindOfClass:%c(WBS3CategoryCellModel)]) {
	 	// 		return %orig;
	 	// 	}
			WBS3FeedCardData *viewData = [cellModel viewData];
			// if (![viewData isKindOfClass:%c(WBS3FeedCardData)]) {
	 	// 		return %orig;
	 	// 	}
			WBStatus *timeline = [viewData timelineItem];
			// if (![timeline isKindOfClass:%c(WBStatus)]) {
	 	// 		return %orig;
	 	// 	}
			
			if (timeline.adState == 1) {
				[tempAdModelList addObject:model];

			 // NSLog(@"tian is %lld",[timeLine adState]);
			}
			
		}

	}

	NSLog(@"tian is %d",(int)tempAdModelList.count);
	[datas removeObjectsInArray:tempAdModelList];

	return %orig;
}


%end

