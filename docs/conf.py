# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'Entropy theory'
copyright = '2022, IMLAB'
author = 'IMLAB'
release = '1.0'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = []

templates_path = ['_templates']
exclude_patterns = []

language = 'zh_CN'

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']
# 定义的插件，分别是支持markdown的插件和支持markdown表格的插件
# pip insatll recommonmark
# pip install sphinx_markdown_tables
extensions = ['recommonmark','sphinx_markdown_tables']

# 解析文件格式
source_suffix = {'.rst': 'restructuredtext','.md': 'markdown'}
