//
//  TNHomeListViewModel.m
//  TestHookEncryption
//
//  Created by Augus on 2025/5/8.
//

#import "TNHomeListViewModel.h"
#import "TNCellModel.h"
#import "TNTextCellModel.h"
#import "TNImageTextCellModel.h"

@interface TNHomeListViewModel ()

@property (nonatomic, strong) NSMutableArray<TNCellModel *> *mutableModels;
@property (nonatomic, assign) NSInteger loadMoreCount;

@end

@implementation TNHomeListViewModel

-(instancetype)init {
   self = [super init];
   if (self) {
       _mutableModels = [NSMutableArray array];
       _loadMoreCount = 0;
   }
   return self;
}

- (NSArray<TNCellModel *> *)models {
   return [self.mutableModels copy];
}

- (void)loadInitialData {
   [self.mutableModels removeAllObjects];
   // 添加文本cell
   for (int i = 0; i < 100; i++) {
       TNTextCellModel *model = [[TNTextCellModel alloc] init];
       model.title = [NSString stringWithFormat:@"标题 %d", i];
       model.content = [NSString stringWithFormat:@"这是内容 %d，可能包含很多行文字。这是一个使用手动布局和高度缓存的高效UITableView方案示例。", i];
       [self.mutableModels addObject:model];
   }
   // 添加图文cell
   for (int i = 0; i < 100; i++) {
       TNImageTextCellModel *imageModel = [[TNImageTextCellModel alloc] init];
       imageModel.title = @"新图文内容";
       imageModel.content = @"这是的图文混排内容。这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容这是的图文混排内容";
       imageModel.imageUrl = @"https://example.com/image.jpg";
       imageModel.imageSize = CGSizeMake(80, 80);
       [self.mutableModels addObject:imageModel];
   }
   [self notifyDataChanged];
}

- (void)prependNewData {
   NSMutableArray *newModels = [NSMutableArray array];
   for (int i = 0; i < 5; i++) {
       TNTextCellModel *model = [[TNTextCellModel alloc] init];
       model.title = [NSString stringWithFormat:@"新标题 %d", i];
       model.content = [NSString stringWithFormat:@"这是新加载的内容 %d，通过下拉刷新获取。", i];
       [newModels addObject:model];
   }
   TNImageTextCellModel *imageModel = [[TNImageTextCellModel alloc] init];
   imageModel.title = @"新图文内容";
   imageModel.content = @"这是下拉刷新加载的图文混排内容。";
   imageModel.imageUrl = @"https://example.com/image.jpg";
   imageModel.imageSize = CGSizeMake(80, 80);
   [newModels addObject:imageModel];

   NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newModels.count)];
   [self.mutableModels insertObjects:newModels atIndexes:indexes];
   [self notifyDataChanged];
}

- (void)appendMoreData {
   self.loadMoreCount++;
   if (self.loadMoreCount >= 3) {
       // 可增加 noMoreData 标记
       return;
   }
   NSMutableArray *moreModels = [NSMutableArray array];
   int startIndex = (int)self.mutableModels.count;
   for (int i = 0; i < 5; i++) {
       if (i % 2 == 0) {
           TNTextCellModel *model = [[TNTextCellModel alloc] init];
           model.title = [NSString stringWithFormat:@"加载更多 %d", startIndex + i];
           model.content = [NSString stringWithFormat:@"这是上拉加载的更多内容 %d。", startIndex + i];
           [moreModels addObject:model];
       } else {
           TNImageTextCellModel *model = [[TNImageTextCellModel alloc] init];
           model.title = [NSString stringWithFormat:@"加载更多图文 %d", startIndex + i];
           model.content = [NSString stringWithFormat:@"这是上拉加载的更多图文内容 %d。", startIndex + i];
           model.imageUrl = @"https://example.com/image.jpg";
           model.imageOnLeft = (i % 4 == 1);
           [moreModels addObject:model];
       }
   }
   [self.mutableModels addObjectsFromArray:moreModels];
   [self notifyDataChanged];
}

- (void)updateModel:(TNCellModel *)model atIndex:(NSUInteger)index {
   if (index < self.mutableModels.count) {
       [self.mutableModels replaceObjectAtIndex:index withObject:model];
       [self notifyDataChanged];
   }
}

@end
