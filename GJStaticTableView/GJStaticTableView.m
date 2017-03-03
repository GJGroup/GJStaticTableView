//
//  GJStaticTableView.m
//  GJStaticTableView
//
//  Created by wangyutao on 16/9/14.
//  Copyright © 2016年 wangyutao. All rights reserved.
//


#import "GJStaticTableView.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <UITableView+FDTemplateLayoutCell.h>

BOOL canResponseProtocolMethod(id obj, Protocol *protocol, SEL selector) {
    if (obj &&
        [obj conformsToProtocol:protocol] &&
        [obj respondsToSelector:selector])
        return YES;
    return NO;
}

@interface GJStaticTableView ()

@property (nonatomic, weak) id<UITableViewDelegate> gj_delegate;
@property (nonatomic, weak) id<UITableViewDataSource> gj_dataSource;
@property (nonatomic, strong) NSMutableArray<UITableViewCell *> *_cells;

@end

@implementation GJStaticTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self._cells = @[].mutableCopy;
        [self loadCells];
        [super setDataSource:self];
        [super setDelegate:self];
    }
    return self;
}

- (void)loadCells {
    Class cls = self.class;
    
    while (![cls isEqual:GJStaticTableView.class]) {
        unsigned count = 0;
        objc_property_t *properties = class_copyPropertyList(cls, &count);
        
        if (properties == NULL) continue;
        
        for (unsigned i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            [self loadValidProperty:property];
        }
        free(properties);
        cls = cls.superclass;
    }
}


//R	The property is read-only (readonly).
//C	The property is a copy of the value last assigned (copy).
//&	The property is a reference to the value last assigned (retain).
//N	The property is non-atomic (nonatomic).
//G<name>	The property defines a custom getter selector name. The name follows the G (for example, GcustomGetter,).
//S<name>	The property defines a custom setter selector name. The name follows the S (for example, ScustomSetter:,).
//D	The property is dynamic (@dynamic).
//W	The property is a weak reference (__weak).
//P	The property is eligible for garbage collection.
//t<encoding>	Specifies the type using old-style encoding.
- (void)loadValidProperty:(objc_property_t)property {
    unsigned int attrCount;
    objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
    Class cls;
    NSString *typeEncoding;
    const char *name = property_getName(property);
    NSString *nameStr;
    if (name) {
        nameStr = [NSString stringWithUTF8String:name];
    }
    if (!nameStr) return;
    
    for (unsigned int i = 0; i < attrCount; i++) {
        if (attrs[i].name[0] == 'T') {
            if (attrs[i].value) {
                typeEncoding = [NSString stringWithUTF8String:attrs[i].value];
                
                if (typeEncoding.length) {
                    NSScanner *scanner = [NSScanner scannerWithString:typeEncoding];
                    if (![scanner scanString:@"@\"" intoString:NULL]) continue;
                    
                    NSString *clsName = nil;
                    if ([scanner scanUpToCharactersFromSet: [NSCharacterSet characterSetWithCharactersInString:@"\"<"] intoString:&clsName]) {
                        if (clsName.length) cls = objc_getClass(clsName.UTF8String);
                        if ([cls instancesRespondToSelector:@selector(initWithStyle:reuseIdentifier:)]) {
                            SEL setter = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", [nameStr substringToIndex:1].uppercaseString, [nameStr substringFromIndex:1]]);
                            id cell;
                            NSString *path = [[NSBundle mainBundle] pathForResource:clsName ofType:@"nib"];
                            if (path) {
                                cell = [[NSBundle mainBundle] loadNibNamed:clsName owner:nil options:0].firstObject;
                                [self registerNib:[UINib nibWithNibName:clsName bundle:nil] forCellReuseIdentifier:clsName];
                            }
                            if (!cell) {
                                cell = [[cls alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clsName];
                                [self registerClass:cls forCellReuseIdentifier:clsName];
                            }
                            ((void (*)(id, SEL, id))(void *) objc_msgSend)(self, setter, (id)cell);
                            [self._cells addObject:cell];
                        }
                    }
                }
            }
        }
    }
    if (attrs) {
        free(attrs);
        attrs = NULL;
    }

}

#pragma mark - protocol hook

//- (id<UITableViewDelegate>)delegate {
//    return self.gj_delegate;
//}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    self.gj_delegate = delegate;
}

//- (id<UITableViewDataSource>)dataSource {
//    return self.gj_dataSource;
//}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    self.gj_dataSource = dataSource;
}

#pragma mark - message forarding
- (BOOL)respondsToSelector:(SEL)aSelector {
    
    if (canResponseProtocolMethod(self.gj_dataSource, @protocol(UITableViewDataSource), aSelector))
        return YES;
    
    if (canResponseProtocolMethod(self.gj_delegate, @protocol(UITableViewDelegate), aSelector))
        return YES;
    
    return [super respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (canResponseProtocolMethod(self.gj_dataSource, @protocol(UITableViewDataSource), aSelector))
        return self.gj_dataSource;
    
    if (canResponseProtocolMethod(self.gj_delegate, @protocol(UITableViewDelegate), aSelector))
        return self.gj_delegate;
    
    return nil;
}
#pragma mark - dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (canResponseProtocolMethod(self.gj_dataSource, @protocol(UITableViewDataSource), _cmd))
        return [self.gj_dataSource numberOfSectionsInTableView:tableView];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (canResponseProtocolMethod(self.gj_dataSource, @protocol(UITableViewDataSource), _cmd))
        return [self.gj_dataSource tableView:tableView numberOfRowsInSection:section];
    return self._cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (canResponseProtocolMethod(self.gj_delegate, @protocol(UITableViewDelegate), _cmd))
        return [self.gj_delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    
    id cell = self._cells[indexPath.row];
    CGFloat height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([cell class]) configuration:^(id cell) {
    }];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (canResponseProtocolMethod(self.gj_dataSource, @protocol(UITableViewDataSource), _cmd))
        return [self.gj_dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
        
    UITableViewCell *cell = self._cells[indexPath.row];
    return cell;
}

@end
