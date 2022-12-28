符号动力学熵(Symbolic dynamic Entropy)
==============================

基本原理
~~~~~~~~~~~~~~~

给定长度为 :math:`N` 的时间序列  :math:`\left\{ {u\left( i \right),1 \le i \le N} \right\}` ，符号动力学熵的计算步骤如下：

1.	采用最大熵划分(MEP)对时间序列在振幅域上进行符号化。时间序列的元素转换为符号  :math:`{\sigma _i}\left( {i = 1,2, \cdots ,\varepsilon } \right)` 。可以得到符号化后的时间序列  :math:`Z\left\{ {z\left( k \right),k = 1,2, \cdots ,N} \right\}` 。

2.	对符号化时间序列进行相空间重构并计算可能的状态模式概率。嵌入维数为  :math:`m` ，时间延迟为 :math:`\lambda` 时，:math:`Z\left\{ {z\left( k \right),k = 1,2, \cdots ,N} \right\}`  重构相空间后可以得到一系列的嵌入向量： 

.. math::
  Z_j^{m,\lambda }\left\{ {z\left( j \right),z\left( {j + 1 \times \lambda } \right), \cdots ,z\left( {j + \left( {m - 1} \right) \times \lambda } \right)} \right\},j = 1,2, \cdots ,N - \left( {m - 1} \right)\lambda \tag{1}

.. important:: 
   向量  :math:`Z_j^{m,\lambda }`  有  :math:`m`  个元素，每个元素有 :math:`\varepsilon`  个可能的符号，因此共有 :math:`{\varepsilon ^m}`  种可能的状态模式。向量的状态可以表示为  :math:`q_a^{\varepsilon ,m,\lambda }\left( {a = 1,2, \cdots ,{\varepsilon ^m}} \right)` 。因此，可能的状态模式的概率  :math:`P\left( {q_a^{\varepsilon ,m,\lambda }} \right)` 可以按如下计算:

.. math::
    P\left( {q_a^{\varepsilon ,m,\lambda }} \right) = \frac{{\left\| {\left\{ {j:j \le N - \left( {m - 1} \right)\lambda ,type\left( {Z_j^{\varepsilon ,m,\lambda }} \right) = q_a^{\varepsilon ,m,\lambda }} \right\}} \right\|}}{{N - \left( {m - 1} \right)\lambda }} \tag{2}

3.	构造状态转移并计算状态转移概率。状态转移指的是符号化的时间序列会从一个状态转移到下一个状态(包括自循环)。当状态模式为 :math:`q_a^{\varepsilon ,m,\lambda }\left( {a = 1,2, \cdots ,{\varepsilon ^m}} \right)` ，转移到下一个状态状态转移概率为符号 :math:`{\sigma _b}\left( {b = 1,2, \cdots ,\varepsilon } \right)` 的条件概率，如下:
	
.. math::
   P\left( {{\sigma _b}|q_a^{\varepsilon ,m,\lambda }} \right) = P\left\{ {z\left( {j + m\lambda } \right) = {\sigma _b}|j:j \le N - m\lambda ,type\left( {Z_j^{\varepsilon ,m,\lambda }} \right) = q_a^{\varepsilon ,m,\lambda }} \right\}    \tag{3}

.. important:: 
  其中 :math:`a = 1,2, \cdots ,{\varepsilon ^m}` ，:math:`b = 1,2, \cdots ,\varepsilon` ，:math:`\varepsilon` 为符号数，:math:`{\varepsilon ^m}` 为状态数。状态概率满足条件 :math:`\sum\limits_{b = 1}^\varepsilon  {P\left( {{\sigma _b}|q_a^{\varepsilon ,m,\lambda }} \right)}  = 1` 。 :math:`P\left( {{\sigma _b}|q_a^{\varepsilon ,m,\lambda }} \right)` 可以表示为:

.. math::
  P\left( {{\sigma _b}|q_a^{\varepsilon ,m,\lambda }} \right) = \frac{{\left\| {\left\{ {j:j \le N - m\lambda ,type\left( {Z_j^{\varepsilon ,m,\lambda }} \right) = q_a^{\varepsilon ,m,\lambda },z\left( {j + m\lambda } \right) = {\sigma _b}} \right\}} \right\|}}{{N - m\lambda }} \tag{4}

4.	符号动力学熵定义为状态熵和状态转移熵的和，表示为:

.. math::
  SDE\left( {X,m,\lambda ,\varepsilon } \right) =  - \sum\limits_{a = 1}^{{\varepsilon ^m}} {P\left( {q_a^{\varepsilon ,m,\lambda }} \right)\ln P\left( {q_a^{\varepsilon ,m,\lambda }} \right)}  - \sum\limits_{a = 1}^{{\varepsilon ^m}} {\sum\limits_{b = 1}^\varepsilon  {P\left( {q_a^{\varepsilon ,m,\lambda }} \right)\ln \left( {P\left( {q_a^{\varepsilon ,m,\lambda }} \right)P\left( {{\sigma _b}|q_a^{\varepsilon ,m,\lambda }} \right)} \right)} }   \tag{5}

5.	符号化熵的最大值为 :math:`\ln \left( {{\varepsilon ^{m + 1}}} \right)` ，这时表示所有的状态概率和状态转移概率有都相同的值 :math:`\left( P\left( q_{a}^{\varepsilon ,m,\lambda } \right)={1}/{{{\varepsilon }^{m}}}\;,P\left( {{\sigma }_{b}}|q_{a}^{\varepsilon ,m,\lambda } \right)={1}/{\varepsilon }\; \right)` 。可以得到标准化处理后的符号动力学熵表示为:

.. math::
  SDE\left( X,m,\lambda ,\varepsilon  \right)={SDE\left( X,m,\lambda ,\varepsilon  \right)}/{\ln \left( {{\varepsilon }^{m+1}} \right)} \tag{6}
  
.. note:: 
 符号动力学熵是由Li等人 [#]_，提出的，建议的参数选择为：

 - 嵌入维度  :math:`m = 3`  
 - 符号数  :math:`\varepsilon  = 12` 
 - 时间延迟  :math:`\lambda  = 1`  


 
代码实现
~~~~~~~~~~~~~~~
这里假设您已经获得本项目的的所有代码，若您此时还未获得有关程序，请移步到 :doc:`/content/11`

符号动力学熵(Symbolic dynamic Entropy)的核心程序为  ``MultiscaleSymbolicDynamicEntropy``

.. code-block:: c++

  function MSDE=MultiscaleSymbolicDynamicEntropy(data,m,Sym,scale)

     MSDE=[];
     data=data';
     for j=1:scale
        Xs = Multi(data,j,2);
        SDE=SymbolDynamicEntropy(Xs,m,Sym);
        MSDE=[MSDE,SDE];
     end
   end
  
.. important:: 各输入参数的信息如下：

  -  ``data``：输入的时间序列，为列向量 
  -  ``m`` :嵌入维度
  -  ``Sym`` :符号序列
  -  ``scale`` :尺度比

仿真验证
~~~~~~~~~~~~~~~

符号动力学熵的脉冲检测结果
------------------------------------

.. figure::  /images/单尺度脉冲检测结果/SDE.png
   :alt: 符号动力学熵的脉冲检测结果
   :align: center

 
多尺度符号动力学熵的故障分类可视化结果
------------------------------------
 
.. figure:: /images/多尺度可视化结果/MultiSymbolicDynamicEntropy.png
   :alt: 多尺度符号动力学熵的故障分类可视化结果
   :align: center
 
抗噪性分析
------------------------------------
 
.. figure:: /images/抗噪性结果/SDE.png
   :alt: 抗噪性分析
   :align: center 

计算效率结果
------------------------------------
 
.. figure:: /images/计算效率结果/SDE.png
   :alt: 计算效率结果
   :align: center 


 
..  [#] Y. Li, Y. Yang, G. Li, M. Xu, and W. Huang, “A fault diagnosis scheme for planetary gearboxes using modified multi-scale symbolic dynamic entropy and mRMR feature selection,” Mech. Syst. Signal Process., vol. 91, pp. 295–312, Jul. 2017, doi: 10.1016/j.ymssp.2016.12.040.

 
