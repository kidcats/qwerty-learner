import csv
import json
import os

def csv_to_json(csv_file_path, json_file_path):
    # 读取CSV文件
    with open(csv_file_path, 'r', encoding='utf-8') as csv_file:
        csv_reader = csv.DictReader(csv_file)
        data = []
        for row in csv_reader:
            # 创建符合目标格式的字典
            entry = {
                "name": row['word'],
                "trans": [row['translation']]
            }
            data.append(entry)
    
    # 确保目标目录存在
    os.makedirs(os.path.dirname(json_file_path), exist_ok=True)
    
    # 写入JSON文件
    with open(json_file_path, 'w', encoding='utf-8') as json_file:
        json.dump(data, json_file, ensure_ascii=False, indent=2)

# 使用函数
input_csv = 'relingo.csv'  # 请确保这是您的输入CSV文件的正确路径
output_json = '../public/dicts/relingo.json'  # 指定的输出路径

csv_to_json(input_csv, output_json)

print(f"CSV to JSON conversion completed successfully! JSON file saved at: {output_json}")