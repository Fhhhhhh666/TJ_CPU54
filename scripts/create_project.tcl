# scripts/create_project.tcl

# —— 配置区 —— 
# 工程名（不带路径）
set PROJECT_NAME MIPS_CPU54
# 顶层 HDL 文件名，不含路径后缀
set TOP_MODULE sccomp_dataflow
# FPGA 器件型号
set PART xc7a100tcsg324-1
# 代码、约束、仿真文件所在目录（相对于本脚本位置）
set SRC_DIR  ../src
set XDC_DIR  ../constraints
set SIM_DIR  ../sim

# —— 脚本区 —— 
# 1. 创建项目
create_project $PROJECT_NAME . -part $PART

# 2. 添加 RTL 源码
file glob -nocomplain $SRC_DIR/*.{v,sv,vhd} | foreach f {add_files $f}

# 3. 添加约束
file glob -nocomplain $XDC_DIR/*.xdc         | foreach f {add_files -fileset constrs_1 $f}

# 4. 添加仿真
file glob -nocomplain $SIM_DIR/*.{v,sv}      | foreach f {add_files -fileset sim_1 $f}

# 5. 设定顶层
set_property top $TOP_MODULE [current_fileset]

# 6. 更新编译次序并保存
update_compile_order -fileset sources_1
save_project
puts "✅ Vivado project '$PROJECT_NAME' created successfully."