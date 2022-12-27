# 近似熵(Approximate Entropy)
## 基本原理



给定长度为$N$的时间序列 $\left\{ {x\left( i \right),i = 1,2, \cdots ,N} \right\}$，近似熵的计算步骤如下：


1.	对$X$重构相空间，嵌入维度为$m$，形成$m$维的向量序列$\left\{ {X\left( i \right)} \right\}$，可以表示为$X\left( i \right) = \left\{ {x\left( i \right),x\left( {i + 1} \right), \cdots ,x\left( {i + m - 1} \right)} \right\},1 \le i \le N - m + 1$。
2.	定义$d\left[ {X\left( i \right),X\left( j \right)} \right]$是向量$X\left( i \right)$和$X\left( j \right)$的切比雪夫距离，即两个向量对应元素之间差值绝对值的最大值，$d\left[ {X\left( i \right),X\left( j \right)} \right] = \mathop {\max }\limits_{k = 0,1, \cdots ,m - 1} \left[ {\left| {x\left( {i + k} \right) - x\left( {j + k} \right)} \right|} \right]$。
对于$X\left( i \right),1 \le i \le N - m + 1$，需要计算其与剩余其他向量$X\left( j \right),1 \le j \le N,j \ne i$之间的$d\left[ {X\left( i \right),X\left( j \right)} \right]$。因此对任意$X\left( i \right)$都有 $N - m$个距离 。

3.	给定阈值$r$，对于所有的$X\left( i \right)$，统计$d\left[ {X\left( i \right),X\left( j \right)} \right]$中小于阈值$r$的数量，然后这个数量与总距离数$N - m$的比值记为:
$$C_i^m\left( r \right) = \frac{{{\rm{number}}\left\{ {i|1 \le i \le N - m + 1,d\left[ {X\left( i \right),X\left( j \right)} \right] < r} \right\}}}{{N - m}}\tag{1}$$
4.	对$C_i^m\left( r \right)$取对数，然后计算所有$N - m + 1$个 的均值，记为:
$${\phi ^m}\left( r \right) = \frac{1}{{N - m + 1}}\sum\limits_{i = 1}^{N - m + 1} {\ln C_i^m\left( r \right)} \tag{2}$$
5.	将嵌入维度增加到$m + 1$，重复以上步骤1-步骤4，得到$C_i^{m + 1}\left( r \right)$和${\phi ^{m + 1}}\left( r \right)$。
6.	理论上，近似熵可以被计算为：
$$ApEn\left( {m,r} \right) = \mathop {\lim }\limits_{N \to \infty } \left[ {{\phi ^m}\left( r \right) - {\phi ^{m + 1}}\left( r \right)} \right] \tag{3}$$
由于实际信号的 不能趋近于无穷大，有限序列的近似熵定义为:
$$ApEn\left( {m,r,N} \right) = {\phi ^m}\left( r \right) - {\phi ^{m + 1}}\left( r \right) \tag{4}$$




 
 

 
 
 
 

 
