
+++
title = "理解python中的object、type"
author = "liuxiayu"
github_url = "https://github.com/liuxiayu"
head_img = ""
created_at = 2021-12-07T16:52:43
updated_at = 2021-12-07T16:52:43
description = "理解python中的object、type"
tags = ["python"]
+++
### 理解python中的object、type

详解如图【画得真好】
![图](http://127.0.0.1:8888/group1/M00/00/00/CgAQBmGvO5eAAxz9AAIxpbpRVjE610.png)


```
class X():
    pass

print(type.__class__)    # 生成type类对象的类
print(object.__class__)  # 生成object类对象的类
print(X.__class__)       # 生成X类对象的类

x=2
print(int.__class__)     # 生成int类对象的类，该类和type,object都是由type对象生成
print(x.__class__)       # 生成x的类为int

输出:
<class 'type'>
<class 'type'>
<class 'type'>
<class 'type'>
<class 'int'>

```

```
print(type(object()))
print(type(object))
print(type(type))
print(isinstance(type,object))
print(isinstance(object,type))

输出:
<class 'object'>
<class 'type'>
<class 'type'>
True
True
```

