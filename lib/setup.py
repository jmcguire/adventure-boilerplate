#!/usr/bin/env python

from distutils.core import setup

setup(
  name='AdventureBoilerplate',
  version='0.1',
  description='Markdown extensions for Adventure Boilerplate',
  author='Justin McGuire',
  author_email='jm@landedstar.com'
  url='https://github.org/jmcguire/adventure-boilerplate',
  packages=['...', '...'],

  py_modules=['mdx_dice'],
  install_requires=['Markdown>=2.0',],
  classifiers=[
    'Development Status :: 2 - Pre-Alpha',
    'Operating System :: OS Independent',
    'License :: OSI Approved :: MIT License',
    'Programming Language :: Python',
    'Topic :: Text Processing :: Filters',
    'Topic :: Text Processing :: Markup :: HTML'
  ]

)

