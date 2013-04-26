USE PSBC_DW
go

-- This is a 
CREATE VIEW vwReliance AS
SELECT
BC_DETERMINATION_ID DeterminationID,
bcd.ETQ$CREATED_DATE CreatedDate,
bcd.ETQ$MODIFIED_DATE ModifiedDate,
us1.FIRST_NAME + ' ' + us1.LAST_NAME Author,
ps.DISPLAY_NAME Phase,
us2.FIRST_NAME + ' ' + us2.LAST_NAME LastEditor,
bcd.ETQ$NUMBER ORFNum,
bcd.ETQ$DUE_DATE DueDate,
us3.FIRST_NAME + ' ' + us3.LAST_NAME RequestedBy,
CASE bcd.ETQ$ROUTING_TYPE 
	WHEN 1 THEN 'Parallel'
	WHEN 3 THEN 'Voting'
END RoutingType,
CASE bcd.TSL_BILLING_ADJ
	WHEN 1 THEN 'Yes'
	WHEN 2 THEN 'No'
	ELSE NULL
END TSL_Billing_Adj,
bcd.BC_MEDREC_NBR,
bcd.BC_PATIENT_SEX,
bcd.BC_CONTACT_TITLE,
bcd.BC_CODE1,
bcd.BC_CODE2,
bcd.BC_CODE3,
bcd.BC_CODE4,
bcd.BC_CODE5,
bcd.BC_CODE6,
bcd.BC_PSBC_PATIENT_NBR,
CASE bcd.TSL_AMMENDED_REPORT
	WHEN 1 THEN 'Yes'
	WHEN 2 THEN 'No'
	ELSE NULL
END TSL_Ammended_Report,
bcd.BC_MISC_COST,
CONVERT(DATETIME, bcd.BC_BPDR_DUE_ON) BPDR_DUE_ON,
bcd.BC_NBR_OF_UNITS,
bcd.BC_NBR_UNITS_INVLVD,
CASE bcd.BC_PRODUCT_RELSD
	WHEN 1 THEN 'Yes'
	WHEN 2 THEN 'No'
	ELSE NULL
END	Product_Relsd,
bcd.BC_ORDER_NBR OrderNumber1,
bcd.BC_ORDER_NUMBER OrderNumber2,
CASE bcd.BC_BPDR_YES_NO
	WHEN 1 THEN 'Yes'
	WHEN 2 THEN 'No'
	ELSE NULL
END BPDR,
bcd.BC_QARA_REV_COMMENT,
bcd.BC_IMMED_ACTION,
bcd.BC_CORRECTIVE_ACTION,
te.[description] TestEquipment,
bcd.BC_WHAT_HAPPENED, 
bcd.BC_DATE_OCCURRED,
loc.description Location,
bcd.BC_LOCATION,
bcd.bc_extrn_locations,
CASE bcd.BC_INTERDEPT 
	WHEN 1 THEN 'Yes'
	WHEN 2 THEN 'No'
	ELSE NULL
END InterDept, 
convert(char(5), bcd.BC_TIME_DISCOVERED, 108) TimeDiscovered,
bcd.BC_INVESTIGATION Investigation,
bcd.BC_OTHER_NBR OtherNumber,
dep.description Department,
CASE bcd.BC_OCCURENCE_TYPE
	WHEN 1 THEN 'Internal Occurrence'
	WHEN 2 THEN 'External Occurrence'
	WHEN 3 THEN 'Potential Adverse Reaction'
	ELSE NULL
END OccurenceType,
bcd.BC_BBCS_DONOR_NBR BBCSDonorNum,
bcd.BC_DATE_DISCOVERED DateDiscovered,
bcd.BC_DEPT_QA_REVIEW,
bcd.ETQ$COMPLETED_DATE,
bcd.ETQ$AWAITING_RELEASE_DATE
FROM reliance.BC_Determination bcd
	LEFT OUTER JOIN Reliance.User_Settings us1
	ON bcd.[ETQ$AUTHOR] = [USER_ID]		
	INNER JOIN Reliance.Phase_Settings ps
	ON bcd.ETQ$CURRENT_PHASE = ps.PHASE_ID
	LEFT OUTER JOIN Reliance.User_Settings us2
	ON bcd.ETQ$LAST_EDITOR = us2.[USER_ID]
	INNER JOIN Reliance.User_Settings us3
	ON bcd.ETQ$REQUESTED_BY = us3.[USER_ID]
	LEFT OUTER JOIN Reliance.bc_test_equipment te
	ON bcd.BC_TEST_EQUIPMENT_ID = te.bc_test_equipment_id
	LEFT OUTER JOIN Reliance.BC_Location loc
	ON bcd.BC_LOCATION = loc.BC_LOCATION_ID
	INNER JOIN Reliance.BC_Departments dep
	ON bcd.BC_DISCOVERED_BY = dep.bc_departments_id

--SELECT COUNT(*) FROM vwReliance
--SELECT COUNT(*) FROM Reliance.BC_DETERMINATION

--DROP VIEW vwReliance