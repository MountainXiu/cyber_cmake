# cyber for cmake
use cmake to build cyber and test on ubuntu18.04 ok.

# 安装依赖库
依赖库按照apollo v6.0.0版本进行安装。**注意** 安装路径最好选择"/usr/local"。

# 使用
```bash
cd ug_cyber
mkdir build 
cd build 
cmake .. 
make -j8
```

# 设置环境变量
```bash
source scripts/setup.bash
```
