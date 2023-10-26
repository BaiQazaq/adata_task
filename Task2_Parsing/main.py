import requests
from bs4 import BeautifulSoup
import json
import pandas as pd
from openpyxl.workbook import Workbook
from data_preparing import headers


with open("units.json") as f:
    units_50 = json.load(f)

cnt = 0
all_units = []

# перебираем все ссылки по компаниям и заходим на каждую из них и делаем выборку необходимых данных
for name, href in units_50.items():
    req = requests.get(url=href, headers=headers, verify=False)
    src = req.text
    soup = BeautifulSoup(src, "lxml")
    try:
        idbin = soup.find("th", text="БИН участника").find_next().text
    except AttributeError:
        print(AttributeError)
        with open(f"data/{cnt}_{name}.html", "w") as f: # в случае срабатывания ошибки сохраняем код страницы, чтобы разобраться в характере ошибки
            f.write(src)
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

    cnt += 1

# создаем объект Pandas 
df = pd.DataFrame(all_units)

# Удаление дубликатов
df = df.drop_duplicates()

# Сохранение данных в файл Excel
df.to_excel("data/registry_data.xlsx", index=False)
