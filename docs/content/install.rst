安装说明
==============================



一、简介
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

本章帮助您获得 **Entropy theory** 的所有源码以及配置您进行熵值实验的所需环境。


二、Entropy theory源码获取
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
本节内容将演示两种不同的获取Entropy theory的所有源码的方式：

 -  克隆 ``clone`` 远程Entropy theory的方式
 -  直接下载Entropy theory  ``zip`` 包
 
.. attention:: 
   假如您有一定的  ``git`` 使用经验，推荐您采用第一种 **远程克隆** 的方式获取本实验室的Entropy theory的源码，我们将不间断地更新课题组实验室的最新熵值程序，确保您能够即使获取最新源码。

.. hint:: 
  Entropy theory源码基于 `MATLAB科学计算平台 <https://ww2.mathworks.cn/products/matlab.html>`_ 请确保您此时的MATLAB版本高于 ``2019`` 。

克隆 ``clone`` 远程Entropy theory
------------------------------------

.. code:: console

    $  git clone https://github.com/609520262/Entropy-theory.git


直接下载Entropy theory  ``zip`` 包
------------------------------------

 :download:`请点击此处 <../code.zip>`.您将获得Entropy theory  ``zip`` 包

Entropy theory的代码框架如下：

::

	├── ApproximateEntropy.m
	├── DEparameter.m
	├── DistEn.m
	├── MultiDispEn.m
	├── MultiscaleFuzzyEntropy_pdist_paran.m
	├── MultiscalePermutationEntropy.m
	├── N205.mat
	├── README.md
	├── SampleEntropy.m
	├── code_MSDE
	│   ├── MultiscaleSymbolicDynamicEntropy.m
	│   ├── PartitionGeneration.m
	│   ├── SymbolEntropy.m
	│   └── SymbolGeneration.m
	├── code_MSDE.zip
	├── main.asv
	└── main.m

