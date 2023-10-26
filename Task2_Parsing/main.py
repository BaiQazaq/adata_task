import requests, json, time
from bs4 import BeautifulSoup
import pandas as pd
from openpyxl.workbook import Workbook
from data_preparing import headers


with open("units.json") as f:
    units = json.load(f)

cnt = 0
all_units = []
err = {}

# перебираем все ссылки по компаниям и заходим на каждую из них и делаем выборку необходимых данных
def collect_info(dict):
    for name, href in dict.items():
        req = requests.get(url=href, headers=headers, verify=False)
        src = req.text
        soup = BeautifulSoup(src, "lxml")
        try:
            idbin = soup.find("th", text="БИН участника").find_next().text
            boss = soup.find("th", text="ФИО").find_next().text
            boss_inn = soup.find("th", text="ИИН").find_next().text
            address = soup.find("th", text="Тип адреса").find_next("td").find_next().find_next().text.strip()
            all_units.append({
                "Наименование организации" : name,
                "БИН организации": idbin,
                "ФИО руководителя": boss,
                "ИИН руководителя":boss_inn,
                "Полный адресс": address
            })
        except AttributeError:
            print(AttributeError)
            err.update({name: href})
            
        cnt += 1
        time.sleep(1)
        if cnt % 10 == 0:
            time.sleep(5)
        if cnt % 50 == 0:
            time.sleep(30)

collect_info(units)

with open("data/err.json", "w") as f:
    json.dump(err, f, indent=4, ensure_ascii=False)

# создаем объект Pandas 
df = pd.DataFrame(all_units)

# Удаление дубликатов
df = df.drop_duplicates()

# Сохранение данных в файл Excel
df.to_excel("data/registry_data.xlsx", index=False)
