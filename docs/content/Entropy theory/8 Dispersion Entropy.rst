色散熵(Dispersion Entropy)
==============================

基本原理
~~~~~~~~~~~~~~~

给定长度为 :math:`N` 的时间序列 :math:`\left\{ {{x_1},{x_2}, \cdots ,{x_N}} \right\}` ，色散熵的计算步骤如下：

1.	将 :math:`{x_j}\left( {j = 1,2, \cdots ,N} \right)` 映射到 :math:`c` 类，并且将类标记为:math:`1` 到 :math:`c` 。为此，首先使用正态累积分布函数(NCDF)将 :math:`x` 映射到 :math:`y = \left\{ {{y_1},{y_2}, \cdots ,{y_N}} \right\}` ，:math:`{y_j}`  为0-1的值。接下来，我们使用线性算法将每个 :math:`{y_j}` 赋值为从1到 :math:`c` 的整数。对于映射后的信号的每个元素，使用 :math:`z_j^c = {\rm{round}}\left( {c \cdot {y_j} + 0.5} \right)` 得到分类后的时间序列。:math:`z_j^c` 表示分类后时间序列的第 :math:`j` 个元素，通过四舍五入将 :math:`{y_j}` 增加或减少到一个整数类。

2.	以嵌入维度 :math:`m` 和时间延迟 :math:`d` 对 :math:`z_j^c` 进行相空间重构，得到 :math:`N - \left( {m - 1} \right)d` 个嵌入向量 :

.. math::
  z_i^{m,c} = \left\{ {z_i^c,z_{i + d}^c, \cdots ,z_{i + \left( {m - 1} \right)d}^c} \right\},i = 1,2, \cdots ,N - \left( {m - 1} \right)d  \tag{1}

.. important:: 
 时间序列的每个嵌入向量 :math:`z_i^{m,c}` 被映射到一个色散模式 :math:`{\pi _{{v_0}{v_1} \cdots {v_{m - 1}}}}` ，其中 :math:`z_i^c = {v_0},z_{i + d}^c = {v_1}, \cdots ,z_{i + \left( {m - 1} \right)d}^c = {v_{m - 1}}`  。因为每个嵌入向量 :math:`z_i^{m,c}` 有 :math:`m` 个元素，每个元素可能是1到 :math:`c` 的整数，因此共有 :math:`{c^m}`种可能的色散模式。

3.	对于 :math:`{c^m}` 种可能的色散模式，统计每种色散模式的概率:

.. math::
  p\left( {{\pi _{{v_0}{v_1} \cdots {v_{m - 1}}}}} \right) = \frac{{{\rm{Number}}\left\{ {i|i \le N - \left( {m - 1} \right)d,z_i^{m,c}{\rm{ has type }}{\pi _{{v_0}{v_1} \cdots {v_{m - 1}}}}} \right\}}}{{N - \left( {m - 1} \right)d}} \tag{2}

.. important:: 
    :math:`p\left( {{\pi _{{v_0}{v_1} \cdots {v_{m - 1}}}}} \right)` 表示： :math:`N - \left( {m - 1} \right)d` 个嵌入向量 :math:`z_i^{m,c}`  中属于 :math:`{\pi _{{v_0}{v_1} \cdots {v_{m - 1}}}}` 色散模式的数量除以嵌入向量的总数 :math:`N - \left( {m - 1} \right)d` 。
	

4.	最后，色散熵可以被计算为：

.. math::
   DispEn\left( {x,m,c,d} \right) =  - \sum\limits_{\pi  = 1}^{{c^m}} {p\left( {{\pi _{{v_0}{v_1} \cdots {v_{m - 1}}}}} \right) \cdot \ln p\left( {{\pi _{{v_0}{v_1} \cdots {v_{m - 1}}}}} \right)}     \tag{3}

.. note:: 
 色散熵是由Rostaghi等人 [#]_，提出的，建议的参数选择为：

 - 嵌入维度  :math:`m = 3`  
 -  :math:`c=6` 
  


 
代码实现
~~~~~~~~~~~~~~~
这里假设您已经获得本项目的的所有代码，若您此时还未获得有关程序，请移步到 :doc:`/content/11`

符号动力学熵(Symbolic dynamic Entropy)的核心程序为  ``MultiDispEn``

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
  -  ``Sym`` :符号序列
  -  ``scale`` :尺度比

仿真验证
~~~~~~~~~~~~~~~

色散熵的脉冲检测结果
------------------------------------

.. figure::  /images/单尺度脉冲检测结果/DispEn.png
   :alt: 色散熵的脉冲检测结果
   :align: center

 
多尺度色散熵的故障分类可视化结果
------------------------------------
 
.. figure:: /images/多尺度可视化结果/MultiDispEn.png
   :alt: 多尺度色散熵的故障分类可视化结果
   :align: center
 
抗噪性分析
------------------------------------
 
.. figure:: /images/抗噪性结果/DispEn.png
   :alt: 抗噪性分析
   :align: center 

计算效率结果
------------------------------------
 
.. figure:: /images/计算效率结果/DispEn.png
   :alt: 计算效率结果
   :align: center 

 
..  [#] M. Rostaghi and H. Azami, “Dispersion Entropy: A Measure for Time-Series Analysis,” IEEE Signal Process. Lett., vol. 23, no. 5, pp. 610–614, May 2016, doi: 10.1109/LSP.2016.2542881.

 
