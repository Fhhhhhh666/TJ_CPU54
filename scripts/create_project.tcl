# —— 配置区 —— 
set PROJECT_NAME  CPU54
set TOP_MODULE    sccomp_dataflow
set PART          xc7a100tcsg324-1

# 代码、约束、仿真文件所在目录（相对脚本）
set SRC_DIR       ../src
set XDC_DIR       ../constraints
set SIM_DIR       ../sim

# —— 脚本区 —— 

# 1. 创建 Vivado 工程
create_project $PROJECT_NAME . -part $PART

# 2. 添加 RTL 源码 (*.v, *.sv, *.vhd)
#    注意：使用 Tcl 的 top-level 命令 glob，而不是 file glob
set rtl_files [glob -nocomplain \
    "$SRC_DIR/*.v" \
    "$SRC_DIR/*.sv" \
    "$SRC_DIR/*.vhd" ]
foreach f $rtl_files {
    add_files $f
    puts "Added RTL: $f"
}

# 3. 添加约束文件 (*.xdc)
set xdc_files [glob -nocomplain "$XDC_DIR/*.xdc"]
foreach f $xdc_files {
    add_files -fileset constrs_1 $f
    puts "Added XDC: $f"
}

# 4. 添加仿真文件 (*.v, *.sv)
set sim_files [glob -nocomplain \
    "$SIM_DIR/*.v" \
    "$SIM_DIR/*.sv" ]
foreach f $sim_files {
    add_files -fileset sim_1 $f
    puts "Added SIM: $f"
}

# 5. 设定顶层模块
set_property top $TOP_MODULE [current_fileset]

# 6. 更新编译次序并保存
update_compile_order -fileset sources_1

# 7.显式保存项目
save_project_as $PROJECT_NAME

puts "\n✅ Vivado project '$PROJECT_NAME' created successfully."
