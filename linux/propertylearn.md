### 

+++
title = "python property原理"
author = "liuxiayu"
github_url = "https://github.com/liuxiayu"
head_img = ""
created_at = 2021-12-07T14:52:43
updated_at = 2021-12-07T14:52:43
description = "记录学习property"
tags = ["python"]
+++


```
class MyProperty(object):
    '''
    内部property是用c实现的，这里用python模拟实现property功能
    代码参考官方doc文档
    '''

    def __init__(self, fget=None, fset=None, fdel=None, doc=None):
        self.fget = fget
        self.fset = fset
        self.fdel = fdel
        self.__doc__ = doc

    def __get__(self, obj, objtype=None):
        if obj is None:
            return self
        if self.fget is None:
            raise (AttributeError, "unreadable attribute")
        print('self={},obj={},objtype={}'.format(self,obj,objtype))
        print("self.fget(obj):",self.fget(obj))
        return self.fget(obj)

    def __set__(self, obj, value):
        if self.fset is None:
            raise (AttributeError, "can't set attribute")
        self.fset(obj, value)

    def __delete__(self, obj):
        if self.fdel is None:
            raise (AttributeError, "can't delete attribute")
        self.fdel(obj)

    def getter(self, fget):
        print("fget :",fget)
        return type(self)(fget, self.fset, self.fdel, self.__doc__)

    def setter(self, fset):
        print("fset :", fset)
        return type(self)(self.fget, fset, self.fdel, self.__doc__)

    def deleter(self, fdel):
        return type(self)(self.fget, self.fset, fdel, self.__doc__)


class Student1( object ):
    @MyProperty
    def score( self ):
        return self._score
    @score.setter
    def score( self, val ):
        if not isinstance( val, int ):
            raise ValueError( 'score must be an integer!' )
        if val > 100 or val < 0:
            raise ValueError( 'score must between 0 ~ 100!' )
        self._score = val

class Student2( object ):

    def __init__(self, attr=5):
        self._score = attr
    def getx( self ):
        return self._score

    def setx( self, val ):
        if not isinstance( val, int ):
            raise ValueError( 'score must be an integer!' )
        if val > 100 or val < 0:
            raise ValueError( 'score must between 0 ~ 100!' )
        self._score = val
    score = MyProperty(getx, setx)


if __name__ == "__main__":
    #第一种 装饰器
    s1 = Student1()
    s1._score = 60
    print("s1._score:",s1._score)

    # 第二种 类属性
    s2 = Student2()
    s2.score = 100
    print("s2.score:",s2.score)
```

```
输出结果
fset : <function Student1.score at 0x10ed81040>
s1._score: 60
self=<__main__.MyProperty object at 0x10ec4ec70>,obj=<__main__.Student2 object at 0x10ed733a0>,objtype=<class '__main__.Student2'>
self.fget(obj): 100
s2.score: 100
```

```
总结
知识点: t = 类Test() 会调用Test的__get__方法
思路：
（1）第二种类属性的方法 根据score = MyProperty(getx, setx) -> 此时的MyProperty的fget=getx，fset=setx -> 会走MyProperty的__get__方法__get__(self, obj, objtype=None)，
此时这个obj是Student2的对象-> self.fget(obj) = getx(obj) -> return self._score 

（2）第一种装饰器的方法类似, 把score方法当作装饰器(Property类)的参数转化进去  当执行self.score时， 等价于 MyProperty(score) 返回 self.fget(obj) -> score(obj) -> return self._score
```

