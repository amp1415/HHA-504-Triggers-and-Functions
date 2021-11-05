use synthea;
show tables;
Select  *
from clinical_data;

INSERT INTO clinical_data (patientUID, lastname, systolic,
diastolic) VALUES (141514, 'Amanda', 120, 70);
Select Description, totalcost, Medicationcost(totalcost)
From medications;
##Trigger
delimiter $$
Create Trigger quaitydiastolic before insert on clinical_data 
for each row
Begin
IF NEW.diastolic >= 450 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: diastolic BP MUST BE BELOW 200 mg!';
END IF;
END; $$

##Function
Delimiter $$
Create function Medicationcost (cost DECIMAL(10,2))
returns varchar (20)
DETERMINISTIC
BEGIN
DECLARE drugCost VARCHAR(20);
IF cost > 300 THEN

SET drugCost = ‘high’;
ELSEIF (cost >= 10 AND
credit <= 300) THEN

SET drugCost = 'standard';
ELSEIF cost < 10 THEN
SET drugCost = 'Low';
END IF;
RETURN (drugCost);
END$$
DELIMITER ;



 
