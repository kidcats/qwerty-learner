#!/bin/bash

cd "$(dirname "$0")"

# 判断是否安装了 Node
if ! command -v node &> /dev/null; then
    echo "未检测到nodejs环境，尝试使用apt安装..."
    # 检查是否有root权限
    if [ "$EUID" -ne 0 ]; then 
        echo "请使用sudo运行此脚本以安装nodejs"
        exit
    fi
    # 更新包列表
    apt update
    # 安装Node.js和npm
    apt install -y nodejs npm
fi

# 安装yarn
if ! command -v yarn &> /dev/null; then
    echo "未检测到yarn，正在安装..."
    if [ "$EUID" -ne 0 ]; then 
        echo "请使用sudo运行此脚本以安装yarn"
        exit
    fi
    npm install -g yarn
fi

# 激活conda环境
echo "激活conda环境py37..."
source ~/anaconda3/etc/profile.d/conda.sh
conda activate py37

# 执行Python脚本
echo "执行Python脚本..."
python csv2json.py

cd ..
echo "开始安装依赖..."
yarn install
echo "依赖安装完成，启动程序..."

# 在默认浏览器中打开
xdg-open http://localhost:5173/ &

# 本地开启服务
npm run dev -- --host

# 返回原始目录并退出
cd "$(dirname "$0")"
