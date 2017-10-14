# IOS 时间轴

可用于录像回放的时间轴，默认往后最多可移动到当前时间，往前可无限拖动。

### 使用

包含头文件 QTimeLine.h
    
    QTimeLine * tl = [[QTimeLine alloc]initWithFrame:CGRectMake(0, 100, 700, 60)];
    tl.delegate = self;
    [self.view addSubview:tl];

需要ios8.0及以上
