import os
import sys
from PIL import Image

def delete_images_by_size(directory, width=1200, height=630):
    """
    批量检测并删除指定大小的图片
    
    Args:
        directory: 图片目录路径
        width: 目标宽度 (默认 1200)
        height: 目标高度 (默认 630)
    """
    if not os.path.exists(directory):
        print(f"错误：目录不存在 - {directory}")
        return
    
    supported_extensions = {'.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp', '.tiff', '.tif'}
    
    deleted_count = 0
    total_count = 0
    files_to_delete = []
    
    print(f"开始扫描目录：{directory}")
    print(f"目标尺寸：{width}x{height}")
    print("-" * 60)
    
    for filename in os.listdir(directory):
        file_path = os.path.join(directory, filename)
        
        if not os.path.isfile(file_path):
            continue
        
        ext = os.path.splitext(filename)[1].lower()
        if ext not in supported_extensions:
            continue
        
        total_count += 1
        
        try:
            with Image.open(file_path) as img:
                if img.width == width and img.height == height:
                    print(f"[匹配] {filename} ({img.width}x{img.height})")
                    files_to_delete.append(file_path)
                else:
                    print(f"[跳过] {filename} ({img.width}x{img.height})")
        except Exception as e:
            print(f"[错误] {filename}: {str(e)}")
    
    print("-" * 60)
    
    if files_to_delete:
        print(f"正在删除 {len(files_to_delete)} 个匹配的文件...")
        for file_path in files_to_delete:
            try:
                os.remove(file_path)
                print(f"  ✓ 已删除：{file_path}")
                deleted_count += 1
            except Exception as e:
                print(f"  ✗ 删除失败：{file_path}")
                print(f"    错误：{str(e)}")
    
    print("-" * 60)
    print("扫描完成!")
    print(f"检查的图片数：{total_count}")
    print(f"删除的图片数：{deleted_count}")
    print(f"保留的图片数：{total_count - deleted_count}")
    print("-" * 60)
    input("按回车键退出...")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        target_directory = sys.argv[1]
    else:
        target_directory = os.path.dirname(os.path.abspath(sys.executable if getattr(sys, 'frozen', False) else __file__))
    
    delete_images_by_size(target_directory)
