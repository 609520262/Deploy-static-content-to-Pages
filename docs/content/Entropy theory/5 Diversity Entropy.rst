散度熵(Diversity Entropy)
==============================

基本原理
~~~~~~~~~~~~~~~

有长度为 :math:`N`  的时间序列  :math:`X = \left\{ {{x_1}, \cdots ,{x_i}, \cdots ,{x_N}} \right\}`，散度熵的计算步骤如下：

1.	将原始序列相空间重构为一系列的向量 :math:`{y_i}\left( m \right) = \left\{ {{x_i},{x_{i + 1}}, \cdots ,{x_{i + m - 1}}} \right\}` ，嵌入维度为 :math:`m`  ，得到如下的相空间:

.. math::
          Y\left( m \right) = \left\{ {{y_1}\left( m \right),{y_2}\left( m \right), \cdots ,{y_{N - m + 1}}\left( m \right)} \right\} \tag{1}

.. note:: 
   :math:`{y_{N - M + 1}}\left( m \right)={\left\{ {{x_m},{x_{m + 1}}, \cdots , \cdots ,{x_N}} \right\}^T}` 均为列向量，:math:`Y\left( m \right)` 构成 :math:`(N - m,m)` 维矩阵。

2.	计算相邻向量之间的余弦相似度，得到一系列的余弦相似度 ，余弦相似度的计算如下：

.. math::
    D\left( m \right) = \left\{ {{d_1}, \cdots ,{d_{N - m}}} \right\} = \left\{ {d\left( {{y_1}\left( m \right),{y_2}\left( m \right)} \right), \cdots ,d\left( {{y_{N - m}}\left( m \right),{y_{N - m + 1}}\left( m \right)} \right)} \right\} \tag{2}

.. math::
    d\left( {{y_i}\left( m \right),{y_j}\left( m \right)} \right) = \frac{{\sum\limits_{k = 1}^m {{y_i}\left( k \right) \times {y_j}\left( k \right)} }}{{\sqrt {\sum\limits_{k = 1}^m {{y_i}{{\left( k \right)}^2}} }  \times \sqrt {\sum\limits_{k = 1}^m {{y_j}{{\left( k \right)}^2}} } }} \tag{3}

3.	余弦相似度的范围为 :math:`\left[ { - 1,1} \right]` ，将 :math:`\left[ { - 1,1} \right]`  分为 :math:`\varepsilon` 个子区间 :math:`\left( {{I_1},{I_2}, \cdots ,{I_\varepsilon }} \right)`  。然后将所有余弦相似度划分到子区间中，统计落入每个子区间的概率 :math:`\left( {{P_1},{P_2}, \cdots ,{P_\varepsilon }} \right)` 。 
	
4.	DE可以被定义为:

.. math::
   DE\left( {m,\varepsilon ,N} \right) =  - \frac{1}{{\ln \varepsilon }}\sum\limits_{k = 1}^\varepsilon  {{P_k}\ln {P_k}}   \tag{4}

.. note:: 
 散度熵是由Wang等人 [#]_，提出的，建议的参数选择为：

 - 嵌入维度  :math:`m = 4`  ,
 - 符号数  :math:`\varepsilon  = 30 \sim 100`  ,在后续的仿真验证中，我们选择  :math:`m = 4` ，:math:`\varepsilon=30`  。


 
代码实现
~~~~~~~~~~~~~~~
这里假设您已经获得本项目的的所有代码，若您此时还未获得有关程序，请移步到  :doc:`/content/install`

模糊熵(Fuzzy entropy)的核心程序为  ``MultiDispEn``

.. code-block:: c++

  function [MDE]=MultiDispEn(data,m,nc,tau,scale)

      MDE=[];
      data=data';
      for j=1:scale
          Xs = Multi(data,j,1);
          [de]=DisEn_NCDF(Xs',m,nc,tau);
          MDE=[MDE,de];
      end
  end
  
.. important:: 各输入参数的信息如下：

  -  ``data``：输入的时间序列，为列向量 
  -  ``m`` :嵌入维度
  -  ``nc``  : 类别数目
  -  ``tau`` :时间差
  -  ``scale`` :尺度比

仿真验证
~~~~~~~~~~~~~~~

散度熵的脉冲检测结果
------------------------------------

.. figure::  /images/单尺度脉冲检测结果/DivEn.png
   :alt: 散度熵的脉冲检测结果
   :align: center

 
多尺度散度熵的故障分类可视化结果
------------------------------------
 
.. figure:: /images/多尺度可视化结果/MultiDivEn.png
   :alt: 多尺度散度熵的故障分类可视化结果
   :align: center
 
抗噪性分析
------------------------------------
 
.. figure:: /images/抗噪性结果/DivEn.png
   :alt: 抗噪性分析
   :align: center 

计算效率结果
------------------------------------
 
.. figure:: /images/计算效率结果/DivEn.png
   :alt: 计算效率结果
   :align: center 

 
..  [#] X. Wang, S. Si, and Y. Li, “Multiscale Diversity Entropy: A Novel Dynamical Measure for Fault Diagnosis of Rotating Machinery,” IEEE Trans. Ind. Inform., vol. 17, no. 8, pp. 5419–5429, Aug. 2021, doi: 10.1109/TII.2020.3022369.