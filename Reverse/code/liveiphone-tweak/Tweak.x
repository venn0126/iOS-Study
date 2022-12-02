#import <Foundation/Foundation.h>



/// 去除腾讯视频的启动页面广告(未发现)






/// 去除打开视频的广告
%hook QADViewController

- (id)initWithControllerType:(long long)arg1 eventBus:(id)arg2 playAdInfo:(id)arg3
{

	return nil;
}


%end


/// 去除精选频道上的广告

@interface VBListSectionMap

- (NSMutableArray *)mObjects;

@end


@interface VBListAdapter

- (VBListSectionMap *)sectionMap;

@end


@interface QNBUADefautSingleBlockSectionModel

- (id)cellModels;

- (void)setCellModels:(id)arg1;

@end


%hook VBListAdapter

- (id)collectionView:(id)arg1 cellForItemAtIndexPath:(id)arg2
{
	VBListSectionMap *sectionMap = [self sectionMap];
	NSMutableArray *sectionModels = [sectionMap mObjects];
	NSMutableArray *tempAdBlockModels = [NSMutableArray array];
	for (id model in sectionModels) {
		if([model isKindOfClass:%c(QNBUADefautSingleBlockSectionModel)]){
			QNBUADefautSingleBlockSectionModel *singleBlockModel = model;
			NSMutableArray *cellModels = [singleBlockModel cellModels];
			for (id cellModel in cellModels) {
				if([cellModel isKindOfClass:%c(QNBUAFeedImageAdBlockViewModelV3)]){
					[tempAdBlockModels addObject:cellModel];
				}
			}
			[cellModels removeObjectsInArray:tempAdBlockModels];
			[singleBlockModel setCellModels:cellModels];
		}
	}

	return %orig;

}

%end
