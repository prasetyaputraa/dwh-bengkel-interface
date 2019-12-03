-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 03, 2019 at 08:56 AM
-- Server version: 5.7.28
-- PHP Version: 7.0.33-13+0~20191128.24+debian9~1.gbp832d85

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_bengkel`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_incomes` (IN `transaction_date` DATE, IN `mode` ENUM("DAY","WEEK","MONTH","YEAR"))  begin
	declare num_rows int;
	
	if mode = "YEAR" then
		SELECT COUNT(*) INTO num_rows FROM transactions WHERE YEAR(transactions.`date`) = YEAR(transaction_date);
		
		if num_rows > 0 then
			select sum(transactions.`total`) as "Income This Year", "" as "Transaction ID", "" as "Customer Name", "" as "Mechanical Name", "" as "Operator Name", "" as "Total Transaction" from transactions where YEAR(transactions.`date`) = YEAR(transaction_date)
			union
			select "", transactions.`id`, customers.`name`, mechanicals.`name`, operators.`name`, sum(transactions.`total`) from employees mechanicals, employees operators, customers, transactions where transactions.`customer_id` = customers.`id` and transactions.`mechanical_id` = mechanicals.`id` and transactions.`operator_id` = operators.`id` and YEAR(transactions.`date`) = YEAR(transaction_date) group by customers.`name`;
		else
			SELECT "There are no transactions on this year!" AS "Error";
		end if;
	elseif mode = "MONTH" then
		SELECT COUNT(*) INTO num_rows FROM transactions WHERE YEAR(transactions.`date`) = YEAR(transaction_date) and month(transactions.`date`) = month(transaction_date);
		
		IF num_rows > 0 THEN
			SELECT SUM(transactions.`total`) AS "Income This Month", "" AS "Transaction ID", "" AS "Customer Name", "" AS "Mechanical Name", "" AS "Operator Name", "" AS "Total Transaction" FROM transactions WHERE YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date)
			UNION
			SELECT "", transactions.`id`, customers.`name`, mechanicals.`name`, operators.`name`, sum(transactions.`total`) FROM employees mechanicals, employees operators, customers, transactions WHERE transactions.`customer_id` = customers.`id` AND transactions.`mechanical_id` = mechanicals.`id` AND transactions.`operator_id` = operators.`id` AND YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) group by customers.`name`;
		ELSE
			SELECT "There are no transactions on this month!" AS "Error";
		END IF;
	elseif mode = "WEEK" then
		SELECT COUNT(*) INTO num_rows FROM transactions WHERE YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) and week(transactions.`date`) = week(transaction_date);
		
		IF num_rows > 0 THEN
			SELECT SUM(transactions.`total`) AS "Income This Week", "" AS "Transaction ID", "" AS "Customer Name", "" AS "Mechanical Name", "" AS "Operator Name", "" AS "Total Transaction" FROM transactions WHERE YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) AND WEEK(transactions.`date`) = WEEK(transaction_date)
			UNION
			SELECT "", transactions.`id`, customers.`name`, mechanicals.`name`, operators.`name`, sum(transactions.`total`) FROM employees mechanicals, employees operators, customers, transactions WHERE transactions.`customer_id` = customers.`id` AND transactions.`mechanical_id` = mechanicals.`id` AND transactions.`operator_id` = operators.`id` AND YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) AND WEEK(transactions.`date`) = WEEK(transaction_date) group by customers.`name`;
		ELSE
			SELECT "There are no transactions on this week!" AS "Error";
		END IF;
	elseif MOdE = "DAY" then
		SELECT COUNT(*) INTO num_rows FROM transactions WHERE transactions.`date` = transaction_date;
		
		IF num_rows > 0 THEN
			SELECT SUM(transactions.`total`) AS "Income Today", "" AS "Transaction ID", "" AS "Customer Name", "" AS "Mechanical Name", "" AS "Operator Name", "" AS "Total Transaction" FROM transactions WHERE transactions.`date` = transaction_date
			UNION
			SELECT "", transactions.`id`, customers.`name`, mechanicals.`name`, operators.`name`, sum(transactions.`total`) FROM employees mechanicals, employees operators, customers, transactions WHERE transactions.`customer_id` = customers.`id` AND transactions.`mechanical_id` = mechanicals.`id` AND transactions.`operator_id` = operators.`id` AND transactions.`date` = transaction_date group by customers.`name`;
		ELSE
			SELECT "There are no transactions today!" AS "Error";
		END IF;
	else
		SELECT "Invalid mode! The available mode are: DAY, WEEK, MONTH!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `count_most_service` (IN `transaction_date` DATE, IN `mode` ENUM("DAY","WEEK","MONTH","YEAR"))  begin
	declare num_rows int;
	
	if mode = "YEAR" then
		select count(*) into num_rows from transactions where year(transactions.`date`) = year(transaction_date);
		
		if num_rows > 0 then
			select services.`id` as "Service ID", services.`service_type` as "Service Type", services.`vehicle_model` as "Service Vehicle Model", services.`price` as "Service Price", count(service_transactions.`service_id`) as "Service Total Transaction" from transactions, service_transactions, services where service_transactions.`transaction_id` = transactions.`id` and service_transactions.`service_id` = services.`id` and year(transactions.`date`) = year(transaction_date) group by services.`id` order by count(service_transactions.`service_id`) desc;
		else
			SELECT "There are no transactions on this year!" AS "Error";
		end if;
	elseif mode = "MONTH" then
		SELECT COUNT(*) INTO num_rows FROM transactions WHERE YEAR(transactions.`date`) = YEAR(transaction_date) and month(transactions.`date`) = month(transaction_date);
		
		IF num_rows > 0 THEN
			SELECT services.`id` AS "Service ID", services.`service_type` AS "Service Type", services.`vehicle_model` AS "Service Vehicle Model", services.`price` AS "Service Price", COUNT(service_transactions.`service_id`) AS "Service Total Transaction" FROM transactions, service_transactions, services WHERE service_transactions.`transaction_id` = transactions.`id` AND service_transactions.`service_id` = services.`id` AND YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) GROUP BY services.`id` ORDER BY COUNT(service_transactions.`service_id`) DESC;
		ELSE
			SELECT "There are no transactions on this month!" AS "Error";
		END IF;
	elseif mode = "WEEK" then
		SELECT COUNT(*) INTO num_rows FROM transactions WHERE YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) and week(transactions.`date`) = week(transaction_date);
		
		IF num_rows > 0 THEN
			SELECT services.`id` AS "Service ID", services.`service_type` AS "Service Type", services.`vehicle_model` AS "Service Vehicle Model", services.`price` AS "Service Price", COUNT(service_transactions.`service_id`) AS "Service Total Transaction" FROM transactions, service_transactions, services WHERE service_transactions.`transaction_id` = transactions.`id` AND service_transactions.`service_id` = services.`id` AND YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) AND WEEK(transactions.`date`) = WEEK(transaction_date) GROUP BY services.`id` ORDER BY COUNT(service_transactions.`service_id`) DESC;
		ELSE
			SELECT "There are no transactions on this week!" AS "Error";
		END IF;
	elseif mode = "DAY" then
		SELECT COUNT(*) INTO num_rows FROM transactions WHERE transactions.`date` = transaction_date;
		
		IF num_rows > 0 THEN
			SELECT services.`id` AS "Service ID", services.`service_type` AS "Service Type", services.`vehicle_model` AS "Service Vehicle Model", services.`price` AS "Service Price", COUNT(service_transactions.`service_id`) AS "Service Total Transaction" FROM transactions, service_transactions, services WHERE service_transactions.`transaction_id` = transactions.`id` AND service_transactions.`service_id` = services.`id` AND transactions.`date` = transaction_date GROUP BY services.`id` ORDER BY COUNT(service_transactions.`service_id`) DESC;
		ELSE
			SELECT "There are no transactions today!" AS "Error";
		END IF;
	else
		SELECT "Invalid mode! The available mode are: DAY, WEEK, MONTH!" AS "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `count_most_sparepart` (IN `transaction_date` DATE, IN `MODE` ENUM("DAY","WEEK","MONTH","YEAR"))  BEGIN
	DECLARE num_rows INT;
	
	IF MODE = "YEAR" THEN
		SELECT COUNT(*) INTO num_rows FROM transactions WHERE YEAR(transactions.`date`) = YEAR(transaction_date);
		
		IF num_rows > 0 THEN
			SELECT spareparts.`id` AS "Sparepart ID", spareparts.`sparepart_name` AS "Sparepart Name", spareparts.`sparepart_type` AS "Sparepart Type", spareparts.`stock` AS "Sparepart Stock", spareparts.`price` AS "Sparepart Price", SUM(sparepart_transactions.`qty`) AS "Sparepart Total Transaction" FROM transactions, sparepart_transactions, spareparts WHERE sparepart_transactions.`transaction_id` = transactions.`id` AND sparepart_transactions.`sparepart_id` = spareparts.`id` AND YEAR(transactions.`date`) = YEAR(transaction_date) GROUP BY spareparts.`id` ORDER BY SUM(sparepart_transactions.`qty`) DESC;
		ELSE
			SELECT "There are no transactions on this year!" AS "Error";
		END IF;
	ELSEIF MODE = "MONTH" THEN
		SELECT COUNT(*) INTO num_rows FROM transactions WHERE YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date);
		
		IF num_rows > 0 THEN
			SELECT spareparts.`id` AS "Sparepart ID", spareparts.`sparepart_name` AS "Sparepart Name", spareparts.`sparepart_type` AS "Sparepart Type", spareparts.`stock` AS "Sparepart Stock", spareparts.`price` AS "Sparepart Price", SUM(sparepart_transactions.`qty`) AS "Sparepart Total Transaction" FROM transactions, sparepart_transactions, spareparts WHERE sparepart_transactions.`transaction_id` = transactions.`id` AND sparepart_transactions.`sparepart_id` = spareparts.`id` AND YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) GROUP BY spareparts.`id` ORDER BY SUM(sparepart_transactions.`qty`) DESC;
		ELSE
			SELECT "There are no transactions on this month!" AS "Error";
		END IF;
	ELSEIF MODE = "WEEK" THEN
		SELECT COUNT(*) INTO num_rows FROM transactions WHERE YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) AND WEEK(transactions.`date`) = WEEK(transaction_date);
		
		IF num_rows > 0 THEN
			SELECT spareparts.`id` AS "Sparepart ID", spareparts.`sparepart_name` AS "Sparepart Name", spareparts.`sparepart_type` AS "Sparepart Type", spareparts.`stock` AS "Sparepart Stock", spareparts.`price` AS "Sparepart Price", SUM(sparepart_transactions.`qty`) AS "Sparepart Total Transaction" FROM transactions, sparepart_transactions, spareparts WHERE sparepart_transactions.`transaction_id` = transactions.`id` AND sparepart_transactions.`sparepart_id` = spareparts.`id` AND YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) AND WEEK(transactions.`date`) = WEEK(transaction_date) GROUP BY spareparts.`id` ORDER BY SUM(sparepart_transactions.`qty`) DESC;
		ELSE
			SELECT "There are no transactions on this week!" AS "Error";
		END IF;
	ELSEIF MODE = "DAY" THEN
		SELECT COUNT(*) INTO num_rows FROM transactions WHERE transactions.`date` = transaction_date;
		
		IF num_rows > 0 THEN
			SELECT spareparts.`id` AS "Sparepart ID", spareparts.`sparepart_name` AS "Sparepart Name", spareparts.`sparepart_type` AS "Sparepart Type", spareparts.`stock` AS "Sparepart Stock", spareparts.`price` AS "Sparepart Price", SUM(sparepart_transactions.`qty`) AS "Sparepart Total Transaction" FROM transactions, sparepart_transactions, spareparts WHERE sparepart_transactions.`transaction_id` = transactions.`id` AND sparepart_transactions.`sparepart_id` = spareparts.`id` AND transactions.`date` = transaction_date GROUP BY spareparts.`id` ORDER BY SUM(sparepart_transactions.`qty`) DESC;
		ELSE
			SELECT "There are no transactions today!" AS "Error";
		END IF;
	ELSE
		SELECT "Invalid mode! The available mode are: DAY, WEEK, MONTH!" AS "Error";
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `count_nonactive_customer` ()  begin
	declare num_rows int;
	
	select count(*) into num_rows from customers where customers.`status` = "Non-Active";
	
	if num_rows > 0 then
		select num_rows as "Total Non-Active Customers", "" AS "Customer ID", "" AS "Customer Name", "" AS "Customer License Plate", "" AS "Customer Phone Number", "" AS "Customer Address"
		union
		select "", customers.`id`, customers.`name`, customers.`license_plate`, customers.`phone`, customers.`address` from customers where customers.`status` = "Non-Active";
	else
		select "There's no non-active customers!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `count_transactions` (IN `transaction_date` DATE, IN `mode` ENUM("DAY","WEEK","MONTH"))  begin
	declare num_rows int;
	
	if mode = "MONTH" then
		select count(*) into num_rows from service_transactions, transactions where service_transactions.`transaction_id` = transactions.`id` and year(transactions.`date`) = year(transaction_date) and month(transactions.`date`) = month(transaction_date);
		
		if num_rows > 0 then
			select count(*) as "Transactions This Month", sum(service_transactions.`sub_price`) as "Total Transactions", "" as "Transaction ID", "" as "Customer Name", "" as "Mechanical Name", "" as "Operator Name", "" as "Service Sub Price" from service_transactions, transactions WHERE service_transactions.`transaction_id` = transactions.`id` AND YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date)
			union
			select "", "", transactions.`id`, customers.`name`, mechanicals.`name`, operators.`name`, sum(service_transactions.`sub_price`) from employees mechanicals, employees operators, service_transactions, transactions, customers where service_transactions.`transaction_id` = transactions.`id` and transactions.`customer_id` = customers.`id` and transactions.`mechanical_id` = mechanicals.`id` and transactions.`operator_id` = operators.`id` and YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) group by customers.`name`;
		else
			SELECT "There are no transactions on this month!" as "Error";
		end if;
	elseif mode = "WEEK" then
		SELECT COUNT(*) INTO num_rows FROM service_transactions, transactions WHERE service_transactions.`transaction_id` = transactions.`id` AND YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) and week(transactions.`date`) = week(transaction_date);
		
		IF num_rows > 0 THEN
			SELECT COUNT(*) AS "Transactions This Week", SUM(service_transactions.`sub_price`) AS "Total Transactions", "" AS "Transaction ID", "" AS "Customer Name", "" AS "Mechanical Name", "" AS "Operator Name", "" AS "Service Sub Price" FROM service_transactions, transactions WHERE service_transactions.`transaction_id` = transactions.`id` AND YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) AND WEEK(transactions.`date`) = WEEK(transaction_date)
			UNION
			SELECT "", "", transactions.`id`, customers.`name`, mechanicals.`name`, operators.`name`, sum(service_transactions.`sub_price`) FROM employees mechanicals, employees operators, service_transactions, transactions, customers WHERE service_transactions.`transaction_id` = transactions.`id` AND transactions.`customer_id` = customers.`id` AND transactions.`mechanical_id` = mechanicals.`id` AND transactions.`operator_id` = operators.`id` AND YEAR(transactions.`date`) = YEAR(transaction_date) AND MONTH(transactions.`date`) = MONTH(transaction_date) AND WEEK(transactions.`date`) = WEEK(transaction_date) group by customers.`name`;
		ELSE
			SELECT "There are no transactions on this week!" AS "Error";
		END IF;
	elseif MOdE = "DAY" then
		SELECT COUNT(*) INTO num_rows FROM service_transactions, transactions WHERE service_transactions.`transaction_id` = transactions.`id` AND transactions.`date` = transaction_date;
		
		IF num_rows > 0 THEN
			SELECT COUNT(*) AS "Transactions Today", SUM(service_transactions.`sub_price`) AS "Total Transactions", "" AS "Transaction ID", "" AS "Customer Name", "" AS "Mechanical Name", "" AS "Operator Name", "" AS "Service Sub Price" FROM service_transactions, transactions WHERE service_transactions.`transaction_id` = transactions.`id` AND transactions.`date` = transaction_date
			UNION
			SELECT "", "", transactions.`id`, customers.`name`, mechanicals.`name`, operators.`name`, sum(service_transactions.`sub_price`) FROM employees mechanicals, employees operators, service_transactions, transactions, customers WHERE service_transactions.`transaction_id` = transactions.`id` AND transactions.`customer_id` = customers.`id` AND transactions.`mechanical_id` = mechanicals.`id` AND transactions.`operator_id` = operators.`id` AND transactions.`date` = transaction_date group by customers.`name`;
		ELSE
			SELECT "There are no transactions today!" AS "Error";
		END IF;
	else
		SELECT "Invalid mode! The available mode are: DAY, WEEK, MONTH!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_customer` (IN `name` VARCHAR(255), IN `license_plate` VARCHAR(255), IN `phone` VARCHAR(255), IN `address` TEXT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				INSERT INTO customers VALUES (NULL, NAME, license_plate, phone, address, "Active");
				SELECT "Customer data successfully created!" AS "Success", customers.`id` as "Customer ID", customers.`name` as "Customer Name", customers.`license_plate` as "Customer License Plate", customers.`phone` as "Customer Phone", customers.`address` as "Customer Address", customers.`status` as "Customer Status" from customers order by customers.`id` desc limit 1;
			else
				SELECT "Employee who create customer must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_employee` (IN `name` VARCHAR(255), IN `phone` VARCHAR(255), IN `address` TEXT, IN `username` VARCHAR(255), IN `password` VARCHAR(255), IN `role` ENUM("Mechanical","Operator"))  begin
	declare num_rows int;
	
	if @data_login_admin is not null then
		select count(*) into num_rows from admins where admins.`id` = @data_login_admin;
		
		if num_rows = 1 then
			select count(*) into num_rows from employees where employees.`username` = username;
			
			if num_rows = 0 then
				if role = "Mechanical" or role = "Operator" then
					INSERT INTO employees VALUES (NULL, NAME, phone, address, username, PASSWORD, role);
					select "Employee data successfully created!" as "Success", employees.`id` as "Employee ID", employees.`name` as "Employee Name", employees.`phone` as "Employee Phone", employees.`address` as "Employee Address", employees.`role` as "Employee Role" from employees order by employees.`id` desc limit 1;
				else
					select "Invalid role!" as "Error";
				end if;
			else
				select "Username already exists!" as "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_service` (IN `service_type` VARCHAR(255), IN `vehicle_model` VARCHAR(255), IN `price` BIGINT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				INSERT INTO services VALUES (NULL, service_type, vehicle_model, price);
				SELECT "Service data successfully created!" AS "Success", services.`id` as "Serivce ID", services.`service_type` as "Service Type", services.`vehicle_model` as "Service Vehicle Model", services.`price` as "Service Price" from services order by services.`id` desc limit 1;
			else
				select "Employee who create service must be Operator!" as "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_service_transaction` (IN `transaction_id` BIGINT, IN `service_id` BIGINT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	declare service_price bigint;
	declare transaction_date date;
	declare delay_transaction int;
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				select count(*) into num_rows from transactions where transactions.`id` = transaction_id;
				
				if num_rows = 1 then
					select transactions.`date` into transaction_date from transactions where transactions.`id` = transaction_id;
					set delay_transaction = datediff(date(now()), transaction_date);
					
					if delay_transaction <= 1 then
						select count(*) into num_rows from services where services.`id` = service_id;
						
						if num_rows = 1 then
							select services.`price` into service_price from services where services.`id` = service_id;
							insert into service_transactions values (null, transaction_id, service_id, service_price);
							select "Service transaction data successfully created!" as "Success", transactions.`id` as "Transaction ID", customers.`name` as "Customer Name", mechanicals.`name` as "Mechanical Name", operators.`name` as "Operator Name", services.`service_type` as "Service Type", service_transactions.`sub_price` as "Service Price", transactions.`total` as "Total Transaction" from service_transactions, transactions, customers, employees mechanicals, employees operators, services where service_transactions.`transaction_id` = transactions.`id` and service_transactions.`service_id` = services.`id` and transactions.`customer_id` = customers.`id` and transactions.`mechanical_id` = mechanicals.`id` and transactions.`operator_id` = operators.`id` order by service_transactions.`id` desc limit 1;
						else
							select "Invalid service ID!" as "Error";
						end if;
					else
						select "Can't create new data, the transaction has been too long!" as "Error";
					end if;
				else
					select "Invalid transaction ID!" as "Error";
				end if;
			else
				SELECT "Employee who create sparepart must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_sparepart` (IN `sparepart_name` VARCHAR(255), IN `sparepart_type` VARCHAR(255), IN `price` BIGINT, IN `stock` INT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				insert into spareparts values (null, sparepart_name, sparepart_type, price, stock);
				select "Sparepart data successfully created!" as "Success", spareparts.`id` as "Sparepart ID", spareparts.`sparepart_name` as "Sparepart Name", spareparts.`sparepart_type` as "Sparepart Type", spareparts.`price` as "Sparepart Price", spareparts.`stock` as "Sparepart Stock" from spareparts order by spareparts.`id` desc limit 1;
			else
				SELECT "Employee who create sparepart must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_sparepart_buy` (IN `sparepart_buy_transaction_id` BIGINT, IN `sparepart_id` BIGINT, IN `qty` INT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	declare sparepart_price bigint;
	declare transaction_date date;
	declare delay_date int;
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				select count(*) into num_rows from sparepart_buy_transactions where sparepart_buy_transactions.`id` = sparepart_buy_transaction_id;
				
				if num_rows = 1 then
					select sparepart_buy_transactions.`date` into transaction_date from sparepart_buy_transactions where sparepart_buy_transactions.`id` = sparepart_buy_transaction_id;
					set delay_date = datediff(date(now()), transaction_date);
					
					if delay_date <= 1 then
						select count(*) into num_rows from spareparts where spareparts.`id` = sparepart_id;
						
						if num_rows = 1 then
							select spareparts.`price` into sparepart_price from spareparts where spareparts.`id` = sparepart_id;
							insert into sparepart_buys values (null, sparepart_buy_transaction_id, sparepart_id, qty, count_total_price(qty,sparepart_price));
							select "Sparepart buy data successfully created!" as "Success", sparepart_buy_transactions.`id` as "Sparepart Buy Transaction ID", operators.`name` as "Operator Name", suppliers.`name` as "Supplier Name", spareparts.`sparepart_name` as "Sparepart Name", sparepart_buys.`qty` as "Sparepart Buy Qty", sparepart_buys.`total` as "Sparepart Buy Total Price", sparepart_buy_transactions.`total` as "Sparepart Buy Transaction Total Price" from sparepart_buys, sparepart_buy_transactions, employees operators, suppliers, spareparts where sparepart_buys.`sparepart_buy_transaction_id` = sparepart_buy_transactions.`id` and sparepart_buy_transactions.`operator_id` = operators.`id` and sparepart_buy_transactions.`supplier_id` = suppliers.`id` and sparepart_buys.`sparepart_id` = spareparts.`id` order by sparepart_buys.`id` desc limit 1;
						else
							select "Invalid sparepart ID!" as "Error";
						end if;
					else
						SELECT "Can't create new data, the transaction has been too long!" AS "Error";
					end if;
				else
					select "Invalid sparepart buy transaction ID!" as "Error";
				end if;
			else
				SELECT "Employee who create sparepart buy must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_sparepart_buy_transaction` (IN `supplier_id` BIGINT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				select count(*) into num_rows from suppliers where suppliers.`id` = supplier_id;
				
				if num_rows = 1 then
					insert into sparepart_buy_transactions values (null, @data_login_employee, supplier_id, date(now()), 0);
					select "Sparepart buy transaction data successfully created!" as "Success", sparepart_buy_transactions.`id` as "Sparepart Buy Transaction ID", operators.`name` as "Operator Name", suppliers.`name` as "Supplier Name", sparepart_buy_transactions.`total` as "Sparepart Buy Transaction Total Price" from sparepart_buy_transactions, employees operators, suppliers where sparepart_buy_transactions.`operator_id` = operators.`id` and sparepart_buy_transactions.`supplier_id` = suppliers.`id` order by sparepart_buy_transactions.`id` desc limit 1;
				else
					select "Invalid supplier ID!" as "Error";
				end if;
			else
				SELECT "Employee who create sparepart buy transaction must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_sparepart_transaction` (IN `transaction_id` BIGINT, IN `sparepart_id` BIGINT, IN `qty` INT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	declare sparepart_price bigint;
	declare sparepart_stock int;
	DECLARE transaction_date DATE;
	DECLARE delay_transaction INT;
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				select count(*) into num_rows from transactions where transactions.`id` = transaction_id;
				
				if num_rows = 1 then
					SELECT transactions.`date` INTO transaction_date FROM transactions WHERE transactions.`id` = transaction_id;
					SET delay_transaction = DATEDIFF(DATE(NOW()), transaction_date);
					
					IF delay_transaction <= 1 THEN
						select count(*) into num_rows from spareparts where spareparts.`id` = sparepart_id;
						
						if num_rows = 1 then
							select spareparts.`price`, spareparts.`stock` into sparepart_price, sparepart_stock from spareparts where spareparts.`id` = sparepart_id;
							
							if sparepart_stock > qty then
								INSERT INTO sparepart_transactions VALUES (NULL, transaction_id, sparepart_id, qty, count_total_price(qty,sparepart_price));
								SELECT "Sparepart transaction data successfully created!" AS "Success", transactions.`id` as "Transaction ID", customers.`name` as "Customer Name", mechanicals.`name` as "Mechanical Name", operators.`name` as "Operator Name", spareparts.`sparepart_name` as "Sparepart Name", sparepart_transactions.`qty` as "Sparepart Transaction Qty", sparepart_transactions.`sub_price` as "Sparepart Transaction Price", transactions.`total` as "Transaction Total Price" from sparepart_transactions, transactions, customers, employees mechanicals, employees operators, spareparts where sparepart_transactions.`transaction_id` = transactions.`id` and transactions.`customer_id` = customers.`id` and transactions.`mechanical_id` = mechanicals.`id` and transactions.`operator_id` = operators.`id` and sparepart_transactions.`sparepart_id` = spareparts.`id` order by sparepart_transactions.`id` desc limit 1;
							else
								SELECT "Sparepart is empty!" as "Error";
							end if;
						else
							select "Invalid sparepart ID!" as "Error";
						end if;
					else
						SELECT "Can't create new data, the transaction has been too long!" AS "Error";
					end if;
				else
					select "Invalid transaction ID!" as "Error";
				end if;
			else
				SELECT "Employee who create sparepart must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_supplier` (IN `name` VARCHAR(255), IN `phone` VARCHAR(255), IN `address` TEXT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				insert into suppliers values (null, name, phone, address);
				select "Supplier data successfully created!" as "Success", suppliers.`id` as "Supplier ID", suppliers.`name` as "Supplier Name", suppliers.`phone` as "Supplier Phone", suppliers.`address` as "Supplier Address" from suppliers order by suppliers.`id` desc limit 1;
			else
				SELECT "Employee who create supplier must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_transaction` (IN `customer_id` BIGINT, IN `mechanical_id` BIGINT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				select count(*) into num_rows from customers where customers.`id` = customer_id;
				
				if num_rows = 1 then
					select count(*) into num_rows from employees where employees.`id` = mechanical_id;
					
					if num_rows = 1 then
						select employees.`role` into employee_role from employees where employees.`id` = mechanical_id;
						
						if employee_role = "Mechanical" then
							insert into transactions values (null, customer_id, mechanical_id, @data_login_employee, date(now()), 0);
							select "Transaction data successfully created!" as "Success", transactions.`id` as "Transaction ID", customers.`name` as "Customer Name", mechanicals.`name` as "Mechanical Name", operators.`name` as "Operator Name", transactions.`total` as "Total Transaction" from transactions, employees mechanicals, employees operators, customers where transactions.`customer_id` = customers.`id` and transactions.`mechanical_id` = mechanicals.`id` and transactions.`operator_id` = operators.`id` order by transactions.`id` desc limit 1;
						else
							select "Invalid mechanical ID. Employee must be mechanical!" as "Error";
						end if;
					else
						select "Invalid mechanical ID!" as "Error";
					end if;
				else
					select "Invalid customer ID!" as "Error";
				end if;
			else
				SELECT "Employee who create transaction must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_customer` (IN `customer_id` BIGINT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	declare customer_name varchar(255);
	declare customer_license_plate varchar(255);
	declare customer_phone varchar(255);
	declare customer_address text;
	declare customer_status varchar(255);
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				SELECT COUNT(*) INTO num_rows FROM customers WHERE customers.`id` = customer_id;
				
				IF num_rows = 1 THEN
					select customers.`name`, customers.`license_plate`, customers.`phone`, customers.`address`, customers.`status` into customer_name, customer_license_plate, customer_phone, customer_address, customer_status from customers where customers.`id` = customer_id;
					
					DELETE FROM customers WHERE customers.`id` = customer_id;
					SELECT "Customer data successfully deleted!" AS "Success", customer_id as "Customer ID", customer_name as "Customer Name", customer_license_plate as "Customer License Plate", customer_phone as "Customer Phone", customer_address as "Customer Address", customer_status as "Customer Status";
				ELSE
					SELECT "Invalid customer ID!" AS "Error";
				END IF;
			else
				SELECT "Employee who delete customer must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_employee` (IN `employee_id` BIGINT)  begin
	declare num_rows int;
	declare employee_name varchar(255);
	declare employee_phone varchar(255);
	declare employee_address text;
	declare employee_role varchar(255);
	
	if @data_login_admin is not null then
		select count(*) into num_rows from admins where admins.`id` = @data_login_admin;
		
		if num_rows = 1 then
			select count(*) into num_rows from employees where employees.`id` = employee_id;
			
			if num_rows = 1 then
				select employees.`name`, employees.`phone`, employees.`address`, employees.`role` into employee_name, employee_phone, employee_address, employee_role from employees where employees.`id` = employee_id;
				
				delete from employees where employees.`id` = employee_id;
				select "Employee data successfully deleted!" as "Success", employee_id as "Employee ID", employee_name as "Employee Name", employee_phone as "Employee Phone", employee_address as "Employee Address", employee_role as "Employee Role";
			else
				select "Invalid employee ID!" as "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_service` (IN `service_id` BIGINT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	declare service_type varchar(255);
	declare service_vehicle_model varchar(255);
	declare service_price bigint;
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				SELECT COUNT(*) INTO num_rows FROM services WHERE services.`id` = service_id;
				
				IF num_rows = 1 THEN
					select services.`service_type`, services.`vehicle_model`, services.`price` into service_type, service_vehicle_model, service_price from services where services.`id` = service_id;
					
					DELETE FROM services WHERE services.`id` = service_id;
					SELECT "Service data successfully deleted!" AS "Success", service_id as "Service ID", service_type as "Service Type", service_vehicle_model as "Service Vehicle Model", service_price as "Service Price";
				ELSE
					SELECT "Invalid service ID!" AS "Error";
				END IF;
			else
				SELECT "Employee who delete service must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_sparepart` (IN `sparepart_id` BIGINT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	declare sparepart_name varchar(255);
	declare sparepart_type varchar(255);
	declare sparepart_price bigint;
	declare sparepart_stock int;
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				select count(*) into num_rows from spareparts where spareparts.`id` = sparepart_id;
				
				if num_rows = 1 then
					select spareparts.`sparepart_name`, spareparts.`sparepart_type`, spareparts.`price`, spareparts.`stock` into sparepart_name, sparepart_type, sparepart_price, sparepart_stock from spareparts where spareparts.`id` = sparepart_id;
					
					delete from spareparts where spareparts.`id` = sparepart_id;
					select "Sparepart data successfully deleted!" as "Success", sparepart_id as "Sparepart ID", sparepart_name as "Sparepart Name", sparepart_type as "Sparepart Type", sparepart_price as "Sparepart Price", sparepart_stock as "Sparepart Stock";
				else
					SELECT "Invalid sparepart ID!" AS "Error";
				end if;
			else
				SELECT "Employee who delete sparepart must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_sparepart_buy` (IN `sparepart_buy_id` BIGINT)  begin
	DECLARE num_rows INT;
	DECLARE employee_role VARCHAR(255);
	declare sparepart_buy_transaction_id bigint;
	declare operator_name varchar(255);
	declare supplier_name varchar(255);
	declare sparepart_name varchar(255);
	declare sparepart_buy_qty int;
	declare sparepart_buy_total bigint;
	declare sparepart_buy_transaction_total bigint;
	DECLARE transaction_date DATE;
	DECLARE delay_date INT;
	
	IF @data_login_employee IS NOT NULL THEN
		SELECT COUNT(*) INTO num_rows FROM employees WHERE employees.`id` = @data_login_employee;
		
		IF num_rows = 1 THEN
			SELECT employees.`role` INTO employee_role FROM employees WHERE employees.`id` = @data_login_employee;
			
			IF employee_role = "Operator" THEN
				SELECT COUNT(*) INTO num_rows FROM sparepart_buys WHERE sparepart_buys.`id` = sparepart_buy_id;
				
				IF num_rows = 1 THEN
					SELECT sparepart_buy_transactions.`date` INTO transaction_date FROM sparepart_buys, sparepart_buy_transactions WHERE sparepart_buys.`id` = sparepart_buy_id and sparepart_buys.`sparepart_buy_transaction_id` = sparepart_buy_transactions.`id`;
					SET delay_date = DATEDIFF(DATE(NOW()), transaction_date);
					
					IF delay_date <= 1 THEN
						select sparepart_buy_transactions.`id`, operators.`name`, suppliers.`name`, spareparts.`sparepart_name`, sparepart_buys.`qty`, sparepart_buys.`total`, sparepart_buy_transactions.`total` into sparepart_buy_transaction_id, operator_name, supplier_name, sparepart_name, sparepart_buy_qty, sparepart_buy_total, sparepart_buy_transaction_total from sparepart_buys, sparepart_buy_transactions, employees operators, suppliers, spareparts where sparepart_buys.`id` = sparepart_buy_id and sparepart_buys.`sparepart_buy_transaction_id` = sparepart_buy_transactions.`id` and sparepart_buy_transactions.`operator_id` = operators.`id` and sparepart_buy_transactions.`supplier_id` = suppliers.`id` and sparepart_buys.`sparepart_id` = spareparts.`id`;
						
						delete from sparepart_buys where sparepart_buys.`id` = sparepart_buy_id;
						SELECT "Sparepart buy data successfully deleted!" AS "Success", sparepart_buy_transaction_id as "Sparepart Buy Transaction ID", operator_name as "Operator Name", supplier_name as "Supplier Name", sparepart_name as "Sparepart Name", sparepart_buy_qty as "Sparepart Buy Qty", sparepart_buy_total as "Sparepart Buy Total Price", sparepart_buy_transaction_total as "Sparepart Buy Transaction Total Price";
					ELSE
						SELECT "Can't delete the data, the transaction has been too long!" AS "Error";
					END IF;
				ELSE
					SELECT "Invalid sparepart buy ID!" AS "Error";
				END IF;
			ELSE
				SELECT "Employee who delete sparepart buy must be Operator!" AS "Error";
			END IF;
		ELSE
			SELECT "Login first please!" AS "Error";
		END IF;
	ELSE
		SELECT "Login first please!" AS "Error";
	END IF;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_sparepart_transaction` (IN `sparepart_transaction_id` BIGINT)  begin
	DECLARE num_rows INT;
	DECLARE employee_role VARCHAR(255);
	declare transaction_id bigint;
	declare customer_name varchar(255);
	declare mechanical_name varchar(255);
	declare operator_name varchar(255);
	declare sparepart_name varchar(255);
	declare sparepart_transaction_qty int;
	declare sparepart_transaction_total bigint;
	declare transaction_total bigint;
	DECLARE transaction_date DATE;
	DECLARE delay_date INT;
	
	IF @data_login_employee IS NOT NULL THEN
		SELECT COUNT(*) INTO num_rows FROM employees WHERE employees.`id` = @data_login_employee;
		
		IF num_rows = 1 THEN
			SELECT employees.`role` INTO employee_role FROM employees WHERE employees.`id` = @data_login_employee;
			
			IF employee_role = "Operator" THEN
				SELECT COUNT(*) INTO num_rows FROM sparepart_transactions WHERE sparepart_transactions.`id` = sparepart_transaction_id;
				
				IF num_rows = 1 THEN
					SELECT transactions.`date` INTO transaction_date FROM sparepart_transactions, transactions WHERE sparepart_transactions.`id` = sparepart_transaction_id and sparepart_transactions.`transaction_id` = transactions.`id`;
					SET delay_date = DATEDIFF(DATE(NOW()), transaction_date);
					
					IF delay_date <= 1 THEN
						select transactions.`id`, customers.`name`, mechanicals.`name`, operators.`name`, spareparts.`sparepart_name`, sparepart_transactions.`qty`, sparepart_transactions.`sub_price`, transactions.`total` into transaction_id, customer_name, mechanical_name, operator_name, sparepart_name, sparepart_transaction_qty, sparepart_transaction_total, transaction_total from sparepart_transactions, transactions, customers, employees mechanicals, employees operators, spareparts where sparepart_transactions.`id` = sparepart_transaction_id and sparepart_transactions.`transaction_id` = transactions.`id` and transactions.`customer_id` = customers.`id` and transactions.`mechanical_id` = mechanicals.`id` and transactions.`operator_id` = operators.`id` and sparepart_transactions.`sparepart_id` = spareparts.`id`;
						
						delete from sparepart_transactions where sparepart_transactions.`id` = sparepart_transaction_id;
						SELECT "Sparepart transaction data successfully deleted!" AS "Success", transaction_id as "Transaction ID", customer_name as "Customer Name", mechanical_name as "Mechanical Name", operator_name as "Operator Name", sparepart_name as "Sparepart Name", sparepart_transaction_qty as "Sparepart Transaction Qty", sparepart_transaction_total as "Sparepart Transaction Total Price", transaction_total as "Transaction Total Price";
					ELSE
						SELECT "Can't delete the data, the transaction has been too long!" AS "Error";
					END IF;
				ELSE
					SELECT "Invalid sparepart transaction ID!" AS "Error";
				END IF;
			ELSE
				SELECT "Employee who delete sparepart transaction must be Operator!" AS "Error";
			END IF;
		ELSE
			SELECT "Login first please!" AS "Error";
		END IF;
	ELSE
		SELECT "Login first please!" AS "Error";
	END IF;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_customer` (IN `customer_id` BIGINT, IN `name` VARCHAR(255), IN `license_plate` VARCHAR(255), IN `phone` VARCHAR(255), IN `address` TEXT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" Then
				SELECT COUNT(*) INTO num_rows FROM customers WHERE customers.`id` = customer_id;
				
				IF num_rows = 1 THEN
					UPDATE customers SET customers.`name` = NAME, customers.`license_plate` = license_plate, customers.`phone` = phone, customers.`address` = address WHERE customers.`id` = customer_id;
					SELECT "Customer data successfully edited!" AS "Success", customer_id as "Customer ID", customers.`name` as "Customer Name", customers.`license_plate` as "Customer License Plate", customers.`phone` as "Customer Phone", customers.`address` as "Customer Address", customers.`status` as "Customer Status" from customers where customers.`id` = customer_id;
				ELSE
					SELECT "Invalid customer ID!" AS "Error";
				END IF;
			else
				SELECT "Employee who edit customer must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_employee` (IN `employee_id` BIGINT, IN `name` VARCHAR(255), IN `phone` VARCHAR(255), IN `address` TEXT, IN `username` VARCHAR(255), IN `password` VARCHAR(255), IN `role` ENUM("Mechanical","Operator"))  begin
	declare num_rows int;
	declare old_username varchar(255);
	
	if @data_login_admin is not null then
		select count(*) into num_rows from admins where admins.`id` = @data_login_admin;
		
		if num_rows = 1 then
			select count(*) into num_rows from employees where employees.`id` = employee_id;
			
			if num_rows = 1 then
				select employees.`username` into old_username from employees where employees.`id` = employee_id;
				
				if old_username = username then
					if role = "Mechanical" or role = "Operator" then
						update employees set employees.`name` = name, employees.`phone` = phone, employees.`address` = address, employees.`password` = password, employees.`role` = role where employees.`id` = employee_id;
						select "Employee data successfully edited!" as "Success";
					else
						SELECT "Invalid role!" AS "Error";
					end if;
				else
					SELECT COUNT(*) INTO num_rows FROM employees WHERE employees.`username` = username;
			
					IF num_rows = 0 THEN
						IF role = "Mechanical" OR role = "Operator" THEN
							UPDATE employees SET employees.`name` = NAME, employees.`phone` = phone, employees.`address` = address, employees.`username` = username, employees.`password` = password, employees.`role` = role where employees.`id` = employee_id;
							SELECT "Employee data successfully edited!" AS "Success", employee_id as "Employee ID", employees.`name` as "Employee Name", employees.`phone` as "Employee Phone", employees.`address` as "Employee Address", employees.`role` as "Employee Role" from employees where employees.`id` = employee_id;
						ELSE
							SELECT "Invalid role!" AS "Error";
						END IF;
					ELSE
						SELECT "Username already exists!" AS "Error";
					END IF;
				end if;
			else
				select "Invalid employee ID!" as "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_service` (IN `service_id` BIGINT, IN `service_type` VARCHAR(255), IN `vehicle_model` VARCHAR(255), IN `price` BIGINT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				SELECT COUNT(*) INTO num_rows FROM services WHERE services.`id` = service_id;
			
				IF num_rows = 1 THEN
					UPDATE services SET services.`service_type` = service_type, services.`vehicle_model` = vehicle_model, services.`price` = price WHERE services.`id` = service_id;
					SELECT "Service data successfully edited!" AS "Success", service_id as "Service ID", services.`service_type` as "Service Type", services.`vehicle_model` as "Service Vehicle Model", services.`price` as "Service Price" from services where services.`id` = service_id;
				ELSE
					SELECT "Invalid service ID!" AS "Error";
				END IF;
			else
				SELECT "Employee who edit service must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_sparepart` (IN `sparepart_id` BIGINT, IN `sparepart_name` VARCHAR(255), IN `sparepart_type` VARCHAR(255), IN `price` BIGINT, IN `stock` INT)  begin
	declare num_rows int;
	declare employee_role varchar(255);
	
	if @data_login_employee is not null then
		select count(*) into num_rows from employees where employees.`id` = @data_login_employee;
		
		if num_rows = 1 then
			select employees.`role` into employee_role from employees where employees.`id` = @data_login_employee;
			
			if employee_role = "Operator" then
				select count(*) into num_rows from spareparts where spareparts.`id` = sparepart_id;
				
				if num_rows = 1 then
					update spareparts set spareparts.`sparepart_name` = sparepart_name, spareparts.`sparepart_type` = sparepart_type, spareparts.`price` = price, spareparts.`stock` = stock where spareparts.`id` = sparepart_id;
					select "Sparepart data successfully edited!" as "Success", sparepart_id as "Sparepart ID", spareparts.`sparepart_name` as "Sparepart Name", spareparts.`sparepart_type` as "Sparepart Type", spareparts.`price` as "Sparepart Price", spareparts.`stock` as "Sparepart Stock" from spareparts where spareparts.`id` = sparepart_id;
				else
					SELECT "Invalid sparepart ID!" AS "Error";
				end if;
			else
				SELECT "Employee who edit sparepart must be Operator!" AS "Error";
			end if;
		else
			select "Login first please!" AS "Error";
		end if;
	else
		select "Login first please!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_sparepart_buy` (IN `sparepart_buy_id` BIGINT, IN `qty` INT)  begin
	DECLARE num_rows INT;
	DECLARE employee_role VARCHAR(255);
	DECLARE sparepart_price BIGINT;
	DECLARE transaction_date DATE;
	DECLARE delay_date INT;
	
	IF @data_login_employee IS NOT NULL THEN
		SELECT COUNT(*) INTO num_rows FROM employees WHERE employees.`id` = @data_login_employee;
		
		IF num_rows = 1 THEN
			SELECT employees.`role` INTO employee_role FROM employees WHERE employees.`id` = @data_login_employee;
			
			IF employee_role = "Operator" THEN
				SELECT COUNT(*) INTO num_rows FROM sparepart_buys WHERE sparepart_buys.`id` = sparepart_buy_id;
				
				IF num_rows = 1 THEN
					SELECT sparepart_buy_transactions.`date` INTO transaction_date FROM sparepart_buys, sparepart_buy_transactions WHERE sparepart_buys.`id` = sparepart_buy_id and sparepart_buys.`sparepart_buy_transaction_id` = sparepart_buy_transactions.`id`;
					SET delay_date = DATEDIFF(DATE(NOW()), transaction_date);
					
					IF delay_date <= 1 THEN
						SELECT spareparts.`price` INTO sparepart_price FROM sparepart_buys, spareparts WHERE sparepart_buys.`id` = sparepart_buy_id AND sparepart_buys.`sparepart_id` = spareparts.`id`;
						
						update sparepart_buys set sparepart_buys.`qty` = qty, sparepart_buys.`total` = count_total_price(qty, sparepart_price) where sparepart_buys.`id` = sparepart_buy_id;
						SELECT "Sparepart buy data successfully edited!" AS "Success", sparepart_buy_transactions.`id` AS "Sparepart Buy Transaction ID", operators.`name` AS "Operator Name", suppliers.`name` AS "Supplier Name", spareparts.`sparepart_name` AS "Sparepart Name", sparepart_buys.`qty` AS "Sparepart Buy Qty", sparepart_buys.`total` AS "Sparepart Buy Total Price", sparepart_buy_transactions.`total` AS "Sparepart Buy Transaction Total Price" FROM sparepart_buys, sparepart_buy_transactions, employees operators, suppliers, spareparts WHERE sparepart_buys.`id` = sparepart_buy_id and sparepart_buys.`sparepart_buy_transaction_id` = sparepart_buy_transactions.`id` AND sparepart_buy_transactions.`operator_id` = operators.`id` AND sparepart_buy_transactions.`supplier_id` = suppliers.`id` AND sparepart_buys.`sparepart_id` = spareparts.`id`;
					ELSE
						SELECT "Can't edit the data, the transaction has been too long!" AS "Error";
					END IF;
				ELSE
					SELECT "Invalid sparepart buy ID!" AS "Error";
				END IF;
			ELSE
				SELECT "Employee who edit sparepart buy must be Operator!" AS "Error";
			END IF;
		ELSE
			SELECT "Login first please!" AS "Error";
		END IF;
	ELSE
		SELECT "Login first please!" AS "Error";
	END IF;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_sparepart_transaction` (IN `sparepart_transaction_id` BIGINT, IN `qty` INT)  begin
	DECLARE num_rows INT;
	DECLARE employee_role VARCHAR(255);
	DECLARE sparepart_price BIGINT;
	DECLARE transaction_date DATE;
	DECLARE delay_date INT;
	
	IF @data_login_employee IS NOT NULL THEN
		SELECT COUNT(*) INTO num_rows FROM employees WHERE employees.`id` = @data_login_employee;
		
		IF num_rows = 1 THEN
			SELECT employees.`role` INTO employee_role FROM employees WHERE employees.`id` = @data_login_employee;
			
			IF employee_role = "Operator" THEN
				SELECT COUNT(*) INTO num_rows FROM sparepart_transactions WHERE sparepart_transactions.`id` = sparepart_transaction_id;
				
				IF num_rows = 1 THEN
					SELECT transactions.`date` INTO transaction_date FROM sparepart_transactions, transactions WHERE sparepart_transactions.`id` = sparepart_transaction_id and sparepart_transactions.`transaction_id` = transactions.`id`;
					SET delay_date = DATEDIFF(DATE(NOW()), transaction_date);
					
					IF delay_date <= 1 THEN
						SELECT spareparts.`price` INTO sparepart_price FROM sparepart_transactions, spareparts WHERE sparepart_transactions.`id` = sparepart_transaction_id and sparepart_transactions.`sparepart_id` = spareparts.`id`;
						
						update sparepart_transactions set sparepart_transactions.`qty` = qty, sparepart_transactions.`sub_price` = count_total_price(qty, sparepart_price) where sparepart_transactions.`id` = sparepart_transaction_id;
						SELECT "Sparepart transaction data successfully edited!" AS "Success", transactions.`id` AS "Transaction ID", customers.`name` as "Customer Name", mechanicals.`name` as "Mechanical Name", operators.`name` AS "Operator Name", spareparts.`sparepart_name` AS "Sparepart Name", sparepart_transactions.`qty` AS "Sparepart Transaction Qty", sparepart_transactions.`sub_price` AS "Sparepart Transaction Total Price", transactions.`total` AS "Transaction Total Price" FROM sparepart_transactions, transactions, customers, employees mechanicals, employees operators, spareparts WHERE sparepart_transactions.`id` = sparepart_transaction_id and sparepart_transactions.`transaction_id` = transactions.`id` and transactions.`customer_id` = customers.`id` AND transactions.`mechanical_id` = mechanicals.`id` and transactions.`operator_id` = operators.`id` AND sparepart_transactions.`sparepart_id` = spareparts.`id`;
					ELSE
						SELECT "Can't edit the data, the transaction has been too long!" AS "Error";
					END IF;
				ELSE
					SELECT "Invalid sparepart transaction ID!" AS "Error";
				END IF;
			ELSE
				SELECT "Employee who edit sparepart transaction must be Operator!" AS "Error";
			END IF;
		ELSE
			SELECT "Login first please!" AS "Error";
		END IF;
	ELSE
		SELECT "Login first please!" AS "Error";
	END IF;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login_admin` (IN `username` VARCHAR(255), IN `password` VARCHAR(255))  begin
	declare num_rows int;
	
	select count(*) into num_rows from admins where admins.`username` = username and admins.`password` = password;
	
	if num_rows = 1 then
		select admins.`id` into @data_login_admin from admins where admins.`username` = username and admins.`password` = password;
		select "Login success!" as "Success";
	else
		select "Login failed. Wrong username or password!" as "Error";
	end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login_employee` (IN `username` VARCHAR(255), IN `password` VARCHAR(255))  begin
	declare num_rows int;
	
	select count(*) into num_rows from employees where employees.`username` = username and employees.`password` = password;
	
	if num_rows = 1 then
		select employees.`id` into @data_login_employee from employees where employees.`username` = username and employees.`password` = password;
		select "Login success!" as "Success";
	else
		select "Login failed. Wrong username or password!" as "Error";
	end if;
end$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `count_total_price` (`qty` BIGINT, `price` BIGINT) RETURNS BIGINT(20) begin
	declare result bigint;
	
	set result = qty * price;
	
	return result;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `username`, `password`, `email`) VALUES
(1, 'Made Hari Kesuma Arta', 'harikesuma', 'hari12345', 'harikesuma@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `license_plate` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `status` enum('Active','Non-Active') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `license_plate`, `phone`, `address`, `status`, `created_at`) VALUES
(1, 'Made Adhi', 'DK 111 AR', '087232418842', 'Jl. WR. Supratman No 3', 'Non-Active', '2019-12-02 21:25:14'),
(2, 'Pratiwi Ashari', 'DK 222 CS', '081252415542', 'Jl. Sudirman No 4', 'Non-Active', '2019-12-02 21:25:14'),
(3, 'Pradnyani Wulantari', 'DK 333 VF', '0852326878342', 'Jl. Kamboja No 5', 'Non-Active', '2019-12-02 21:25:14'),
(4, 'Kadek Sastrawan', 'DK 444 BG', '089983923922', 'Jl. Jepun No 6', 'Non-Active', '2019-12-02 21:25:14'),
(5, 'Adi Wira', 'DK 555 GH', '087675248412', 'Jl. Ahmad Yani No 7', 'Non-Active', '2019-12-02 21:25:14'),
(6, 'Ratna', 'DK 123 DF', '08153521546634', 'Jl. Jempiring No 8', 'Non-Active', '2019-12-02 21:25:14'),
(7, 'Dhani Prasetya', 'DK 234 CV', '082245467892', 'Jl. Gatot Subroto No 412', 'Non-Active', '2019-12-02 21:25:14'),
(8, 'Naomi Sudana', 'DK 232 FF', '0878973878111', 'Jl. Kamboja No 123', 'Non-Active', '2019-12-02 21:25:14'),
(9, 'Dede Hadi', 'DK 456 AG', '081249561111', 'Jl. Hayam Wuruk No 61', 'Non-Active', '2019-12-02 21:25:14'),
(10, 'Rafi Rudika', 'DK 734 NH', '081672548765', 'Jl. Ahmad Yani No 74', 'Non-Active', '2019-12-02 21:25:14'),
(11, 'Rahmawati Kususma', 'DK 652 BB', '089364728291', 'Jl. Nuansa Indah No. 99\r\n', 'Non-Active', '2019-12-02 21:25:14'),
(12, 'Bayu Fajar Setiabudi', 'DK 736 HF', '08936272839', 'Jl. Hangtuah No. 87\r\n', 'Non-Active', '2019-12-02 21:25:14'),
(13, 'Diah Intan', 'DK 74 FFF', '08123754983', 'Jl. Sumatra No. 55', 'Non-Active', '2019-12-02 21:25:14'),
(14, 'Widya Agustina', 'DK 523 RR', '08762527288', 'Jl. Sulawesi No. 98', 'Non-Active', '2019-12-02 21:25:14'),
(15, 'Fitri Retno Utami', 'DK 898 K', '08563728392', 'Jl. Sumatra No. 88', 'Non-Active', '2019-12-02 21:25:14'),
(16, 'Devi Lestari', 'DK 985 LO', '08912343219', 'Jl. Wijaya Kusuma No. 87', 'Non-Active', '2019-12-02 21:25:14'),
(17, 'Retno Agustino', 'DK 12 AMI', '0823457819', 'Jl. Hayam Wuruk No. 72', 'Non-Active', '2019-12-02 21:25:14'),
(18, 'Made Arta', 'DK 432 HG', '08238576192', 'Jl. Budiman No. 123', 'Non-Active', '2019-12-02 21:25:14'),
(19, 'Eko Aditya Kurnia', 'DK 872 JJ', '089726281819', 'Jl. WR. Supratman No. 534', 'Non-Active', '2019-12-02 21:25:14'),
(20, 'Putra Arif Pratama', 'DK 982 HH', '08765277272', 'Jl. Sakura No. 111', 'Non-Active', '2019-12-02 21:25:14'),
(21, 'Aditya Yudistira', 'DK 3032 BA', '091021920182', 'Jl. Sading Mengwi', 'Active', '2019-12-02 21:25:14');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Mechanical','Operator') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `name`, `phone`, `address`, `username`, `password`, `role`, `created_at`) VALUES
(1, 'Doni Ryandi', '082245467892', 'JL. Pulau Kapuk No. 12', 'donir', 'donir12345', 'Operator', '2019-12-02 21:25:36'),
(2, 'Amalia Siti', '0818973878221', 'JL. Pulau Morotai No. 76', 'amalia', 'amalia2000', 'Operator', '2019-12-02 21:25:36'),
(3, 'Abdul Fajar', '087890093233', 'JL. Hayam Wuruk No. 87', 'abduldika', 'abdoel123', 'Mechanical', '2019-12-02 21:25:36'),
(4, 'Maya Amalia Dina', '081672548765', 'JL. Nusa Kambangan No. 99', 'maya', 'dinamaya72', 'Mechanical', '2019-12-02 21:25:36'),
(5, 'Agung Bahari Putra', '087223467892', 'Jl. Pulau Buntar No 23', 'agung', 'lautbahari', 'Mechanical', '2019-12-02 21:25:36'),
(6, 'Kurnia Adi Indra', '0818273418111', 'Jl. Kebo Iwa No. 45', 'adi', 'adira998', 'Mechanical', '2019-12-02 21:25:36'),
(7, 'Fajar Abdulah', '08927218292', 'Jl. Suli No. 99\r\n', 'fajar', 'fajarelo1', 'Operator', '2019-12-02 21:25:36'),
(8, 'Deni Utama', '087621628291', 'Jl. Kudanil No. 653', 'utama', 'utamadeni1', 'Mechanical', '2019-12-02 21:25:36'),
(9, 'Bahari Santoso', '08972372822', 'Jl. Bypass Ngr Rai No. 67', 'santoso', 'santoso871', 'Mechanical', '2019-12-02 21:25:36'),
(10, 'Guntur Treman', '08172366337', 'Jl. Sesetan No. 189', 'tretan', 'tretan123', 'Mechanical', '2019-12-02 21:25:36'),
(11, 'Donir', '0812123434', 'Badung', 'doniraa', 'doniraa12345', 'Operator', '2019-12-02 21:25:36');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `message` text NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `customer_id`, `message`, `date`) VALUES
(1, 1, 'It\'s been 67 days since your last service. Service your vehicle regularly so you can drive safely!', '2018-12-14'),
(2, 17, 'It\'s been 30 days since your last service. Service your vehicle regularly so you can drive safely!', '2018-12-21'),
(3, 4, 'It\'s been 30 days since your last service. Service your vehicle regularly so you can drive safely!', '2018-12-28'),
(4, 5, 'It\'s been 30 days since your last service. Service your vehicle regularly so you can drive safely!', '2018-12-28'),
(5, 7, 'It\'s been 30 days since your last service. Service your vehicle regularly so you can drive safely!', '2018-12-29'),
(6, 8, 'It\'s been 30 days since your last service. Service your vehicle regularly so you can drive safely!', '2018-12-30'),
(7, 10, 'It\'s been 30 days since your last service. Service your vehicle regularly so you can drive safely!', '2018-12-31'),
(8, 13, 'It\'s been 30 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-01-03'),
(9, 1, 'It\'s been 346 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(10, 2, 'It\'s been 339 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(11, 3, 'It\'s been 340 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(12, 4, 'It\'s been 332 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(13, 5, 'It\'s been 332 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(14, 6, 'It\'s been 349 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(15, 7, 'It\'s been 331 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(16, 8, 'It\'s been 330 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(17, 9, 'It\'s been 348 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(18, 10, 'It\'s been 329 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(19, 11, 'It\'s been 353 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(20, 12, 'It\'s been 352 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(21, 13, 'It\'s been 326 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(22, 14, 'It\'s been 352 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(23, 15, 'It\'s been 350 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(24, 16, 'It\'s been 350 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(25, 17, 'It\'s been 339 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(26, 18, 'It\'s been 349 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(27, 19, 'It\'s been 348 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25'),
(28, 20, 'It\'s been 348 days since your last service. Service your vehicle regularly so you can drive safely!', '2019-11-25');

--
-- Triggers `messages`
--
DELIMITER $$
CREATE TRIGGER `after_insert_message` AFTER INSERT ON `messages` FOR EACH ROW begin
	update customers set customers.`status` = "Non-Active" where customers.`id` = NEW.customer_id;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` bigint(20) NOT NULL,
  `service_type` varchar(255) NOT NULL,
  `vehicle_model` varchar(255) NOT NULL,
  `price` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `service_type`, `vehicle_model`, `price`, `created_at`) VALUES
(1, 'Pasang lampu', 'Vario', 10000, '2019-12-02 21:26:04'),
(2, 'Ganti ban', 'Supra', 20000, '2019-12-02 21:26:04'),
(3, 'Ganti oli', 'Jupiter', 15000, '2019-12-02 21:26:04'),
(4, 'Ganti kampas rem', 'Ninja', 10000, '2019-12-02 21:26:04'),
(5, 'Ganti spion', 'Nmax', 5000, '2019-12-02 21:26:04'),
(6, 'Pasang aki', 'Xmax', 50000, '2019-12-02 21:26:04'),
(7, 'Ganti busi', 'Scoopy', 45000, '2019-12-02 21:26:04');

-- --------------------------------------------------------

--
-- Table structure for table `service_transactions`
--

CREATE TABLE `service_transactions` (
  `id` bigint(20) NOT NULL,
  `transaction_id` bigint(20) NOT NULL,
  `service_id` bigint(20) NOT NULL,
  `sub_price` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service_transactions`
--

INSERT INTO `service_transactions` (`id`, `transaction_id`, `service_id`, `sub_price`) VALUES
(1, 1, 1, 10000),
(2, 1, 2, 20000),
(3, 2, 3, 15000),
(4, 3, 2, 20000),
(5, 3, 1, 10000),
(6, 4, 4, 10000),
(7, 4, 3, 15000),
(8, 5, 4, 10000),
(9, 6, 5, 45000),
(10, 7, 6, 50000),
(11, 7, 7, 45000),
(12, 7, 5, 45000),
(13, 8, 1, 10000),
(14, 9, 2, 20000),
(15, 10, 1, 10000),
(16, 10, 2, 20000),
(17, 10, 3, 15000),
(18, 11, 4, 10000),
(19, 11, 3, 15000),
(20, 11, 2, 20000),
(21, 11, 5, 45000),
(22, 12, 1, 10000),
(23, 12, 2, 20000),
(24, 12, 3, 15000),
(25, 13, 1, 10000),
(26, 13, 2, 20000),
(27, 13, 7, 45000),
(28, 13, 5, 45000),
(29, 14, 1, 10000),
(30, 14, 2, 20000),
(31, 15, 1, 10000),
(32, 15, 2, 20000),
(33, 15, 3, 15000),
(34, 15, 4, 10000),
(35, 15, 5, 45000),
(36, 16, 1, 10000),
(37, 17, 2, 20000),
(38, 18, 2, 20000),
(39, 19, 3, 15000),
(40, 20, 4, 10000),
(41, 21, 5, 45000),
(42, 22, 6, 50000),
(43, 23, 7, 45000),
(44, 24, 1, 10000),
(45, 25, 2, 20000),
(46, 26, 3, 15000),
(47, 27, 4, 10000),
(48, 28, 5, 45000),
(49, 30, 7, 45000),
(50, 31, 6, 50000),
(51, 32, 7, 45000),
(52, 33, 6, 50000),
(53, 34, 5, 45000),
(54, 35, 4, 10000),
(55, 36, 3, 15000),
(56, 37, 2, 20000),
(57, 38, 2, 20000),
(58, 38, 1, 10000),
(59, 39, 1, 10000),
(60, 40, 2, 20000),
(61, 41, 3, 15000),
(62, 42, 3, 15000),
(63, 43, 2, 20000),
(64, 44, 4, 10000),
(65, 45, 7, 45000),
(66, 46, 6, 50000),
(67, 47, 5, 45000),
(68, 48, 4, 10000),
(69, 49, 3, 15000),
(70, 50, 1, 10000),
(71, 51, 3, 15000),
(73, 52, 3, 15000);

--
-- Triggers `service_transactions`
--
DELIMITER $$
CREATE TRIGGER `after_insert_service_transactions` AFTER INSERT ON `service_transactions` FOR EACH ROW begin
	declare customer_id bigint;
	
	select transactions.`customer_id` into customer_id from transactions where transactions.`id` = NEW.transaction_id;
	update transactions set transactions.`total` = transactions.`total` + NEW.sub_price where transactions.`id` = NEW.transaction_id;
	update customers set customers.`status` = "Active" where customers.`id` = customer_id;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `spareparts`
--

CREATE TABLE `spareparts` (
  `id` bigint(20) NOT NULL,
  `sparepart_name` varchar(255) NOT NULL,
  `sparepart_type` varchar(255) NOT NULL,
  `price` bigint(20) NOT NULL,
  `stock` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `spareparts`
--

INSERT INTO `spareparts` (`id`, `sparepart_name`, `sparepart_type`, `price`, `stock`, `created_at`) VALUES
(1, 'Busi', 'Suku Cadang', 150000, 4, '2019-12-02 17:07:28'),
(2, 'Aki', 'Suku Cadang', 300000, -15, '2019-12-02 17:07:28'),
(3, 'Karburator', 'Suku Cadang', 230000, 14, '2019-12-02 17:07:28'),
(4, 'Ban', 'Suku Cadang', 175000, 9, '2019-12-02 17:07:28'),
(5, 'Lampu', 'Suku Cadang', 12000, 57, '2019-12-02 17:07:28'),
(6, 'Tali Gas', 'Suku Cadang', 45000, -15, '2019-12-02 17:07:28'),
(7, 'Rantai', 'Suku Cadang', 50000, 4, '2019-12-02 17:07:28'),
(8, 'Knalpot', 'Suku Cadang', 350000, -3, '2019-12-02 17:07:28'),
(9, 'Spion', 'Suku Cadang', 35000, 3, '2019-12-02 17:07:28'),
(10, 'Kampas Rem', 'Suku Cadang', 55000, 47, '2019-12-02 17:07:28'),
(11, 'Oli', 'Suku Cadang', 40000, 31, '2019-12-02 17:07:28'),
(12, 'Minyak Rem', 'Suku Cadang', 50000, 100, '2019-12-02 22:35:44');

-- --------------------------------------------------------

--
-- Table structure for table `sparepart_buys`
--

CREATE TABLE `sparepart_buys` (
  `id` bigint(20) NOT NULL,
  `sparepart_buy_transaction_id` bigint(20) NOT NULL,
  `sparepart_id` bigint(20) NOT NULL,
  `qty` int(11) NOT NULL,
  `total` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sparepart_buys`
--

INSERT INTO `sparepart_buys` (`id`, `sparepart_buy_transaction_id`, `sparepart_id`, `qty`, `total`) VALUES
(1, 1, 1, 10, 1500000),
(2, 1, 3, 30, 6900000),
(3, 1, 5, 50, 600000),
(4, 1, 7, 20, 1000000),
(6, 2, 11, 35, 1440000),
(7, 2, 10, 50, 2750000),
(8, 2, 9, 10, 350000),
(9, 3, 1, 10, 1500000),
(10, 3, 2, 10, 3000000),
(11, 4, 1, 15, 2250000),
(12, 5, 4, 10, 1750000),
(13, 6, 11, 10, 400000),
(14, 7, 5, 10, 120000),
(17, 11, 1, 1, 150000),
(19, 13, 2, 3, 900000);

--
-- Triggers `sparepart_buys`
--
DELIMITER $$
CREATE TRIGGER `after_delete_sparepart_buys` AFTER DELETE ON `sparepart_buys` FOR EACH ROW begin
	UPDATE spareparts SET spareparts.`stock` = spareparts.`stock` - OLD.qty WHERE spareparts.`id` = OLD.sparepart_id;
	UPDATE sparepart_buy_transactions SET sparepart_buy_transactions.`total` = sparepart_buy_transactions.`total` - OLD.total WHERE sparepart_buy_transactions.`id` = OLD.sparepart_buy_transaction_id;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_sparepart_buys` AFTER INSERT ON `sparepart_buys` FOR EACH ROW begin
	update sparepart_buy_transactions set sparepart_buy_transactions.`total` = sparepart_buy_transactions.`total` + NEW.total where sparepart_buy_transactions.`id` = NEW.sparepart_buy_transaction_id;
	update spareparts set spareparts.`stock` = spareparts.`stock` + NEW.qty where spareparts.`id` = NEW.sparepart_id;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_sparepart_buys` AFTER UPDATE ON `sparepart_buys` FOR EACH ROW begin
	IF OLD.qty > NEW.qty THEN
		UPDATE spareparts SET spareparts.`stock` = spareparts.`stock` - (OLD.qty - NEW.qty) WHERE spareparts.`id` = NEW.sparepart_id;
		UPDATE sparepart_buy_transactions SET sparepart_buy_transactions.`total` = sparepart_buy_transactions.`total` - (OLD.total - NEW.total) WHERE sparepart_buy_transactions.`id` = NEW.sparepart_buy_transaction_id;
	ELSEIF NEW.qty > OLD.qty THEN
		UPDATE spareparts SET spareparts.`stock` = spareparts.`stock` + (NEW.qty - OLD.qty) WHERE spareparts.`id` = NEW.sparepart_id;
		UPDATE sparepart_buy_transactions SET sparepart_buy_transactions.`total` = sparepart_buy_transactions.`total` + (NEW.total - OLD.total) WHERE sparepart_buy_transactions.`id` = NEW.sparepart_buy_transaction_id;
	END IF;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sparepart_buy_transactions`
--

CREATE TABLE `sparepart_buy_transactions` (
  `id` bigint(20) NOT NULL,
  `operator_id` bigint(20) NOT NULL,
  `supplier_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `total` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sparepart_buy_transactions`
--

INSERT INTO `sparepart_buy_transactions` (`id`, `operator_id`, `supplier_id`, `date`, `total`) VALUES
(1, 1, 1, '2018-10-01', 10000000),
(2, 2, 3, '2018-10-02', 4540000),
(3, 2, 2, '2018-10-03', 4500000),
(4, 1, 4, '2018-10-04', 2250000),
(5, 1, 2, '2018-10-07', 1750000),
(6, 2, 6, '2018-12-16', 400000),
(7, 2, 6, '2018-12-16', 120000),
(8, 2, 4, '2018-12-20', 0),
(9, 2, 3, '2018-12-21', 0),
(10, 2, 3, '2018-12-21', 0),
(11, 2, 6, '2018-12-21', 150000),
(12, 2, 6, '2018-12-22', 0),
(13, 2, 4, '2018-12-22', 900000);

-- --------------------------------------------------------

--
-- Table structure for table `sparepart_transactions`
--

CREATE TABLE `sparepart_transactions` (
  `id` bigint(20) NOT NULL,
  `transaction_id` bigint(20) NOT NULL,
  `sparepart_id` bigint(20) NOT NULL,
  `qty` int(11) NOT NULL,
  `sub_price` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sparepart_transactions`
--

INSERT INTO `sparepart_transactions` (`id`, `transaction_id`, `sparepart_id`, `qty`, `sub_price`) VALUES
(1, 1, 5, 1, 12000),
(2, 1, 2, 1, 300000),
(3, 3, 5, 1, 12000),
(4, 2, 6, 1, 45000),
(5, 4, 11, 2, 80000),
(6, 5, 11, 3, 120000),
(7, 7, 5, 1, 12000),
(8, 8, 1, 1, 150000),
(9, 6, 4, 1, 175000),
(10, 9, 9, 2, 70000),
(11, 10, 9, 2, 70000),
(12, 11, 1, 1, 150000),
(13, 12, 3, 2, 460000),
(14, 13, 3, 3, 690000),
(15, 14, 1, 3, 450000),
(16, 15, 3, 3, 690000),
(17, 15, 6, 5, 225000),
(18, 16, 2, 2, 600000),
(19, 17, 2, 1, 300000),
(20, 15, 2, 3, 900000),
(21, 16, 2, 3, 900000),
(22, 17, 2, 1, 300000),
(23, 18, 3, 3, 690000),
(24, 19, 3, 1, 230000),
(25, 20, 1, 2, 300000),
(26, 21, 8, 3, 1050000),
(27, 22, 9, 3, 105000),
(28, 23, 6, 1, 45000),
(29, 24, 10, 3, 165000),
(30, 25, 3, 1, 230000),
(31, 26, 1, 1, 150000),
(32, 27, 1, 1, 150000),
(33, 28, 1, 1, 150000),
(34, 29, 2, 2, 600000),
(35, 30, 2, 2, 600000),
(36, 31, 7, 2, 100000),
(37, 32, 2, 1, 300000),
(38, 33, 7, 8, 400000),
(39, 34, 2, 1, 300000),
(40, 35, 1, 1, 150000),
(41, 36, 2, 2, 600000),
(42, 37, 1, 5, 750000),
(43, 38, 1, 8, 1200000),
(44, 39, 1, 2, 300000),
(45, 40, 1, 3, 450000),
(46, 41, 11, 2, 80000),
(47, 42, 11, 2, 80000),
(48, 43, 11, 5, 200000),
(49, 44, 1, 2, 30000),
(50, 45, 6, 3, 135000),
(51, 46, 1, 1, 150000),
(52, 47, 3, 3, 690000),
(53, 48, 7, 6, 300000),
(54, 49, 6, 5, 225000),
(55, 50, 2, 1, 300000),
(57, 53, 2, 4, 1200000),
(58, 54, 2, 4, 1200000);

--
-- Triggers `sparepart_transactions`
--
DELIMITER $$
CREATE TRIGGER `after_delete_sparepart_transactions` AFTER DELETE ON `sparepart_transactions` FOR EACH ROW begin
	UPDATE spareparts SET spareparts.`stock` = spareparts.`stock` + OLD.qty WHERE spareparts.`id` = OLD.sparepart_id;
	UPDATE transactions SET transactions.`total` = transactions.`total` - OLD.sub_price WHERE transactions.`id` = OLD.transaction_id;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_sparepart_transactions` AFTER INSERT ON `sparepart_transactions` FOR EACH ROW begin
	update transactions set transactions.`total` = transactions.`total` + NEW.sub_price where transactions.`id` = NEW.transaction_id;
	update spareparts set spareparts.`stock` = spareparts.`stock` - NEW.qty where spareparts.`id` = NEW.sparepart_id;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_sparepart_transactions` AFTER UPDATE ON `sparepart_transactions` FOR EACH ROW begin
	IF OLD.qty > NEW.qty THEN
		UPDATE spareparts SET spareparts.`stock` = spareparts.`stock` + (OLD.qty - NEW.qty) WHERE spareparts.`id` = NEW.sparepart_id;
		UPDATE transactions SET transactions.`total` = transactions.`total` - (OLD.sub_price - NEW.sub_price) WHERE transactions.`id` = NEW.transaction_id;
	ELSEIF NEW.qty > OLD.qty THEN
		UPDATE spareparts SET spareparts.`stock` = spareparts.`stock` - (NEW.qty - OLD.qty) WHERE spareparts.`id` = NEW.sparepart_id;
		UPDATE transactions SET transactions.`total` = transactions.`total` + (NEW.sub_price - OLD.sub_price) WHERE transactions.`id` = NEW.transaction_id;
	END IF;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `phone`, `address`, `created_at`) VALUES
(1, 'Puji Utama', '80976328239239', 'Jl. Gurita Besaar No. 67', '2019-12-02 22:37:29'),
(2, 'Setiawan Budi Utama', '085176326732', 'JL. Seruni No. 55', '2019-12-02 22:37:29'),
(3, 'Deni Putra Budi', '089726475823', 'JL. Hangtuah No. 45', '2019-12-02 22:37:29'),
(4, 'Muhamad Zainudin ', '08123454378', 'JL. Cok Agung Tresna No. 76', '2019-12-02 22:37:29'),
(5, 'Agus Dwi Wahyu ', '089763748392', 'JL. Trenggana No. 524', '2019-12-02 22:37:29'),
(6, 'Mekar Abadi Jaya', '0827372372', 'Jl. Hayam Wuruk No 33', '2019-12-02 22:37:29');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `mechanical_id` bigint(20) NOT NULL,
  `operator_id` bigint(20) NOT NULL,
  `date` date NOT NULL,
  `total` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `customer_id`, `mechanical_id`, `operator_id`, `date`, `total`) VALUES
(1, 1, 3, 1, '2018-10-08', 342000),
(2, 2, 3, 1, '2018-10-09', 60000),
(3, 3, 3, 1, '2018-10-10', 42000),
(4, 4, 4, 2, '2018-10-11', 105000),
(5, 5, 4, 2, '2018-10-12', 130000),
(6, 6, 4, 2, '2018-10-13', 220000),
(7, 7, 4, 2, '2018-10-15', 152000),
(8, 8, 5, 1, '2018-10-16', 160000),
(9, 9, 5, 1, '2018-10-17', 90000),
(10, 10, 6, 1, '2018-10-18', 115000),
(11, 2, 6, 1, '2018-11-09', 240000),
(12, 3, 3, 2, '2018-11-10', 505000),
(13, 4, 3, 2, '2018-11-10', 810000),
(14, 5, 3, 2, '2018-11-12', 480000),
(15, 6, 6, 1, '2018-11-13', 1915000),
(16, 7, 6, 2, '2018-11-14', 1510000),
(17, 8, 5, 1, '2018-11-15', 620000),
(18, 9, 5, 1, '2018-11-15', 710000),
(19, 10, 5, 1, '2018-11-16', 245000),
(20, 8, 4, 2, '2018-11-19', 310000),
(21, 11, 3, 1, '2018-11-19', 1095000),
(22, 12, 3, 1, '2018-11-19', 155000),
(23, 13, 3, 1, '2018-11-20', 90000),
(24, 14, 3, 2, '2018-11-20', 175000),
(25, 15, 6, 2, '2018-11-20', 250000),
(26, 16, 4, 2, '2018-11-21', 165000),
(27, 17, 4, 2, '2018-11-21', 160000),
(28, 18, 4, 1, '2018-11-21', 195000),
(29, 19, 5, 1, '2018-11-22', 600000),
(30, 20, 5, 1, '2018-11-23', 645000),
(31, 2, 5, 2, '2018-11-26', 150000),
(32, 2, 3, 1, '2018-11-27', 345000),
(33, 4, 4, 1, '2018-11-28', 450000),
(34, 5, 4, 2, '2018-11-28', 345000),
(35, 7, 4, 1, '2018-11-29', 160000),
(36, 8, 3, 1, '2018-11-30', 615000),
(37, 10, 3, 2, '2018-12-01', 770000),
(38, 11, 4, 1, '2018-12-03', 1230000),
(39, 13, 5, 2, '2018-12-04', 310000),
(40, 11, 5, 2, '2018-12-07', 470000),
(41, 12, 8, 7, '2018-12-08', 95000),
(42, 14, 8, 7, '2018-12-08', 95000),
(43, 15, 8, 7, '2018-12-10', 220000),
(44, 3, 8, 2, '2018-12-10', 40000),
(45, 16, 9, 2, '2018-12-10', 180000),
(46, 6, 9, 2, '2018-12-11', 200000),
(47, 18, 10, 2, '2018-12-11', 735000),
(48, 19, 10, 1, '2018-12-12', 310000),
(49, 9, 10, 1, '2018-12-12', 240000),
(50, 20, 5, 1, '2018-12-12', 310000),
(51, 3, 3, 2, '2018-12-20', 15000),
(52, 2, 3, 2, '2018-12-21', 15000),
(53, 10, 3, 2, '2018-12-21', 1200000),
(54, 10, 3, 2, '2018-12-21', 1200000),
(55, 10, 3, 2, '2018-12-21', 0),
(56, 2, 3, 2, '2018-12-22', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_transactions`
--
ALTER TABLE `service_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `spareparts`
--
ALTER TABLE `spareparts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sparepart_buys`
--
ALTER TABLE `sparepart_buys`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sparepart_buy_transaction_id` (`sparepart_buy_transaction_id`),
  ADD KEY `sparepart_id` (`sparepart_id`);

--
-- Indexes for table `sparepart_buy_transactions`
--
ALTER TABLE `sparepart_buy_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `operator_id` (`operator_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `sparepart_transactions`
--
ALTER TABLE `sparepart_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `sparepart_id` (`sparepart_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `mechanical_id` (`mechanical_id`),
  ADD KEY `operator_id` (`operator_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `service_transactions`
--
ALTER TABLE `service_transactions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;
--
-- AUTO_INCREMENT for table `spareparts`
--
ALTER TABLE `spareparts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `sparepart_buys`
--
ALTER TABLE `sparepart_buys`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `sparepart_buy_transactions`
--
ALTER TABLE `sparepart_buy_transactions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `sparepart_transactions`
--
ALTER TABLE `sparepart_transactions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`);

--
-- Constraints for table `service_transactions`
--
ALTER TABLE `service_transactions`
  ADD CONSTRAINT `service_transactions_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`),
  ADD CONSTRAINT `service_transactions_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`);

--
-- Constraints for table `sparepart_buys`
--
ALTER TABLE `sparepart_buys`
  ADD CONSTRAINT `sparepart_buys_ibfk_1` FOREIGN KEY (`sparepart_buy_transaction_id`) REFERENCES `sparepart_buy_transactions` (`id`),
  ADD CONSTRAINT `sparepart_buys_ibfk_2` FOREIGN KEY (`sparepart_id`) REFERENCES `spareparts` (`id`);

--
-- Constraints for table `sparepart_buy_transactions`
--
ALTER TABLE `sparepart_buy_transactions`
  ADD CONSTRAINT `sparepart_buy_transactions_ibfk_1` FOREIGN KEY (`operator_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `sparepart_buy_transactions_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`);

--
-- Constraints for table `sparepart_transactions`
--
ALTER TABLE `sparepart_transactions`
  ADD CONSTRAINT `sparepart_transactions_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`),
  ADD CONSTRAINT `sparepart_transactions_ibfk_2` FOREIGN KEY (`sparepart_id`) REFERENCES `spareparts` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`mechanical_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`operator_id`) REFERENCES `employees` (`id`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `send_message` ON SCHEDULE EVERY 1 SECOND STARTS '2018-10-24 00:16:04' ON COMPLETION PRESERVE ENABLE DO begin
	DECLARE total_customer BIGINT;
	DECLARE customer_id BIGINT;
	DECLARE i BIGINT DEFAULT 0;
	DECLARE num_rows INT;
	DECLARE latest_transaction DATE;
	DECLARE latest_date DATE;
	DECLARE delay_date INT;
	
	SELECT COUNT(*) INTO total_customer FROM customers;
	
	WHILE i < total_customer DO
		SELECT customers.`id` INTO customer_id FROM customers LIMIT i,1;
		SELECT COUNT(*) INTO num_rows FROM transactions WHERE transactions.`customer_id` = customer_id;
		
		IF num_rows > 0 THEN
			SELECT MAX(transactions.`date`) INTO latest_transaction FROM transactions, service_transactions WHERE transactions.`customer_id` = customer_id AND service_transactions.`transaction_id` = transactions.`id`;
			SET delay_date = DATEDIFF(DATE(NOW()), latest_transaction);
			
			IF delay_date >= 30 THEN
				SELECT COUNT(*) INTO num_rows FROM messages WHERE messages.`customer_id` = customer_id;
				
				IF num_rows > 0 THEN
					SELECT MAX(messages.`date`) INTO latest_date FROM messages WHERE messages.`customer_id` = customer_id;
					SET delay_date = DATEDIFF(DATE(NOW()), latest_date);
					
					IF delay_date >= 30 THEN
						INSERT INTO messages VALUES (NULL, customer_id, CONCAT("It's been ", delay_date, " days since your last service. Service your vehicle regularly so you can drive safely!"), DATE(NOW()));
					END IF;
				ELSE
					INSERT INTO messages VALUES (NULL, customer_id, CONCAT("It's been ", delay_date, " days since your last service. Service your vehicle regularly so you can drive safely!"), DATE(NOW()));
				END IF;
			END IF;
		END IF;
		
		SET i = i + 1;
	END WHILE;
end$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
