样本熵(Sample entropy)
==============================

基本原理
~~~~~~~~~~~~~~~

设有长度为  :math:`N`  的时间序列  :math:`X = \left\{ {x\left( 1 \right),x\left( 2 \right), \cdots ,x\left( N \right)} \right\}` ，样本熵的计算步骤如下：


1.             将时间序列  :math:`X`  重构相空间，形成向量序列  :math:`\left\{ {{x_m}\left( 1 \right),{x_m}\left( 2 \right), \cdots ,{x_m}\left( {N - m + 1} \right)} \right\}` ，嵌入维度也就是向量的维度为  :math:`m`  ，其中:

.. math::
    {x_m}\left( i \right) = \left\{ {x\left( i \right),x\left( {i + 1} \right), \cdots ,x\left( {i + m - 1} \right)} \right\},1 \le i \le N - m + 1 \tag{1}

2.	定义距离  :math:`d\left[ {{x_m}\left( i \right),{x_m}\left( j \right)} \right]` 为向量 :math:`{x_m}\left( i \right)` 和  :math:`{x_m}\left( j \right)` 对应元素差值绝对值的最大值，即切比雪夫距离:

.. math::
     d\left[ {{x_m}\left( i \right),{x_m}\left( j \right)} \right] = \mathop {\max }\limits_{k = 0, \cdots ,m - 1} \left( {\left| {x\left( {i + k} \right) - x\left( {j + k} \right)} \right|} \right) \tag{2}

3.	给定容限  :math:`r` ，对于固定的  :math:`{x_m}\left( i \right)` ，统计其与 :math:`{x_m}\left( j \right)` 之间的距离满足  :math:`d\left[ {{x_m}\left( i \right),{x_m}\left( j \right)} \right] \le r,j \ne i`  的距离个数记为  :math:`{B_i}` ，总的距离数为  :math:`N - m` ，定义:

.. math::
     B_i^m\left( r \right) = \frac{1}{{N - m}}{B_i} \tag{3}
	
4.	对  :math:`1 \le i \le N - m + 1`，定义  :math:`{B^m}\left( r \right)` 为

.. math::
   {B^m}\left( r \right) = \frac{1}{{N - m + 1}}\sum\limits_{i = 1}^{N - m + 1} {B_i^m\left( r \right)}  \tag{4}

5.	将维数  :math:`m` 增加到  :math:`m+1` ，重复以上（步骤1-步骤4），得到 :math:`{B^{m + 1}}\left( r \right)`
6.	样本熵可以被定义为:

.. math::
  SampEn\left( {m,r} \right) = \mathop {\lim }\limits_{N \to \infty } \left\{ { - \ln \left[ {\frac{{{B^{m + 1}}\left( r \right)}}{{{B^m}\left( r \right)}}} \right]} \right\} \tag{5}

由于实际信号的 :math:`N` 不能趋近于无穷大，因此有限序列的样本熵定义为:

.. math::
  SampEn\left( {m,r,N} \right) =  - \ln \left[ {\frac{{{B^{m + 1}}\left( r \right)}}{{{B^m}\left( r \right)}}} \right] \tag{6}

.. note:: This is a note admonition.
  样本熵是由Richman等人 [#]_，提出的，建议的参数选择为：

 - 嵌入维度  :math:`m=2` 
 - 容限  :math:`r`   一般取 `0.1~0.25` 倍时间序列的标准差（SD）。在后续的仿真验证中，我们选择 :math:`m=2` ,   :math:`r = 0.15 \times {\rm{SD}}` 。

..  [#] 这是第一个注记的信息

 
代码实现
~~~~~~~~~~~~~~~
这里假设您已经获得本项目的的所有代码，若您此时还未获得有关程序，请移步到 :doc:`/content/11`

样本熵(Sample entropy)的核心程序为 ``ApproximateEntropy``

.. highlight:: sh

::

  function SE=SampleEntropy(data,m,r)  % 输入的时间序列data为列向量即可
    SE=SampleEntropy1(data,m,r);
 end
  
.. important:: 各输入参数的信息如下：

  -  ``data``：输入的时间序列，为列向量 
  -  ``r``  : 容限
  -  ``m`` :嵌入维度
   


仿真验证
~~~~~~~~~~~~~~~

样本熵的脉冲检测结果
------------------------------------

.. figure::  /images/单尺度脉冲检测结果/SE.png
   :alt: 1.	样本熵的脉冲检测结果
   :align: center

 
多尺度样本熵的故障分类可视化结果
------------------------------------
 
.. figure:: /images/多尺度可视化结果/MultiSE.png
   :alt: 多尺度样本熵的故障分类可视化结果
   :align: center
 
抗噪性分析
------------------------------------
 
.. figure:: /images/抗噪性结果/SE.png
   :alt: 抗噪性分析
   :align: center 

计算效率结果
------------------------------------
 
.. figure:: /images/计算效率结果/SE.png
   :alt: 计算效率结果
   :align: center 
 

 
