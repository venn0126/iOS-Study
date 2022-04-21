# The FlowChart Of MarkDown

> 用最通俗的语言，描述最难懂的技术



## 语法

流程图的语法分为两部分

* 前半部分用来定义流程图元素
* 后半部分用来连接流程图元素，指定流程图的执行走向



### 定义元素阶段的语法

```js
tag=>type: content:>url
```

参数说明

* `tag`是流程图中的标签，在第二阶段连接元素时会用到。名称任意，一般为流程的英文缩写和数字的组合
* `type`用来确定标签的类型，`=>`后面表示类型。由于标签的名称可以任意指定，所以要依赖`type`来确定标签的类型
  * 标签有6种类型：`start, end, operation, suibroutine, condition, inputoutput`
* `content`是流程图文本框中的描述内容，`:`后面表示的内容，中英文都可，**特别注意：冒号和文本之间有一个空格**
* `url`是一个链接，与框中的文本相绑定，`:>`后面就是对应的跳转链接，点击文本可以通过链接跳转到指定的`url`



### 标签语法示例

#### `start`

使用这个标签作为流程图的开始的第一个节点，默认文本是`Start`

![](https://github.com/adrai/flowchart.js/blob/master/imgs/start.png?raw=true)

```js
st=>start: Start
```

#### `end`

使用这个标签作为流程图的最后一个节点，默认为本是`End`

![](https://github.com/adrai/flowchart.js/blob/master/imgs/end.png?raw=true)

```js
e=>end: End
```

#### `operation`

表明在流程中需要发生一个操作

![](https://github.com/adrai/flowchart.js/blob/master/imgs/operation.png?raw=true)

```js
op1=>operation: operation
```

#### `inputoutput`

表明在一个流程中发生了输入输出

![](https://github.com/adrai/flowchart.js/blob/master/imgs/inputoutput.png?raw=true)

```js
io=>inputoutput: inputoutput
```

#### `subroutine`

表明一个子程序在流程中发生，应该有另一个流程图来记录这个子程序

![](https://github.com/adrai/flowchart.js/blob/master/imgs/subroutine.png?raw=true)

```js
sub1=>subroutine: subroutine
```

#### `condition`

允许一个条件或者逻辑语句将流向指向两个路径中的一个

![](https://github.com/adrai/flowchart.js/blob/master/imgs/condition.png?raw=true)

```js
cont=>condition: condition
YES or NO?
```

#### `parallel`

允许多个流向同时发生

![](https://github.com/adrai/flowchart.js/raw/master/imgs/parallel.png)

```js
para=>parallel: parallel
```



## 连接

```js
st->i->cond1
cond(yes)->o1->e
cond(no)->sub1(right)>op1
```

连接流程图元素阶段的语法就很简单，不同的元素之间拿`->`来连接

对于`condition`类型，有`YES or NO`两个分支

每个元素可以指定分支走向，默认向下，也可以用`right`指向右边，如例子中的`sub1(right)`

[更多语法](https://github.com/adrai/flowchart.js#connections)

## 举例说明

### Example1

   ```flow
st=>start: Start
i=>inputoutput: 输入年份n
cond1=>condition: n能否被4整除？
cond2=>condition: n能否被100整除？
cond3=>condition: n能否被400整除？
o1=>inputoutput: 输出非闰年
o2=>inputoutput: 输出非闰年
o3=>inputoutput: 输出闰年
o4=>inputoutput: 输出闰年
e=>end
st->i->cond1
cond1(no)->o1->e
cond1(yes)->cond2
cond2(no)->o3->e
cond2(yes)->cond3
cond3(yes)->o2->e
cond3(no)->o4->e
   ```





### Example2

`subroutine`表示子程序，`sub(right)`可定义连接点的位置

   ```flow
st=>start: start:>http://www.baidu.com
op1=>operation: 操作1
cond1=>condition: YES or NO?
sub=>subroutine: 子程序
e=>end

st->op1->cond1
cond1(yes)->e
cond1(no)->sub(right)->op1  
   ```




### Example3

```flow
st=>start: Start|past:>http://www.baidu.com
e=>end:  Ende|future:>http://www.baidu.com
op1=>operation:  My Operation
op2=>operation:  Stuff|current
sub1=>subroutine:  My Subroutine|invalid
cond=>condition:  Yes or No|approved:>http://www.google.com
c2=>condition:  Good idea|rejected
io=>inputoutput:  catch something...|future
st->op1(right)->cond
cond(yes, right)->c2
cond(no)->sub1(left)->op1
c2(yes)->io->e
c2(no)->op2->e
```





## 数学公式

$$
\begin{matrix}
1 & x & x^2 \\
1 & y & y^2 \\
1 & z & z^2 \\
\end{matrix}
$$



## 参考文档

[flowchart.js](https://github.com/adrai/flowchart.js)

[mathjax](https://math.meta.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference)

