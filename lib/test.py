import requests


res = requests.get(
    'https://script.google.com//macros/s/AKfycbxC9XgKgEi-hlv59HZxmdXO1VwK2054wauOFuQMSi7wYylewjjenFxJ9gCdM_8TPHAG/exec', params={
        "type": "update",
        "id": 21,
        "name": 'artemki77',
        "score": 100
      }
)
print(res.text)