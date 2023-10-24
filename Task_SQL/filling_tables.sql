--Вставка отделов
INSERT INTO Departments (name)
VALUES 
('Снабжение'),
('Разработка'),
('Логистика');

--Вставка должностей
INSERT INTO Positions (title)
VALUES 
('Менеджер'),
('Дизайнер');

--Вставка зарплат
INSERT INTO Salary (salary, effective_date)
VALUES
(60000.00, '2020-01-01'),
(70000.00, '2020-01-01'),
(80000.00, '2020-01-01'),
(90000.00, '2020-01-01'),
(100000.00, '2020-01-01'),
(110000.00, '2020-01-01');

--Вставка сотрудников
INSERT INTO Employees (full_name)
VALUES
('Серик Сериков'), -- Дизайнер Разработка 2020-02-20
('Берик Бериков'), -- Менеджер Разработка 2020-03-20
('Мурат Муратов'), -- Менеджер Логистика 2021-06-20
('Дерик Сериков'),-- Менеджер Разработка 2021-08-10
('Батыр Нурланов'), -- Менеджер Логистика 2021-09-12
('Кайрат Усман'), -- Дизайнер Разработка 2022-02-12
('Серик Бахыт'), -- Менеджер Снабжение 2020-11-20
('Султан Галымов'); -- Менеджер Снабжение 2022-05-15

--Заподнение таблицы Staff info 
--Ввод сотрудника Серик Сериков
INSERT INTO staff_info (date_start, employee_id, position_id, department_id, salary_id)
VALUES ('2020-02-20',
(SELECT id FROM Employees WHERE full_name='Серик Сериков'),
(SELECT id FROM Positions WHERE title='Дизайнер'),
(SELECT id FROM Departments WHERE name='Разработка'),
(SELECT id FROM Salary WHERE salary=110000.00));

--Ввод сотрудника Берик Бериков
INSERT INTO staff_info (date_start, employee_id, position_id, department_id, salary_id)
VALUES ('2020-03-20',
(SELECT id FROM Employees WHERE full_name='Берик Бериков'),
(SELECT id FROM Positions WHERE title='Менеджер'),
(SELECT id FROM Departments WHERE name='Разработка'),
(SELECT id FROM Salary WHERE salary=100000.00));

--Ввод сотрудника Мурат Муратов
INSERT INTO staff_info (date_start, employee_id, position_id, department_id, salary_id)
VALUES ('2021-06-20',
(SELECT id FROM Employees WHERE full_name='Мурат Муратов'),
(SELECT id FROM Positions WHERE title='Менеджер'),
(SELECT id FROM Departments WHERE name='Логистика'),
(SELECT id FROM Salary WHERE salary=80000.00));

--Ввод сотрудника Дерик Сериков
INSERT INTO staff_info (date_start, employee_id, position_id, department_id, salary_id)
VALUES ('2021-08-10',
(SELECT id FROM Employees WHERE full_name='Дерик Сериков'),
(SELECT id FROM Positions WHERE title='Менеджер'),
(SELECT id FROM Departments WHERE name='Разработка'),
(SELECT id FROM Salary WHERE salary=90000.00));

--Ввод сотрудника Батыр Нурланов
INSERT INTO staff_info (date_start, employee_id, position_id, department_id, salary_id)
VALUES ('2021-09-12',
(SELECT id FROM Employees WHERE full_name='Батыр Нурланов'),
(SELECT id FROM Positions WHERE title='Менеджер'),
(SELECT id FROM Departments WHERE name='Логистика'),
(SELECT id FROM Salary WHERE salary=70000.00));

--Ввод сотрудника Кайрат Усман
INSERT INTO staff_info (date_start, employee_id, position_id, department_id, salary_id)
VALUES ('2022-02-12',
(SELECT id FROM Employees WHERE full_name='Кайрат Усман'),
(SELECT id FROM Positions WHERE title='Дизайнер'),
(SELECT id FROM Departments WHERE name='Разработка'),
(SELECT id FROM Salary WHERE salary=60000.00));

--Ввод сотрудника Серик Бахыт
INSERT INTO staff_info (date_start, employee_id, position_id, department_id, salary_id)
VALUES ('2020-11-20',
(SELECT id FROM Employees WHERE full_name='Серик Бахыт'),
(SELECT id FROM Positions WHERE title='Менеджер'),
(SELECT id FROM Departments WHERE name='Снабжение'),
(SELECT id FROM Salary WHERE salary=90000.00));

--Ввод сотрудника Султан Галымов
INSERT INTO staff_info (date_start, employee_id, position_id, department_id, salary_id)
VALUES ('2022-05-15',
(SELECT id FROM Employees WHERE full_name='Султан Галымов'),
(SELECT id FROM Positions WHERE title='Менеджер'),
(SELECT id FROM Departments WHERE name='Снабжение'),
(SELECT id FROM Salary WHERE salary=60000.00));