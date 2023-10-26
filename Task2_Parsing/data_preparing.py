import requests, json, time
from bs4 import BeautifulSoup

url = "https://goszakup.gov.kz/ru/registry/rqc"

# Чтобы браузер не ругался
headers = {
    "Accept": "*/*",
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15",
}
lst_pgs_name = []
def first_pages_code():
    # Первый запрос для получения кода первой страницы
    req = requests.get(url, headers=headers, verify=False)
    src = req.text

    # сохраняем код первой страницы для избежания капчи
    with open("index.html", "w") as f:
        f.write(src)
    
    # lst_pgs_name.append("index.html")

def all_pages_create():
    # открываем код первой страницы локально и сохраняем а переменной
    with open("index.html") as f:
        src = f.read()


    soup = BeautifulSoup(src, "lxml")

    # находим все ссылки после класса active  для в циклк выбираем необходимые
    next_pgs_links = soup.find("li", class_="active").find("a", text="1").find_all_next("a")
    cnt_pg_num = 2
    lst_pgs_links = []

    for item in next_pgs_links:
        if (item.text).isdigit():  # если текст ссылки число
            if int(item.text) == cnt_pg_num <= 7:
                pgs_num = item.text.strip()
                item_href = item.get("href")  # c помощью get получаем ссылку на следующую странцу в пагинации 
                req = requests.get(url=item_href, headers=headers, verify=False) # по ссылке получаем код страницы
                src = req.text
                with open(f"index{cnt_pg_num}.html", "w") as f: # сохраняем код страницы в отдельный html файл для работы сней в оффлайн
                    f.write(src)
                lst_pgs_name.append(f"index{cnt_pg_num}.html")  # добавляем в список имена файлов
                cnt_pg_num += 1
                time.sleep(10) # для снижения вероятности срабатывания капчи или бана
            if cnt_pg_num > 7:
                break
    lst_pgs_name = ["index.html", "index2.html", "index3.html", "index4.html", "index5.html", "index6.html", "index7.html",]

units = {}
def companys_links():
    # собираем ссылки на каждую компанию и сохраняем в файл
    for name in lst_pgs_name:
        with open(f"{name}") as f:
            src = f.read()
        soup = BeautifulSoup(src, "lxml")
        all_company_hrefs = soup.find("tbody").find_all("a")
        for item in all_company_hrefs:
            item_text = item.text.strip()
            item_href = item.get("href")
            units[item_text] = item_href

    with open("units.json", "w") as f:
        json.dump(units, f, indent=4, ensure_ascii=False)

if __name__ == '__main__':
    first_pages_code()
    all_pages_create()
    companys_links()