# iOS 规范化方案

## 命名规范
> 驼峰命名规则结合下划线合理使用
#### 类名
> 类名、文件名、按类别使用前缀
- VC_   :UIViewController
- Cell_   :UITableViewCell
- Item_   :UICollectionViewCell
- View_   :UIView
- M_ : Model
- VM_ : ViewModel
#### 属性名
> 属性 
- 控件以控件类型做前缀，如：
  - btn_
  - lab_
  - img_
- 共有属性 以 _ 开始，便于编辑器联想 快速选择
#### 方法名
> 

## 关于注释
> 如果属性、方法等命名无法明确突显作用，应以 /// 注释，便于联想提示
> 重要功能分区 应以 //MARK:---  注释

## 关于文档
> 文件页收 应有模块文档，以说明模块作用，重大修改记录、注意事项等

