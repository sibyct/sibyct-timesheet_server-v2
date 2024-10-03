CREATE TABLE Employee (
    EmployeeID SERIAL PRIMARY KEY,      -- SERIAL for auto-incrementing integers
    EmployeeNo VARCHAR NOT NULL,
    Designation VARCHAR NOT NULL,
    Grade VARCHAR,
    ManagerID INTEGER,
    IsActive CHAR,
    CreatedBy VARCHAR,
    CreatedOn TIMESTAMP,                -- Use TIMESTAMP for date-time fields
    ModifiedBy VARCHAR,
    ModifiedOn TIMESTAMP,
    MobileNo VARCHAR,
    EmailID VARCHAR
);

CREATE TABLE EmployeeDemographics (
    DemographyID SERIAL PRIMARY KEY,    -- SERIAL for auto-incrementing integers
    FirstName VARCHAR,
    MiddleName VARCHAR,
    LastName VARCHAR,
    Address1 VARCHAR,
    Address2 VARCHAR,
    Address3 VARCHAR,
    City VARCHAR,
    State VARCHAR,
    Country VARCHAR,
    PostCode VARCHAR,
    SSN VARCHAR,
    Gender CHAR,
    EmergencyContactNo VARCHAR,
    IsActive CHAR,
    CreatedBy VARCHAR,
    CreatedOn TIMESTAMP,               -- Use TIMESTAMP instead of DATETIME
    ModifiedBy VARCHAR,
    ModifiedOn TIMESTAMP,
    EmployeeID INTEGER NOT NULL         -- Foreign key to Employee table
);

CREATE TABLE RoleMaster (
    RoleID SERIAL PRIMARY KEY,         -- SERIAL for auto-incrementing integers
    RoleName VARCHAR,
    IsActive CHAR,
    CreatedBy VARCHAR,
    CreatedOn TIMESTAMP,               -- Use TIMESTAMP for date-time fields
    ModifiedBy VARCHAR,
    ModifiedOn TIMESTAMP
);

CREATE TABLE UserMaster (
    UserID SERIAL PRIMARY KEY,         -- SERIAL for auto-incrementing integers
    UserName VARCHAR,
    Password BYTEA,                    -- Use BYTEA for binary data (instead of VARBINARY)
    PasswordSalt BYTEA,                -- Use BYTEA for binary data (instead of VARBINARY)
    EmployeeID INTEGER,
    UserEmail VARCHAR,
    IsActive CHAR,
    CreatedBy VARCHAR,
    CreatedOn TIMESTAMP,               -- Use TIMESTAMP for date-time fields
    ModifiedBy VARCHAR,
    ModifiedOn TIMESTAMP
);

CREATE TABLE UserRoleMapping (
    UserRoleMapID SERIAL PRIMARY KEY,  -- SERIAL for auto-incrementing integers
    UserID INTEGER,
    RoleID INTEGER,
    IsActive CHAR,
    CreatedBy VARCHAR,
    CreatedOn TIMESTAMP,               -- Use TIMESTAMP instead of DATETIME
    ModifiedBy VARCHAR,
    ModifiedOn TIMESTAMP
);

CREATE TABLE AttendanceMaster (
    AttendanceID SERIAL PRIMARY KEY,   -- SERIAL for auto-incrementing integers
    EmployeeID INTEGER NOT NULL,
    TotalWorkingDays DECIMAL NOT NULL, -- Use DECIMAL for numeric data
    TotalPresent DECIMAL,
    TotalAbsent DECIMAL,
    TotalLeave DECIMAL,
    AttendanceMonth VARCHAR,
    IsActive CHAR
);

CREATE TABLE AttendanceDetail (
    AttendanceDetID SERIAL PRIMARY KEY,  -- SERIAL for auto-incrementing integers
    AttendanceID INTEGER,
    EntryTime TIMESTAMP,                 -- Use TIMESTAMP for date-time fields
    EntryBioID INTEGER,
    ExitTime TIMESTAMP,                  -- Use TIMESTAMP for date-time fields
    ExitBioID INTEGER,
    TotalHours DECIMAL,                  -- Use DECIMAL for numeric values
    CreatedBy VARCHAR,
    CreatedOn DATE,                      -- Use DATE for date-only fields
    ModifiedBy VARCHAR,
    ModifiedOn TIMESTAMP,                -- Use TIMESTAMP for date-time fields
    Notes VARCHAR
);

ALTER TABLE EmployeeDemographics
ADD FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE UserMaster
ADD CONSTRAINT unique_employeeid UNIQUE (EmployeeID);

ALTER TABLE Employee
ADD FOREIGN KEY (EmployeeID) REFERENCES UserMaster (EmployeeID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE UserMaster
ADD FOREIGN KEY (UserID) REFERENCES UserRoleMapping (UserID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE UserRoleMapping
ADD CONSTRAINT unique_roleid UNIQUE (RoleID);

ALTER TABLE RoleMaster
ADD FOREIGN KEY (RoleID) REFERENCES UserRoleMapping (RoleID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AttendanceDetail
ADD CONSTRAINT unique_attendanceid UNIQUE (AttendanceID);

ALTER TABLE AttendanceMaster
ADD FOREIGN KEY (AttendanceID) REFERENCES AttendanceDetail (AttendanceID)
ON UPDATE NO ACTION ON DELETE NO ACTION;


ALTER TABLE AttendanceMaster
ADD FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID)
ON UPDATE NO ACTION ON DELETE NO ACTION;