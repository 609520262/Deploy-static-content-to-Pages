分布熵(Distribution Entropy)
==============================

基本原理
~~~~~~~~~~~~~~~

设有长度为  :math:`N` 的时间序列  :math:`\left\{ {u\left( i \right),1 \le i \le N} \right\}` ，分布熵的计算步骤如下：

1.	相空间重构：可以得到  :math:`\left( {N - m} \right)` 个向量 :math:`X\left( i \right)`

.. math::
          X\left( i \right) = \left\{ {u\left( i \right),u\left( {i + 1} \right), \cdots ,u\left( {i + m - 1} \right)} \right\},1 \le i \le N - m \tag{1}

2.	构造距离矩阵 :math:`{\bf{D}} = \left\{ {{d_{ij}}} \right\}` ：定义距离 :math:`{d_{ij}}` 为向量  :math:`X\left( i \right)` 和 :math:`X\left( j \right)` 的切比雪夫距离，对于任意 :math:`i,j` 满足  :math:`1 \le i,j \le N - m` ， :math:`{d_{ij}}`  表示为:

.. math::
    {d_{ij}} = \max \left\{ {\left| {u\left( {i + k} \right) - u\left( {j + k} \right)} \right|,0 \le k \le m - 1} \right\} \tag{2}

3.	概率密度估计：所有 :math:`{d_{ij}}` 的分布特征是距离矩阵 :math:`{\bf{D}}` 信息的完全量化，应用直方图的方法来估计  :math:`{\bf{D}}`  的经验概率密度函数。设直方图有  :math:`M` 个区间，统计所有 :math:`{d_{ij}}` 落入到每个区间的概率记为  :math:`{p_t},t = 1,2, \cdots ,M` 。为了减少偏差，不计入  :math:`i=j` 的元素。
	
4.	分布熵可以被定义为:

.. math::
   DistEn\left( {m,M,N} \right) =  - \sum\limits_{t = 1}^M {{p_t}{{\log }_2}({p_t})}    \tag{3}

5.	归一化处理后分布熵表示为

.. math::
  DistEn\left( {m,M,N} \right) =  - \frac{1}{{{{\log }_2}(M)}}\sum\limits_{t = 1}^M {{p_t}{{\log }_2}({p_t})}  \tag{4}

.. note:: 
 分布熵是由Li等人 [#]_，提出的，建议的参数选择为：

 - 嵌入维度  :math:`m = 2`  ,
 - 区间数  :math:`M=512` 


 
代码实现
~~~~~~~~~~~~~~~
这里假设您已经获得本项目的的所有代码，若您此时还未获得有关程序，请移步到 :doc:`/content/11`

模糊熵(Fuzzy entropy)的核心程序为  ``DEparameter``

.. code-block:: c++

  function [DE]=DEparameter(data,m,tau,sigma)  % 输入的时间序列为列向量即可
       [DE]=diversityEn(data,m,tau,sigma);  % 加入尺度后的矩阵 再嵌入m维度,按步骤求出散度熵    
  end
  
.. important:: 各输入参数的信息如下：

  -  ``data``：输入的时间序列，为列向量 
  -  ``m`` :嵌入维度
  -  ``tau`` :像空间重构时步长
  -  ``sigma`` :将[-1,1]区间划分的数量

仿真验证
~~~~~~~~~~~~~~~

分布熵的脉冲检测结果
------------------------------------

.. figure::  /images/单尺度脉冲检测结果/DistEn.png
   :alt: 分布熵的脉冲检测结果
   :align: center

 
多尺度分布熵的故障分类可视化结果
------------------------------------
 
.. figure:: /images/多尺度可视化结果/MultiDistEn.png
   :alt: 多尺度分布熵的故障分类可视化结果
   :align: center
 
抗噪性分析
------------------------------------
 
.. figure:: /images/抗噪性结果/DistEn.png
   :alt: 抗噪性分析
   :align: center 

计算效率结果
------------------------------------
 
.. figure:: /images/计算效率结果/DistEn.png
   :alt: 计算效率结果
   :align: center 

..  [#] P. Li, C. Liu, K. Li, D. Zheng, C. Liu, and Y. Hou, “Assessing the complexity of short-term heartbeat interval series by distribution entropy,” Med. Biol. Eng. Comput., vol. 53, no. 1, pp. 77–87, Jan. 2015, doi: 10.1007/s11517-014-1216-0.