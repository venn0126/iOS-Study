#import "Header/FindFriendEntryViewController.h"

// 导入的该文件时应该与当前Tweak.m属于同一级目录
#import "Model/GTPerson.h"

#define GTAutoCellOn @"gt_autoCellOn"
#define GTUserDefaults [NSUserDefaults standardUserDefaults]
#define GTFile(fileName) @"/Library/Caches/GTWeChat/" #fileName
#define kGTCellHeight 44.0

%hook FindFriendEntryViewController


- (long long)numberOfSectionsInTableView:(id)tableView {
	// 调用原来的方法，因为自己会调用传入参数
	return %orig + 1;
}


- (long long)tableView:(id)tableView numberOfRowsInSection:(long long)section {

	// 如果是最后一组就是2
	// 否则就是原来的实现
	if (section == ([self numberOfSectionsInTableView:tableView] - 1)) {
		return 2;
	} else {
		return %orig;
	}
}


- (id)tableView:(id)tableView cellForRowAtIndexPath:(id)indexPath {

	if ([indexPath section] != [self numberOfSectionsInTableView:tableView] - 1) {
		return %orig;
	}


	NSString *cellId =  ([indexPath row] == 0) ? @"gt_autoCellId" : @"gt_exitCellId";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = UIColor.whiteColor;
        cell.imageView.image = [UIImage imageWithContentsOfFile:GTFile(gt_wechat_skull.png)];   
     }

    if([indexPath row] == 0) {// 自动抢红包
        cell.textLabel.text = @"自动抢红包";
        
        // 右侧的指示符
        UISwitch *switchView = [[UISwitch alloc] init];
        cell.accessoryView = switchView;
        [switchView addTarget:self action:@selector(switchViewTap:) forControlEvents:UIControlEventValueChanged];
        switchView.on = [GTUserDefaults boolForKey:GTAutoCellOn];
    
    }else if([indexPath row] == 1) {// 退出微信
        cell.textLabel.text = @"每天爱高田";
    }

    return cell;

}


- (double)tableView:(id)tableView heightForRowAtIndexPath:(id)indexPath {

	if ([indexPath section] != [self numberOfSectionsInTableView:tableView] - 1) {
		return %orig;
	}

	return kGTCellHeight;

}


- (void)tableView:(id)tableView didSelectRowAtIndexPath:(id)indexPath {
	if([indexPath section] != [self numberOfSectionsInTableView:tableView] - 1) {
		%orig;
		return;
	}
	// 自定义的取消选中
	[tableView deselectRowAtIndexPath:indexPath animated:YES];

	if([indexPath row] == 1) {// 退出微信的逻辑
        abort();
    }

    GTPerson *p = [[GTPerson alloc] init];
    p.name = @"gao tian";
    NSLog(@"The p name is %@",p.name);

}


// switchView点击事件
%new
- (void)switchViewTap:(UISwitch *)switchView {
    [GTUserDefaults setBool:switchView.on forKey:GTAutoCellOn];
    [GTUserDefaults synchronize];
}


%end