# iOS应用资源命名标准

## 总体原则

* 全英文小写：使用小写英文，避免大小写混淆（`iOS` 文件系统对大小写敏感）。

* 分隔符：单词之间用下划线 _ 分隔，避免空格、连字符或其他特殊字符。

* 语义清晰：文件名应直观反映资源所属模块、功能和内容。

* 简洁性：文件名长度控制在 30 个字符以内，避免过长影响可读性。

* 一致性：所有资源文件遵循统一结构，便于团队协作和自动化处理

## 命名结构

### 图片文件

格式：`页面_功能_描述_(@2x/@3x).png`

- 页面：所属模块或视图控制器（如 `login`、`home`、`profile`）。
- 功能：资源用途，如 `img`（界面图片）、`icon`（图标）、`bg`（背景）、`btn`（按钮）。
- 描述：具体内容描述，如 `circle`、`arrow`、`banner`。
- 分辨率：`@2x` 或 `@3x`，适配`Retina` 屏幕（非 `Asset Catalog` 场景）。
- 扩展名：通常为 `.png`，也可为 `.jpg` 或其他格式。

示例：

- `login_img_circle@2x.png`
- `home_icon_arrow@3x.png`
- `profile_btn_submit@2x.png`

`Asset Catalog` 场景：

示例：

```objc
Assets.xcassets/
├── login_img_circle.imageset/
│   ├── login_img_circle@2x.png
│   ├── login_img_circle@3x.png
├── home_icon_arrow.imageset/
│   ├── home_icon_arrow@2x.png
│   ├── home_icon_arrow@3x.png
```



### JSON 等数据文件

格式：`页面_功能_描述.json`

- 页面：所属模块或视图控制器（如 `login`、`settings`）。
- 功能：文件用途，如 `data`（数据）、`animation`（动画）、`config`（配置）。
- 描述：具体内容，如 `funnel`、`list`、`theme`。
- 扩展名：`.json` 或其他数据文件格式（如 `.plist`）。

示例：

```objc
login_animation_funnel.json
home_data_list.json
settings_config_theme.json
```



全局文件：如果` JSON` 文件不特定于某个页面，可用通用前缀：

示例：`config_app_theme.json、data_global_settings.json`

## 命名规范细则

### 页面字段

* 表示资源所属的模块或视图控制器，使用简短的模块名。
* 推荐值：
  * `login`：登录页面
  * `home`：主页
  * `profile`：个人中心
  * `settings`：设置
  * `search`：搜索

### 功能字段

* 反映资源的用途或类型，保持简洁。

* 推荐值：

  * 图片：`img`（普通图片）、`icon`（图标）、`bg`（背景）、`btn`（按钮）、`avatar`（头像）
  * JSON：`data`（数据）、`animation`（动画）、`config`（配置）、`mock`（模拟数据）

  

### 描述字段

* 具体描述资源内容，简洁且具象。
* 推荐值
  * 形状：`circle`、`arrow`、`line`
  * 内容：`banner`、`avatar`、`funnel`
  * 动作：`submit`、`refresh`、`close`
* 避免冗长描述（如 `user_profile_header_image`）。

## iOS 开发中的最佳实践

### 使用 Asset Catalog

* 推荐：将所有图片资源放入 `Assets.xcassets`，以优化加载和分辨率管理。

* 命名规则：图片组命名为 页面_功能_描述，组内包含 `@2x` 和 `@3x` 文件。

* 示例

  ```objc
  Assets.xcassets/
  ├── login_btn_submit.imageset/
  │   ├── login_btn_submit@2x.png
  │   ├── login_btn_submit@3x.png
  ```

  

### 文件夹结构

* 对于非图片资源（如 `JSON` 文件），按模块组织在 `Resources` 或类似文件夹中。
* 示例：

```objc
Resources/
├── Login/
│   ├── animation_funnel.json
│   ├── data_user.json
├── Home/
│   ├── data_list.json
```



### 避免冗余

* 去掉不必要的后缀，如 `漏斗json.json` 改为 `login_animation_funnel.json。`

* 如果模块已在文件夹层级体现，可省略文件名中的 页面 字段。
  * 示例：在 `Login` 文件夹下，命名为 `animation_funnel.json`。

### 本地化支持

* 如果资源涉及多语言，文件名可添加语言标识（如 `_en`、`_zh`）。
* 示例：`login_img_circle_en@2x.png`（英文版）、`login_img_circle_zihao1502@gmail.com@2x.png`（中文版）。

### 版本控制

* 如果资源有版本迭代，可在描述后添加版本号，如 `login_img_circle_v2@2x.png`。
* 仅在必要时使用，避免文件名过长。

## 示例命名

假设一个` iOS` 应用包含 `Login` 和 `Home` 模块，资源命名如下：

图片（`Asset Catalog`）：

```objc
Assets.xcassets/
├── login_img_circle.imageset/
│   ├── login_img_circle@2x.png
│   ├── login_img_circle@3x.png
├── login_btn_submit.imageset/
│   ├── login_btn_submit@2x.png
│   ├── login_btn_submit@3x.png
├── home_icon_arrow.imageset/
│   ├── home_icon_arrow@2x.png
│   ├── home_icon_arrow@3x.png
```

JSON 文件

```objc
Resources/
├── Login/
│   ├── animation_funnel.json
│   ├── data_user.json
├── Home/
│   ├── data_list.json
│   ├── config_theme.json
```



## 工具与自动化

* 批量重命名：使用脚本（如 `rename` 命令或 `Python` 脚本）批量将中文名改为英文规范。

  * 示例脚本（检查不符合规范的文件）

    ```bash
    bash
    
    find . -type f -name "*.png" | grep -vE "[a-z]+_[a-z]+_[a-z]+(@2x|@3x)?\.png$"
    find . -type f -name "*.json" | grep -vE "[a-z]+_[a-z]+_[a-z]+\.json$"
    ```

* 资源检查：在`CI/CD` 流程中添加命名规范检查，确保新资源符合标准。

* 设计协作：要求设计师导出资源时遵循命名规范，如 `login_img_circle@2x.png`，减少开发者重命名工作

## 注意事项

* 文件名长度：避免过长命名，如 `settings_profile_icon_user_avatar@2x.png`，可简化为 `settings_icon_avatar@2x.png`。
* 跨平台兼容：如果资源与` Android` 或 `Web `共享，确保命名通用且无平台特定字符。
* 文档化：在项目中维护一份命名规范文档，供团队参考。

## 参考

无





