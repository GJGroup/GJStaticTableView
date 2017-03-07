# GJStaticTableView

GJStaticTableView是一个静态的TableView控件，如果你用过Storyboard的话，一定对其中的静态TableView有印象，然而在实际开发中，我们也经常需要这种控件，例如在非信息流的列表型的展示页面，我们并不需要进行Cell复用，然而你也可能因为某些原因不希望使用Storyboard，这时你可以使用GJStaticTableView了。

## Installation
- 可以直接将项目中GJStaticTableView文件夹Copy到工程目录中
- 也可以使用CocoaPods进行集成

```bash
pod 'GJStaticTableView'
```

## Usage

### Creating a GJStaticTableView

你需要继承GJStaticTableView，在子类中只需要将自定义的Cell使用@property进行声明即可。

```objective-c
#import "GJStaticTableView.h"
#import "GJTableViewCell0.h"
#import "GJTableViewCell1.h"
#import "GJTableViewCell2.h"
#import "GJTableViewCell3.h"
#import "GJTableViewCell4.h"

@interface CustomTableView : GJStaticTableView
@property (nonatomic, strong) GJTableViewCell0 *cell0;
@property (nonatomic, strong) GJTableViewCell1 *cell1;
@property (nonatomic, strong) GJTableViewCell2 *cell2;
@property (nonatomic, strong) GJTableViewCell3 *cell3;
@property (nonatomic, strong) GJTableViewCell4 *cell4;

@end
```

然后将这个CustomTableView生成实例add到界面上去吧

```objective-c
    self.tableView = [[CustomTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
```

run一下看看效果

### Delegate & DataSource

#### Cell Height

默认情况下，GJStaticTableView会利用FDTemplateLayoutCell计算Cell的高度并自动设置，你只需按照Autolayout的约束规范将Cell内的元素与Cell进行约束，将其撑起高度即可。
某些情况下，如果你希望自己给Cell设定一个静态高度，那么你可以让这个Cell实现GJStaticCellPotocol中的gj_rowHeight方法，返回一个高度值即可。

```objective-c
#import "GJTableViewCell1.h"

@implementation GJTableViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Code ...
    }
    return self;
}

- (CGFloat)gj_rowHeight {
    return 40;
}

@end
```

如果这还不能满足你的要求，那么你可以设置tableView的delegate来自己实现`tableView:heightForRowAtIndexPath:`方法。

```objective-c
@interface ViewController () <UITableViewDelegate>
@property (nonatomic, strong) CustomTableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[CustomTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //custom height
}
```

#### Other delegate & dataSource

如果你想使用其他UITableView的特性，你只需向上面一样设置好delegate和dataSource，
注意：在GJStaticTableView内，我们使用了4个方法：
- `numberOfSectionsInTableView:`
- `tableView:heightForRowAtIndexPath:`
- `tableView:numberOfRowsInSection:`
- `tableView:cellForRowAtIndexPath:`

你需要注意他们对你自定义代理方法的影响

## Bugs and Issues

- 如果您再使用中遇到任何bug，请尽快反馈给我，Thanks！
- 如果您有功能上的需求，您也可以Issues或Email给我，Thanks！
