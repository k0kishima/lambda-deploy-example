import json
import numpy as np
import pandas as pd
from mypackage.helper import custom_function

# NOTE: 依存パッケージを含めて関数をアーカイブしてデプロイができるかをチェックすることが肝要なので内容は適当
def lambda_handler(event, context):
    array = np.array([1, 2, 3, 4, 5])
    array_sum = np.sum(array).item()

    df = pd.DataFrame({
        'A': [1, 2, 3],
        'B': [4, 5, 6]
    })
    df_sum = df.sum().to_dict()

    custom_message = custom_function()

    return {
        'statusCode': 200,
        'body': json.dumps({
            'numpy_sum': array_sum,
            'pandas_sum': df_sum,
            'custom_message': custom_message
        })
    }
