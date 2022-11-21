# 《计数器实验》 实验报告

<center>高焕昂 @ 计04</center>

## 思考题

**计数器模块中提到的异步逻辑与同步逻辑有何不同？可以通过观察 Vivado 综合后的电路原理图，并且查阅相关资料回答本题。**

![image-20220919183641383](C:\Users\c7w13\AppData\Roaming\Typora\typora-user-images\image-20220919183641383.png)

<center>同步逻辑</center>

![image-20220919185227229](C:\Users\c7w13\AppData\Roaming\Typora\typora-user-images\image-20220919185227229.png)

<center>异步逻辑</center>

在**同步时序逻辑电路**中，各触发器的时钟端全部连接到系统时钟，只有当系统时钟触发时，才可以改变电路的状态。而在**异步时序逻辑电路**中，时钟之间没有固定的因果关系，触发器状态变化不与系统时钟脉冲源同步，很大概率存在竞争与冒险，一般无法进行静态时序分析。

## 参考资料

- https://zhuanlan.zhihu.com/p/368055286