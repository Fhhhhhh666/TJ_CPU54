# 单周期-CPU54
本项目使用前注意事项：

更新时间：2025-7-22

**仅供参考！！！**


**请勿抄袭！！！**

>如果有问题，可以通过<1801493919@qq.com>联系我（不一定回 :shushing_face: ）

## 项目简介
使用**Verilog HDL**语言实现54条MIPS指令的单周期CPU的设计和仿真。

具体设计思路可以参考仓库内的 [数据通路图](https://github.com/Fhhhhhh666/TJ_CPU54/blob/main/%E6%95%B0%E6%8D%AE%E9%80%9A%E8%B7%AF.png)，由于只采用了二选一多路选择器，所以设计图比较复杂。

## 下载与使用
1. 克隆项目：
```bash
git clone https://github.com/Fhhhhhh666/TJ_CPU54.git
```
2. 进入项目目录
```bash
cd TJ_CPU54
```
3. 新建文件夹`project`用于存储项目
```bash
mkdir project
cd project
```

4. 使用 Vivado 命令行工具运行 Tcl 脚本(确定`...\Vivado\2016.2\bin`已加入到系统变量`path`中)
```bash
vivado -mode tcl -source ../scripts/create_project.tcl
```
- 如果卡了,就在任务管理器中结束任务，重新再试一次


## 提醒
- `mips_54_mars_simulate_student_ForWeb_2024.coe` 增加了对中断的检验，需要注意中断后的跳转（实验指导书会给出异常函数处理地址）
- 这一届的单周期 测试文件`mips_54_mars_simulate_student_ForWeb_2024.coe` 文件中并没有包含对`div` `divu`指令的测试。
- `DIV` `DIVU` `MULT` `MULTU` 模块理论上应该是多周期的，课程群里老师回答说：
    >选择做单周期CPU的同学请注意，乘除法指令是多个周期完成的，需要利用乘除法器的busy信号来指示运算是否完成。

    但如果这样做的话，很有可能会被MIPS网站误判，因为这样会导致其生成的比对文件`result`中乘除法指令的`pc` 、`instr`等被打印多次，最后一次才是要比对的结果，而提供的标准比对文件乘除法指令的`pc` 、`instr`等只会打印最终结果。

    为了避免麻烦，
    - 我将原先`MULT` `MULTU`中的 多周期代码注释掉，改为了单周期，`DIV` `DIVU`没改是因为测试文件`mips_54_mars_simulate_student_ForWeb_2024.coe` 文件中并没有包含对`div` `divu`指令的测试。
    - 对`HILO`模块进行修改。
    - 删掉了`PC`模块的busy信号

    仓库的代码都是修改后的已提交且AC的代码。如果想尝试乘除指令多周期的，可以根据注释改回去。
## 最后
好心人，给个star吧 :grin: