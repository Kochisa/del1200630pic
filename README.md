# 图片批量删除工具 (1200x630)

批量检测并删除目录下指定尺寸（1200x630）的图片工具。

## 功能特点

- ✅ 自动检测 exe 所在目录，无需手动输入路径
- ✅ 支持多种图片格式：JPG, JPEG, PNG, GIF, BMP, WEBP, TIFF, TIF
- ✅ 显示详细的执行日志和统计信息
- ✅ 执行完成后显示结果并等待确认

## 使用方法

### 方法 1：使用 EXE 文件（推荐）

1. 将 `DeleteImages1200x630.exe` 放到要处理的图片文件夹
2. 双击运行 exe
3. 查看执行日志
4. 按回车键确认退出

### 方法 2：使用 PowerShell 脚本（无需依赖）

```powershell
.\delete_1200x630.ps1 -Directory "图片文件夹路径"
```

### 方法 3：使用 Python 脚本

```bash
# 安装依赖
pip install Pillow

# 运行脚本
python delete_1200x630.py "图片文件夹路径"
```

## 文件说明

- `delete_1200x630.py` - Python 源代码
- `delete_1200x630.ps1` - PowerShell 版本（无需依赖）
- `DeleteImages1200x630.exe` - 打包好的 Windows 可执行文件
- `使用说明.txt` - 详细使用说明

## 打包 EXE

如果需要重新打包 EXE：

```bash
# 安装依赖
pip install Pillow
pip install pyinstaller

# 打包（带控制台窗口）
python -m PyInstaller --onefile --name "DeleteImages1200x630" delete_1200x630.py

# 打包（无控制台窗口）
python -m PyInstaller --onefile --noconsole --name "DeleteImages1200x630" delete_1200x630.py
```

## 注意事项

⚠️ **删除操作不可恢复**，使用前请备份重要图片！

## License

MIT
