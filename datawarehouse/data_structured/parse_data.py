import pandas as pd
def parse_taobao_data():
    # 使用原始字符串避免反斜杠转义问题
    df_taobao = pd.read_csv(r"C:\Users\lilyung\Documents\trae_projects\dataWarehouse\datawarehouse\data_structured\淘宝.txt",
                            sep='#',lineterminator='\n')
    # 显示前几行数据
    print(df_taobao.head())

if __name__ == '__main__':
    parse_taobao_data()