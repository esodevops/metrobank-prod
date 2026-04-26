-- Data Manipulation Language

-- Insert Data Into Tables: Insert Statement

INSERT INTO
    branches (
        branch_id,
        branch_name,
        branch_address,
        branch_num
    )
VALUES
    (
        1,
        'London Central Branch',
        '221B Baker Street, London',
        'ENG-BR-001'
    ),
    (
        2,
        'Manchester North Branch',
        '14 Deansgate, Manchester',
        'ENG-BR-002'
    ),
    (
        3,
        'Birmingham City Branch',
        '52 New Street, Birmingham',
        'ENG-BR-003'
    ),
    (
        4,
        'Liverpool Dock Branch',
        '8 Albert Dock, Liverpool',
        'ENG-BR-004'
    ),
    (
        5,
        'Leeds South Branch',
        '99 Briggate, Leeds',
        'ENG-BR-005'
    ),
    (
        6,
        'Bristol Avon Branch',
        '17 Park Street, Bristol',
        'ENG-BR-006'
    ),
    (
        7,
        'Newcastle Tyne Branch',
        '43 Grey Street, Newcastle',
        'ENG-BR-007'
    ),
    (
        8,
        'Nottingham Lace Branch',
        '31 Market Square, Nottingham',
        'ENG-BR-008'
    );

-- Customers (40 rows)
INSERT INTO
    customers (
        customer_id,
        first_name,
        last_name,
        date_of_birth,
        address,
        phone_number,
        city
    )
VALUES
    (
        1001,
        'Oliver',
        'Smith',
        '1988-03-12',
        '12 King Road',
        '0711000001',
        'London'
    ),
    (
        1002,
        'Amelia',
        'Jones',
        '1992-07-21',
        '44 Queen Street',
        '0711000002',
        'Manchester'
    ),
    (
        1003,
        'George',
        'Taylor',
        '1985-01-09',
        '7 Regent Avenue',
        '0711000003',
        'Birmingham'
    ),
    (
        1004,
        'Isla',
        'Brown',
        '1996-11-28',
        '19 Victoria Lane',
        '0711000004',
        'Liverpool'
    ),
    (
        1005,
        'Harry',
        'Wilson',
        '1989-05-15',
        '5 Orchard Close',
        '0711000005',
        'Leeds'
    ),
    (
        1006,
        'Ava',
        'Evans',
        '1994-04-04',
        '81 Station Road',
        '0711000006',
        'Bristol'
    ),
    (
        1007,
        'Noah',
        'Thomas',
        '1991-09-19',
        '63 Hill View',
        '0711000007',
        'Newcastle'
    ),
    (
        1008,
        'Mia',
        'Roberts',
        '1998-06-02',
        '10 Meadow Way',
        '0711000008',
        'Nottingham'
    ),
    (
        1009,
        'Jack',
        'Johnson',
        '1987-12-23',
        '25 Elm Street',
        '0711000009',
        'London'
    ),
    (
        1010,
        'Sophia',
        'Lewis',
        '1993-08-30',
        '90 Brookside',
        '0711000010',
        'Manchester'
    ),
    (
        1011,
        'Charlie',
        'Walker',
        '1986-10-14',
        '16 Willow Drive',
        '0711000011',
        'Birmingham'
    ),
    (
        1012,
        'Grace',
        'Hall',
        '1995-02-18',
        '77 Oak Avenue',
        '0711000012',
        'Liverpool'
    ),
    (
        1013,
        'Alfie',
        'Allen',
        '1990-03-27',
        '3 Cedar Court',
        '0711000013',
        'Leeds'
    ),
    (
        1014,
        'Lily',
        'Young',
        '1997-01-11',
        '58 Pine Grove',
        '0711000014',
        'Bristol'
    ),
    (
        1015,
        'Oscar',
        'Harris',
        '1984-09-07',
        '46 Rose Lane',
        '0711000015',
        'Newcastle'
    ),
    (
        1016,
        'Freya',
        'King',
        '1999-12-05',
        '22 Maple Street',
        '0711000016',
        'Nottingham'
    ),
    (
        1017,
        'Leo',
        'Wright',
        '1983-06-16',
        '61 Crescent Road',
        '0711000017',
        'London'
    ),
    (
        1018,
        'Ella',
        'Green',
        '1991-11-03',
        '14 Riverbank',
        '0711000018',
        'Manchester'
    ),
    (
        1019,
        'Arthur',
        'Baker',
        '1988-02-25',
        '88 The Mews',
        '0711000019',
        'Birmingham'
    ),
    (
        1020,
        'Evie',
        'Adams',
        '1996-05-13',
        '35 Ash Terrace',
        '0711000020',
        'Liverpool'
    ),
    (
        1021,
        'Theodore',
        'Nelson',
        '1982-07-17',
        '9 Rowan Road',
        '0711000021',
        'Leeds'
    ),
    (
        1022,
        'Poppy',
        'Campbell',
        '1994-10-09',
        '74 Plum Close',
        '0711000022',
        'Bristol'
    ),
    (
        1023,
        'Thomas',
        'Mitchell',
        '1989-08-22',
        '41 Cherry Way',
        '0711000023',
        'Newcastle'
    ),
    (
        1024,
        'Rosie',
        'Carter',
        '1997-04-26',
        '27 Holly Street',
        '0711000024',
        'Nottingham'
    ),
    (
        1025,
        'Henry',
        'Phillips',
        '1985-12-01',
        '64 Chapel Lane',
        '0711000025',
        'London'
    ),
    (
        1026,
        'Ivy',
        'Parker',
        '1993-03-20',
        '11 Barn Close',
        '0711000026',
        'Manchester'
    ),
    (
        1027,
        'James',
        'Turner',
        '1987-05-31',
        '53 College Road',
        '0711000027',
        'Birmingham'
    ),
    (
        1028,
        'Ruby',
        'Edwards',
        '1998-07-08',
        '38 Market Lane',
        '0711000028',
        'Liverpool'
    ),
    (
        1029,
        'William',
        'Collins',
        '1986-01-29',
        '72 Moor Street',
        '0711000029',
        'Leeds'
    ),
    (
        1030,
        'Sienna',
        'Stewart',
        '1995-09-10',
        '20 Park Lane',
        '0711000030',
        'Bristol'
    ),
    (
        1031,
        'Lucas',
        'Sanchez',
        '1990-11-24',
        '95 Abbey Road',
        '0711000031',
        'Newcastle'
    ),
    (
        1032,
        'Chloe',
        'Morris',
        '1999-02-14',
        '6 Harbour View',
        '0711000032',
        'Nottingham'
    ),
    (
        1033,
        'Mohammed',
        'Rogers',
        '1984-04-01',
        '48 Long Street',
        '0711000033',
        'London'
    ),
    (
        1034,
        'Emily',
        'Reed',
        '1992-06-12',
        '32 Castle Road',
        '0711000034',
        'Manchester'
    ),
    (
        1035,
        'Jacob',
        'Cook',
        '1988-08-05',
        '79 Windmill Way',
        '0711000035',
        'Birmingham'
    ),
    (
        1036,
        'Jessica',
        'Morgan',
        '1996-10-28',
        '13 Chapel Street',
        '0711000036',
        'Liverpool'
    ),
    (
        1037,
        'Alexander',
        'Bell',
        '1983-12-19',
        '54 Garden Close',
        '0711000037',
        'Leeds'
    ),
    (
        1038,
        'Sophie',
        'Murphy',
        '1994-01-30',
        '23 Priory Road',
        '0711000038',
        'Bristol'
    ),
    (
        1039,
        'Ethan',
        'Bailey',
        '1991-03-03',
        '86 Highfield',
        '0711000039',
        'Newcastle'
    ),
    (
        1040,
        'Hannah',
        'Cooper',
        '1997-05-22',
        '40 Mill Lane',
        '0711000040',
        'Nottingham'
    );

-- Employees (20 rows)
INSERT INTO
    employees (
        employee_id,
        first_name,
        last_name,
        position,
        branch_id,
        hire_date
    )
VALUES
    (
        2001,
        'Daniel',
        'Price',
        'Branch Manager',
        1,
        '2015-04-10'
    ),
    (
        2002,
        'Sarah',
        'Ward',
        'Customer Advisor',
        1,
        '2018-09-03'
    ),
    (
        2003,
        'Ryan',
        'Gray',
        'Branch Manager',
        2,
        '2014-01-21'
    ),
    (
        2004,
        'Megan',
        'Brooks',
        'Cashier',
        2,
        '2019-06-18'
    ),
    (
        2005,
        'Adam',
        'Russell',
        'Branch Manager',
        3,
        '2016-03-14'
    ),
    (
        2006,
        'Lauren',
        'Wood',
        'Loan Officer',
        3,
        '2020-02-11'
    ),
    (
        2007,
        'Matthew',
        'Bennett',
        'Branch Manager',
        4,
        '2013-11-07'
    ),
    (
        2008,
        'Abigail',
        'Barnes',
        'Cashier',
        4,
        '2021-08-26'
    ),
    (
        2009,
        'Joseph',
        'Powell',
        'Branch Manager',
        5,
        '2017-05-19'
    ),
    (
        2010,
        'Molly',
        'Fisher',
        'Customer Advisor',
        5,
        '2022-01-05'
    ),
    (
        2011,
        'Samuel',
        'Butler',
        'Branch Manager',
        6,
        '2012-07-09'
    ),
    (
        2012,
        'Lucy',
        'Simpson',
        'Loan Officer',
        6,
        '2018-12-12'
    ),
    (
        2013,
        'Benjamin',
        'Cole',
        'Branch Manager',
        7,
        '2016-10-01'
    ),
    (2014, 'Zoe', 'Hayes', 'Cashier', 7, '2020-04-23'),
    (
        2015,
        'David',
        'Knight',
        'Branch Manager',
        8,
        '2015-02-16'
    ),
    (
        2016,
        'Anna',
        'Ford',
        'Customer Advisor',
        8,
        '2019-09-30'
    ),
    (
        2017,
        'Peter',
        'Marshall',
        'Operations Analyst',
        1,
        '2021-06-15'
    ),
    (
        2018,
        'Rachel',
        'Hunter',
        'Compliance Officer',
        2,
        '2020-10-20'
    ),
    (
        2019,
        'Connor',
        'Dixon',
        'Relationship Manager',
        3,
        '2019-04-01'
    ),
    (
        2020,
        'Natalie',
        'Mills',
        'Risk Analyst',
        4,
        '2022-11-08'
    );

-- Accounts (40 rows)
INSERT INTO
    accounts (
        account_no,
        customer_id,
        branch_id,
        account_type,
        balance,
        date_open
    )
VALUES
    (30001, 1001, 1, 'Savings', 8400.50, '2022-01-10'),
    (30002, 1002, 2, 'Current', 2150.00, '2021-12-01'),
    (
        30003,
        1003,
        3,
        'Savings',
        12000.75,
        '2020-06-14'
    ),
    (30004, 1004, 4, 'Current', 980.40, '2023-03-22'),
    (30005, 1005, 5, 'Savings', 6050.10, '2021-08-17'),
    (30006, 1006, 6, 'Current', 3325.00, '2022-11-05'),
    (30007, 1007, 7, 'Savings', 4590.90, '2019-04-29'),
    (30008, 1008, 8, 'Current', 1875.33, '2023-01-09'),
    (
        30009,
        1009,
        1,
        'Savings',
        15400.20,
        '2018-05-12'
    ),
    (30010, 1010, 2, 'Current', 2640.00, '2020-10-20'),
    (30011, 1011, 3, 'Savings', 7100.00, '2021-07-03'),
    (30012, 1012, 4, 'Current', 920.50, '2022-09-15'),
    (30013, 1013, 5, 'Savings', 8450.80, '2023-02-07'),
    (30014, 1014, 6, 'Current', 1999.99, '2021-01-19'),
    (
        30015,
        1015,
        7,
        'Savings',
        13220.40,
        '2019-11-30'
    ),
    (30016, 1016, 8, 'Current', 1105.65, '2022-04-13'),
    (
        30017,
        1017,
        1,
        'Savings',
        17300.00,
        '2017-07-21'
    ),
    (30018, 1018, 2, 'Current', 2877.70, '2020-02-18'),
    (30019, 1019, 3, 'Savings', 9400.25, '2021-05-09'),
    (30020, 1020, 4, 'Current', 1450.15, '2023-06-11'),
    (
        30021,
        1021,
        5,
        'Savings',
        20800.00,
        '2016-09-08'
    ),
    (30022, 1022, 6, 'Current', 3200.10, '2021-03-27'),
    (30023, 1023, 7, 'Savings', 6700.60, '2022-07-01'),
    (30024, 1024, 8, 'Current', 899.90, '2023-09-14'),
    (
        30025,
        1025,
        1,
        'Savings',
        11150.05,
        '2019-12-19'
    ),
    (30026, 1026, 2, 'Current', 2455.80, '2020-08-31'),
    (30027, 1027, 3, 'Savings', 5020.00, '2022-12-10'),
    (30028, 1028, 4, 'Current', 1600.75, '2023-04-02'),
    (30029, 1029, 5, 'Savings', 7800.88, '2021-10-16'),
    (30030, 1030, 6, 'Current', 1399.45, '2022-02-24'),
    (30031, 1031, 7, 'Savings', 9200.12, '2020-01-06'),
    (30032, 1032, 8, 'Current', 2100.20, '2023-05-20'),
    (30033, 1033, 1, 'Savings', 6400.00, '2021-11-11'),
    (30034, 1034, 2, 'Current', 1750.35, '2022-03-03'),
    (
        30035,
        1035,
        3,
        'Savings',
        12300.99,
        '2018-08-28'
    ),
    (30036, 1036, 4, 'Current', 980.00, '2023-07-07'),
    (
        30037,
        1037,
        5,
        'Savings',
        15880.43,
        '2017-02-15'
    ),
    (30038, 1038, 6, 'Current', 2660.66, '2020-09-09'),
    (30039, 1039, 7, 'Savings', 4800.50, '2022-06-30'),
    (30040, 1040, 8, 'Current', 1333.33, '2023-10-12');

-- Transactions (60 rows)
INSERT INTO
    transactions (
        transaction_id,
        account_no,
        transaction_type,
        amount,
        transaction_date
    )
VALUES
    (
        40001,
        30001,
        'Deposit',
        1200.00,
        '2026-01-02 10:15:00'
    ),
    (
        40002,
        30001,
        'Withdrawal',
        250.00,
        '2026-01-12 16:00:00'
    ),
    (
        40003,
        30002,
        'Deposit',
        600.00,
        '2026-01-05 11:40:00'
    ),
    (
        40004,
        30002,
        'Withdrawal',
        95.00,
        '2026-01-16 09:20:00'
    ),
    (
        40005,
        30003,
        'Deposit',
        900.00,
        '2026-01-07 13:10:00'
    ),
    (
        40006,
        30003,
        'Withdrawal',
        300.00,
        '2026-01-20 14:45:00'
    ),
    (
        40007,
        30004,
        'Deposit',
        400.00,
        '2026-01-09 08:30:00'
    ),
    (
        40008,
        30004,
        'Withdrawal',
        120.00,
        '2026-01-21 18:05:00'
    ),
    (
        40009,
        30005,
        'Deposit',
        700.00,
        '2026-01-10 12:00:00'
    ),
    (
        40010,
        30005,
        'Withdrawal',
        210.00,
        '2026-01-22 15:11:00'
    ),
    (
        40011,
        30006,
        'Deposit',
        500.00,
        '2026-01-11 09:05:00'
    ),
    (
        40012,
        30006,
        'Withdrawal',
        130.00,
        '2026-01-23 16:42:00'
    ),
    (
        40013,
        30007,
        'Deposit',
        450.00,
        '2026-01-12 10:50:00'
    ),
    (
        40014,
        30007,
        'Withdrawal',
        200.00,
        '2026-01-24 14:10:00'
    ),
    (
        40015,
        30008,
        'Deposit',
        550.00,
        '2026-01-13 11:12:00'
    ),
    (
        40016,
        30008,
        'Withdrawal',
        175.00,
        '2026-01-25 17:30:00'
    ),
    (
        40017,
        30009,
        'Deposit',
        1000.00,
        '2026-01-14 09:00:00'
    ),
    (
        40018,
        30009,
        'Withdrawal',
        320.00,
        '2026-01-26 13:55:00'
    ),
    (
        40019,
        30010,
        'Deposit',
        650.00,
        '2026-01-15 10:25:00'
    ),
    (
        40020,
        30010,
        'Withdrawal',
        180.00,
        '2026-01-27 15:45:00'
    ),
    (
        40021,
        30011,
        'Deposit',
        720.00,
        '2026-01-16 08:48:00'
    ),
    (
        40022,
        30011,
        'Withdrawal',
        290.00,
        '2026-01-28 16:17:00'
    ),
    (
        40023,
        30012,
        'Deposit',
        500.00,
        '2026-01-17 12:34:00'
    ),
    (
        40024,
        30012,
        'Withdrawal',
        145.00,
        '2026-01-29 17:59:00'
    ),
    (
        40025,
        30013,
        'Deposit',
        770.00,
        '2026-01-18 09:57:00'
    ),
    (
        40026,
        30013,
        'Withdrawal',
        250.00,
        '2026-01-30 12:10:00'
    ),
    (
        40027,
        30014,
        'Deposit',
        430.00,
        '2026-01-19 11:36:00'
    ),
    (
        40028,
        30014,
        'Withdrawal',
        160.00,
        '2026-01-31 14:40:00'
    ),
    (
        40029,
        30015,
        'Deposit',
        880.00,
        '2026-02-01 10:00:00'
    ),
    (
        40030,
        30015,
        'Withdrawal',
        300.00,
        '2026-02-02 11:20:00'
    ),
    (
        40031,
        30016,
        'Deposit',
        540.00,
        '2026-02-03 08:11:00'
    ),
    (
        40032,
        30016,
        'Withdrawal',
        125.00,
        '2026-02-04 17:33:00'
    ),
    (
        40033,
        30017,
        'Deposit',
        1200.00,
        '2026-02-05 09:49:00'
    ),
    (
        40034,
        30017,
        'Withdrawal',
        410.00,
        '2026-02-06 16:55:00'
    ),
    (
        40035,
        30018,
        'Deposit',
        660.00,
        '2026-02-07 12:22:00'
    ),
    (
        40036,
        30018,
        'Withdrawal',
        190.00,
        '2026-02-08 18:02:00'
    ),
    (
        40037,
        30019,
        'Deposit',
        740.00,
        '2026-02-09 10:45:00'
    ),
    (
        40038,
        30019,
        'Withdrawal',
        280.00,
        '2026-02-10 13:07:00'
    ),
    (
        40039,
        30020,
        'Deposit',
        480.00,
        '2026-02-11 11:14:00'
    ),
    (
        40040,
        30020,
        'Withdrawal',
        150.00,
        '2026-02-12 15:28:00'
    ),
    (
        40041,
        30021,
        'Deposit',
        1300.00,
        '2026-02-13 09:18:00'
    ),
    (
        40042,
        30021,
        'Withdrawal',
        420.00,
        '2026-02-14 14:50:00'
    ),
    (
        40043,
        30022,
        'Deposit',
        570.00,
        '2026-02-15 10:05:00'
    ),
    (
        40044,
        30022,
        'Withdrawal',
        175.00,
        '2026-02-16 16:22:00'
    ),
    (
        40045,
        30023,
        'Deposit',
        690.00,
        '2026-02-17 11:43:00'
    ),
    (
        40046,
        30023,
        'Withdrawal',
        230.00,
        '2026-02-18 17:12:00'
    ),
    (
        40047,
        30024,
        'Deposit',
        360.00,
        '2026-02-19 08:35:00'
    ),
    (
        40048,
        30024,
        'Withdrawal',
        90.00,
        '2026-02-20 12:58:00'
    ),
    (
        40049,
        30025,
        'Deposit',
        940.00,
        '2026-02-21 10:31:00'
    ),
    (
        40050,
        30025,
        'Withdrawal',
        265.00,
        '2026-02-22 15:16:00'
    ),
    (
        40051,
        30026,
        'Deposit',
        620.00,
        '2026-02-23 09:26:00'
    ),
    (
        40052,
        30026,
        'Withdrawal',
        200.00,
        '2026-02-24 14:37:00'
    ),
    (
        40053,
        30027,
        'Deposit',
        710.00,
        '2026-02-25 12:09:00'
    ),
    (
        40054,
        30027,
        'Withdrawal',
        240.00,
        '2026-02-26 16:48:00'
    ),
    (
        40055,
        30028,
        'Deposit',
        530.00,
        '2026-02-27 08:59:00'
    ),
    (
        40056,
        30028,
        'Withdrawal',
        140.00,
        '2026-02-28 13:25:00'
    ),
    (
        40057,
        30029,
        'Deposit',
        760.00,
        '2026-03-01 10:16:00'
    ),
    (
        40058,
        30029,
        'Withdrawal',
        255.00,
        '2026-03-02 17:40:00'
    ),
    (
        40059,
        30030,
        'Deposit',
        490.00,
        '2026-03-03 11:01:00'
    ),
    (
        40060,
        30030,
        'Withdrawal',
        135.00,
        '2026-03-04 15:59:00'
    );

-- Loans (20 rows)
INSERT INTO
    loans (
        loan_id,
        customer_id,
        account_no,
        loan_amount,
        loan_type,
        issue_date,
        int_rate
    )
VALUES
    (
        5001,
        1001,
        30001,
        15000.00,
        'Personal',
        '2024-02-01',
        7.20
    ),
    (
        5002,
        1003,
        30003,
        220000.00,
        'Mortgage',
        '2021-09-15',
        4.10
    ),
    (
        5003,
        1005,
        30005,
        12000.00,
        'Auto',
        '2023-04-10',
        6.80
    ),
    (
        5004,
        1007,
        30007,
        8000.00,
        'Education',
        '2022-08-22',
        5.50
    ),
    (
        5005,
        1009,
        30009,
        50000.00,
        'Business',
        '2020-05-18',
        6.20
    ),
    (
        5006,
        1011,
        30011,
        9500.00,
        'Personal',
        '2024-01-12',
        7.00
    ),
    (
        5007,
        1013,
        30013,
        18000.00,
        'Auto',
        '2023-11-03',
        6.40
    ),
    (
        5008,
        1015,
        30015,
        260000.00,
        'Mortgage',
        '2019-07-27',
        3.95
    ),
    (
        5009,
        1017,
        30017,
        30000.00,
        'Business',
        '2021-03-06',
        6.75
    ),
    (
        5010,
        1019,
        30019,
        11000.00,
        'Education',
        '2022-12-14',
        5.85
    ),
    (
        5011,
        1021,
        30021,
        275000.00,
        'Mortgage',
        '2018-10-08',
        3.70
    ),
    (
        5012,
        1023,
        30023,
        7000.00,
        'Personal',
        '2024-03-05',
        7.30
    ),
    (
        5013,
        1025,
        30025,
        14500.00,
        'Auto',
        '2023-05-21',
        6.60
    ),
    (
        5014,
        1027,
        30027,
        40000.00,
        'Business',
        '2022-01-30',
        6.95
    ),
    (
        5015,
        1029,
        30029,
        9000.00,
        'Education',
        '2023-09-19',
        5.65
    ),
    (
        5016,
        1031,
        30031,
        16000.00,
        'Personal',
        '2024-02-23',
        7.10
    ),
    (
        5017,
        1033,
        30033,
        230000.00,
        'Mortgage',
        '2020-11-11',
        4.25
    ),
    (
        5018,
        1035,
        30035,
        21000.00,
        'Auto',
        '2023-01-16',
        6.50
    ),
    (
        5019,
        1037,
        30037,
        55000.00,
        'Business',
        '2021-06-29',
        6.35
    ),
    (
        5020,
        1039,
        30039,
        10500.00,
        'Education',
        '2022-10-02',
        5.90
    );

-- Update Records In Tables: Update Statement

update accounts
set balance = balance + 2800
where account_no = 30001;

-- Delete Records In Tables: Delete Statement
delete from accounts 
where customer_id = 1001;
