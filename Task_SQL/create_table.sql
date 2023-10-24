-- 1. Создание таблицы "Departments" для хранения отделов
CREATE TABLE IF NOT EXISTS Departments (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(50) NOT NULL
);

-- 2. Создание таблицы "Employees" для хранения информации о сотрудниках
CREATE TABLE IF NOT EXISTS Employees (
    id SERIAL PRIMARY KEY NOT NULL,
    full_name VARCHAR(150) NOT NULL
);

-- 3. Создание таблицы "Positions" для учета различных должностей
CREATE TABLE IF NOT EXISTS Positions (
    id SERIAL PRIMARY KEY NOT NULL,
    title VARCHAR(50) NOT NULL
);

-- 4. Создание таблицы "Salary" для фиксации изменений по заработной плате сотрудников
CREATE TABLE IF NOT EXISTS Salary (
    id SERIAL PRIMARY KEY NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    effective_date DATE NOT NULL -- дата вступдения в силу
);

-- 5. Создание таблицы "STAFF_INFO" для связи сотрудников с их должностями
CREATE TABLE IF NOT EXISTS staff_info (
    id SERIAL PRIMARY KEY NOT NULL,
    date_start DATE NOT NULL, -- дата начала работы на данной должности данного сотрудника
    date_finish DATE DEFAULT NULL, -- дата ухода из данной должности данного сотрудника
    employee_id INT REFERENCES Employees(id) ON DELETE SET NULL,
    position_id INT REFERENCES Positions(id) ON DELETE SET NULL,
    department_id INT REFERENCES Departments(id) ON DELETE SET NULL,
    salary_id INT REFERENCES Salary(id) ON DELETE SET NULL
);