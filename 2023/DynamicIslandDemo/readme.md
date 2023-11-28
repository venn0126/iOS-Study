
## 灵动岛基本信息
灵动岛（Dynamic Island）相关API，隶属于Live Activity Framework，出现在iOS16.1系统；Live Activities负责在iPhone锁屏（Lock Screen）和灵动岛（Dynamic Island）中显示应用程序的最新数据。这使得人们一眼就能看到实时信息,并可以进行一些简单交互。
1. Live Activities 可以展示app的最新数据在 iPhone的 LockScreen 锁屏上 和 Dynamic Island 灵动岛上。
2. Widget Extension组件，iOS 14 重磅推出的新功能，使得用户可以在主屏幕添加小组件，快速浏览 app 提供的重要信息
3. 使用Live Activities 功能需要依赖Widget Extension，你可以在原有WidgetExtension上添加或者新建一个。
4. ActivityKit用于管理Live Activities的生命周期。（request、update、end）
5. 灵动岛，要求iOS16.1+系统，iPhone 14 Pro & iPhone 14 Pro Max机型；
6. 一个Live Activity可以激活长达8小时,除非App通过API或用户终止它，否则。超过此限制，系统将自动结束。当一个Live Activity结束时，系统立即将其从灵动岛（Dynamic Island）中删除。然而，Live Activity会一直保持在锁定屏幕上，直到用户删除它
7. 每个Live Activity运行在自己的沙盒里，不像widget，不能获取网络或接受位置更新；要更新活跃的Live Activity的动态数据，有两种方式：应用程序中使用ActivityKit框架；允许Live Activity接收远程推送通知

效果图预览
<div style="text-align:left"> 
<img src="https://img2022.cnblogs.com/blog/950551/202211/950551-20221114163227954-1755861202.png" width="32%" height="32%">  
<img src="https://img2022.cnblogs.com/blog/950551/202211/950551-20221114163236220-1260231560.png" width="32%" height="32%">  
<img src="https://img2022.cnblogs.com/blog/950551/202211/950551-20221114163242777-1214475409.png" width="32%" height="32%">  
</div>

## 灵动岛显示视图
灵动岛有三种视图形式，从左到右依次是 紧凑视图、最小视图、扩展视图
![](https://img2022.cnblogs.com/blog/950551/202211/950551-20221114154009916-1746825719.webp)
三种视图之间可以进行切换；当一个人在灵动岛中触摸并长按紧凑或最小视图时，以及当一个实时活动更新时，扩展视图就会出现。在不支持灵动岛的解锁设备上，展开的视图显示为Live Activity更新的横幅。为了确保系统能够在每个位置显示你的APP的实时活动，APP必须支持所有视图。
扩展视图，由于区域空间较大，进一步分割出下面具体区域
![](https://img2022.cnblogs.com/blog/950551/202211/950551-20221114154119857-1030465584.webp)
灵动岛使用了44点的圆角半径，它的圆角形状与TrueDepth相机相匹配。
| 展现类型 | 设备 | 灵动岛宽度（点 ） |
| :------------- | :-------------  | :------------- |
| 紧凑或最小 | iPhone 14 Pro Max | 250      |
| 紧凑或最小 | iPhone 14 Pro     | 230      |
| 扩展    | iPhone 14 Pro Max | 408      |
| 扩展    | iPhone 14 Pro     | 371      |

Live Activity大小
下表中列出的所有值都以点为单位。
| 屏幕尺寸(纵向)  | Compact leading  | Compact trailing | Minimal (diameter) | Expanded (height given as a range) | Lock Screen |
| :------------- | :--------------- | :-------------| :------------- | :-------------| :------------- |
| 430x932 | 62.33x36.67 | 62.33x36.67 | 36.67 | 408x84–160 | 408x160 |
| 393x852 | 52.33x36.67 | 52.33x36.67 | 36.67 | 371x84–160 | 371x160 |

## 创建并开启灵动岛
1. 需要至少Xcode 14.1 Beta版及iOS16.1才能使用ActivityKit 框架，iOS16.1是第一个开放ActivityKit的正式版本
2. 在主工程的info.plist中加入键值NSSupportsLiveActivities ，并将其布尔值设置为YES
3. 因为灵动岛是属于小组件的一部分，所以项目中如果没有小组件的话要先创建小组件。有小组件的话可以添加些代码即可适配。
![](https://img2022.cnblogs.com/blog/950551/202211/950551-20221114155209347-478132742.webp)
4. 创建Widget时勾选Include Live Activity会自动创建Activity相关代码
 - 紧凑视图：分为leading和traling视图，只有一个live activity事件时
 - 最小视图：两个及以上live activity事件时，左右显示的都是minmal视图
 - 扩展视图：分为leading、traling、center、bottom
 - 锁屏视图：锁屏的时候会展示在锁屏下方
```
var body: some WidgetConfiguration {
        ActivityConfiguration(for: GroceryDeliveryAppAttributes.self) { context in
            LockScreenView(context: context) //锁屏视图
        } dynamicIsland: { context in
            DynamicIsland {
                 //扩展视图
                 DynamicIslandExpandedRegion(.leading) {
                    dynamicIslandExpandedLeadingView(context: context)
                 }
                 
                 DynamicIslandExpandedRegion(.trailing) {
                     dynamicIslandExpandedTrailingView(context: context)
                 }
                 
                 DynamicIslandExpandedRegion(.center) {
                     dynamicIslandExpandedCenterView(context: context)
                 }
                 
                 DynamicIslandExpandedRegion(.bottom) {
                    dynamicIslandExpandedBottomView(context: context)
                 }
                
              } compactLeading: {//单个前视图
                  compactLeadingView(context: context)
              } compactTrailing: {//单个后视图
                  compactTrailingView(context: context)
              } minimal: { //最小化视图
                  minimalView(context: context)
              }
              .keylineTint(.cyan) //灵动岛边缘颜色
        }
    }
```
5. 在主工程中创建开启、更新、关闭Activity相关代码
```
    /// 开启灵动岛显示功能
    func startActivity(){
        Task{
            let attributes = WidgetDemoAttributes(name:"我是名字")
            let initialContentState = WidgetDemoAttributes.ContentState(value: 100)
            do {
                let myActivity = try Activity<WidgetDemoAttributes>.request(
                    attributes: attributes,
                    contentState: initialContentState,
                    pushType: nil)
                print("Requested a Live Activity \(myActivity.id)")
                print("已开启灵动岛显示 App切换到后台即可看到")
            } catch (let error) {
                print("Error requesting pizza delivery Live Activity \(error.localizedDescription)")
            }
        }
    }
    
    /// 更新灵动岛显示
    func updateActivity(){
        Task{
            let updatedStatus = WidgetDemoAttributes.ContentState(value: 2000)
            for activity in Activity<WidgetDemoAttributes>.activities{
                await activity.update(using: updatedStatus)
                print("已更新灵动岛显示 Value值已更新 请展开灵动岛查看")
            }
        }
    }
    
    /// 结束灵动岛显示
    func endActivity(){
        Task{
            for activity in Activity<WidgetDemoAttributes>.activities{
                await activity.end(dismissalPolicy: .immediate)
                print("已关闭灵动岛显示")
            }
        }
    }
```
参考来源 ：
>  https://developer.apple.com/documentation/activitykit
>  https://github.com/1998code/iOS16-Live-Activities
>  https://www.jianshu.com/p/16dc66e0b6fe
>  https://juejin.cn/post/7160616320365494279

github图片显示不全 请前往https://www.cnblogs.com/qqcc1388/p/16889243.html 博客园查看详情
