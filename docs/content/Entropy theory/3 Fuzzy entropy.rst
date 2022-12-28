模糊熵(Fuzzy entropy)
==============================

基本原理
~~~~~~~~~~~~~~~

在样本熵的基础上引入了一种模糊隶属度函数得到了模糊熵。设有长度为 :math:`N` 的时间序列 :math:`X = \left\{ {x\left( 1 \right),x\left( 2 \right), \cdots ,x\left( N \right)} \right\}` ，模糊熵的计算步骤如下：

1.	将时间序列 :math:`X` 重构相空间，形成向量序列 :math:`\left\{ {{x_m}\left( 1 \right),{x_m}\left( 2 \right), \cdots ,{x_m}\left( {N - m + 1} \right)} \right\}`  ，嵌入维度也就是向量的维度为 :math:`m`  ，其中:

.. math::
    {x_m}\left( i \right) = \left\{ {x\left( i \right),x\left( {i + 1} \right), \cdots ,x\left( {i + m - 1} \right)} \right\} - x0\left( i \right),1 \le i \le N - m + 1 \tag{1}

这里的 :math:`x0\left( i \right)` 为基线向量，通过去除基线进行泛化。:math:`x0\left( i \right)`  定义为

.. math::
  x0\left( i \right) = \frac{1}{m}\sum\limits_{k = 0}^{m - 1} {{x_m}\left( {i + k} \right)} \tag{2}

2.	定义距离 :math:`d_{ij}^m` 为向量 :math:`{x_m}\left( i \right)` 和  :math:`{x_m}\left( j \right)` 对应元素差值绝对值的最大值，即切比雪夫距离:

.. math::
    d_{ij}^m = d\left[ {{x_m}\left( i \right),{x_m}\left( j \right)} \right] = \mathop {\max }\limits_{k = 0, \cdots ,m - 1} \left( {\left| {\left( {x\left( {i + k} \right) - x0\left( i \right)} \right) - \left( {x\left( {j + k} \right) - x0\left( j \right)} \right)} \right|} \right) \tag{3}

3.	给定模糊函数参数 :math:`n` 和 :math:`r` ，通过模糊函数  :math:`\mu \left( {d_{ij}^m,n,r} \right)` 计算 :math:`{x_m}\left( j \right)` 对 :math:`{x_m}\left( i \right)`  的相似程度: 

.. math::
    D_{ij}^m\left( {n,r} \right) = \mu \left( {d_{ij}^m,n,r} \right) \tag{4}

模糊函数 :math:`\mu \left( {d_{ij}^m,n,r} \right)` 为指数函数，如下:

.. math::
  \mu \left( d_{ij}^{m},n,r \right)=\exp \left( {-{{\left( d_{ij}^{m} \right)}^{n}}}/{r}\; \right) \tag{5}

	
4.	定义函数 :math:`{\phi ^m}\left( {n,r} \right)` 为:

.. math::
   {\phi ^m}\left( {n,r} \right) = \frac{1}{{N - m + 1}}\sum\limits_{i = 1}^{N - m + 1} {\left( {\frac{1}{{N - m}}\sum\limits_{j = 1,j \ne i}^{N - m + 1} {D_{ij}^m} } \right)}  \tag{6}

5.	将维数 :math:`m` 增加到 :math:`m + 1`  ，重复以上（步骤1-步骤4），得到 :math:`{\phi ^{m + 1}}\left( {n,r} \right)`
6.	模糊熵可以被定义为

.. math::
  FuzzyEn\left( {m,n,r} \right) = \mathop {\lim }\limits_{N \to \infty } \left[ {\ln {\phi ^m}\left( {n,r} \right) - \ln {\phi ^{m + 1}}\left( {n,r} \right)} \right] \tag{7}

对于有限长度为 :math:`N` 的序列，模糊熵可以被定义为

.. math::
  FuzzyEn\left( {m,n,r,N} \right) = \ln {\phi ^m}\left( {n,r} \right) - \ln {\phi ^{m + 1}}\left( {n,r} \right) \tag{8}

.. note:: 
  模糊熵是由Chen等人 [#]_，提出的，建议的参数选择为：

 - 嵌入维度  :math:`m=2` 
 - 容限  :math:`r`   一般取 `0.1~0.25` 倍时间序列的标准差（SD）。
 - 参数 :math:`n=2`  。在后续的仿真验证中，我们选择 :math:`m=2` ,  :math:`n=2` ，  :math:`r = 0.15 \times {\rm{SD}}` 。


 
代码实现
~~~~~~~~~~~~~~~
这里假设您已经获得本项目的的所有代码，若您此时还未获得有关程序，请移步到  :doc:`/content/install`

模糊熵(Fuzzy entropy)的核心程序为  ``MultiscaleFuzzyEntropy_pdist_paran``

.. code-block:: c++

  function MFE=MultiscaleFuzzyEntropy_pdist_paran(data,m,n,r,scale)
      MFE=[];
      for j=1:scale
           Xs = Multi(data,j);
           FE=FuzzyEntropy(Xs,m,n,r);
           MFE=[MFE,FE];
       end
   end
  
.. important:: 各输入参数的信息如下：

  -  ``data``：输入的时间序列，为列向量 
  -  ``m`` :嵌入维度
  -  ``r``  : 容限
  -  ``scale`` :尺度比

仿真验证
~~~~~~~~~~~~~~~

模糊熵的脉冲检测结果
------------------------------------

.. figure::  /images/单尺度脉冲检测结果/FE.png
   :alt: 模糊熵的脉冲检测结果
   :align: center

 
多尺度模糊熵的故障分类可视化结果
------------------------------------
 
.. figure:: /images/多尺度可视化结果/MultiFuzzEn.png
   :alt: 多尺度模糊熵的故障分类可视化结果
   :align: center
 
抗噪性分析
------------------------------------
 
.. figure:: /images/抗噪性结果/FE.png
   :alt: 抗噪性分析
   :align: center 

计算效率结果
------------------------------------
 
.. figure:: /images/计算效率结果/FE.png
   :alt: 计算效率结果
   :align: center 
 

 
..  [#] W. Chen, Z. Wang, H. Xie, and W. Yu, “Characterization of Surface EMG Signal Based on Fuzzy Entropy,” IEEE Trans. Neural Syst. Rehabil. Eng., vol. 15, no. 2, pp. 266–272, Jun. 2007, doi: 10.1109/TNSRE.2007.897025.