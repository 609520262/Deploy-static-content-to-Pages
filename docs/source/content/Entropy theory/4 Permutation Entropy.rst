排列熵(Permutation Entropy)
==============================

基本原理
~~~~~~~~~~~~~~~

设有长度为 :math:`N`  的时间序列 :math:`\left\{ {{x_1},{x_2}, \cdots ,{x_N}} \right\}` ，排列熵的计算步骤如下：

1.	将时间序列进行相空间重构，嵌入维度为 :math:`m` ，形成向量序列 :math:`\left\{ {{x_1}\left( m \right),{x_2}\left( m \right), \cdots ,{x_{N - m + 1}}\left( m \right)} \right\}`  ，其中:

.. math::
    {x_i}\left( m \right) = \left\{ {x\left( i \right),x\left( {i + 1} \right), \cdots ,x\left( {i + m - 1} \right)} \right\},1 \le i \le N - m + 1 \tag{1}

2.	每个向量 :math:`{x_i}\left( m \right)`  内元素排列的顺序模式记为  :math:`{\pi _j}`。嵌入维度为 :math:`m`，则一共有 :math:`m!` 种顺序模式。统计每种顺序模式 :math:`\left\{ {{\pi _j}} \right\}_{j = 1}^{m!}`  出现的概率，记为:

.. math::
    p\left( {{\pi _j}} \right) = \frac{{\left\| {i:i \le N - m + 1,type\left( {{x_i}\left( m \right)} \right) = {\pi _j}} \right\|}}{{N - m + 1}} \tag{2}

.. tip::
    例如当 :math:`m = 3` 时，向量内的元素由小到大记为  :math:`0，1，2` ，共有 :math:`m! = 6` 种顺序模式  :math:`(012,021,102,120,201,210)` 。对于向量  :math:`{x_1}\left( 3 \right) = \left( {8,12,6} \right),{x_2}\left( 3 \right) = \left( {9,3,8} \right)`，有 :math:`{x_1}\left( 3 \right)` 的顺序模式为 :math:`\pi  = 120` ，:math:`{x_2}\left( 3 \right)` 的顺序模式为 :math:`\pi  = 201` 。

3.	排列熵定义为:

.. math::
    PE\left( {m,N} \right) =  - \sum {p\left( {{\pi _j}} \right)\log p\left( {{\pi _j}} \right)}  \tag{3}

	
4.	归一化处理后为:

.. math::
   PE\left( {m,N} \right) =  - \frac{1}{{\log \left( {m!} \right)}}\sum {p\left( {{\pi _j}} \right)\log p\left( {{\pi _j}} \right)}  \tag{4}

.. note:: 
 排列熵是由Bandt等人 [#]_，提出的，建议的参数选择为：

 - 嵌入维度  :math:`m = 3 \sim 7`  ,在后续的仿真验证中，我们选择  :math:`m = 6` 。


 
代码实现
~~~~~~~~~~~~~~~
这里假设您已经获得本项目的的所有代码，若您此时还未获得有关程序，请移步到  :doc:`/content/install`

模糊熵(Fuzzy entropy)的核心程序为  ``MultiscalePermutationEntropy``

.. code-block:: c++

  function MPE = MultiscalePermutationEntropy(data,m,t,scale)
      MPE=[];
     for j=1:scale
         Xs = Multi(data,j);
         PE = PermutationEntropy(Xs,m,t);
         MPE=[MPE,PE];
     end
  end
  
.. important:: 各输入参数的信息如下：

  -  ``data``：输入的时间序列，为列向量 
  -  ``m`` :嵌入维度
  -  ``r``  : 容限
  -  ``scale`` :尺度比



仿真验证
~~~~~~~~~~~~~~~

排列熵的脉冲检测结果
------------------------------------

.. figure::  /images/单尺度脉冲检测结果/PE.png
   :alt: 排列熵的脉冲检测结果
   :align: center

 
多尺度排列熵的故障分类可视化结果
------------------------------------
 
.. figure:: /images/多尺度可视化结果/MultiPermutationEntropy.png
   :alt: 多尺度排列熵的故障分类可视化结果
   :align: center
 
抗噪性分析
------------------------------------
 
.. figure:: /images/抗噪性结果/PE.png
   :alt: 抗噪性分析
   :align: center 

计算效率结果
------------------------------------
 
.. figure:: /images/计算效率结果/PE.png
   :alt: 计算效率结果
   :align: center 
 
 
..  [#] C. Bandt and B. Pompe, “Permutation Entropy: A Natural Complexity Measure for Time Series,” Phys. Rev. Lett., vol. 88, no. 17, p. 174102, Apr. 2002, doi: 10.1103/PhysRevLett.88.174102.
 
