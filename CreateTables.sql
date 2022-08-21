CREATE DATABASE HistoricalGuideDB

USE HistoricalGuideDB

CREATE TABLE Country -- �������
(
	CountryId INT, -- �� �������
	"Name" NVARCHAR(200) NOT NULL, -- ��'�
	StartDate DATE NOT NULL, -- ���� ���������� 
	EndDate DATE NULL, -- ���� ������� 
	TypeGoverning NVARCHAR(100) NULL, -- ��� ��������

	PRIMARY KEY (CountryId)
)


CREATE TABLE Leading -- ���������
(
	LeadingId INT, -- �� ���������
	CountryId INT, -- ������������� �������
	"Name" NVARCHAR(100) NOT NULL, -- ��'�
	StartDateReign DATE NOT NULL, -- ���� ������� ��������
	EndDateReign DATE NULL, -- ���� ��������� ��������

	PRIMARY KEY(LeadingId),
	FOREIGN KEY(CountryId) REFERENCES Country(CountryId)
)


CREATE TABLE Capital -- �������
(
	CapitalId INT, -- �� �������
	CountryId INT, -- �� �������
	"Name" NVARCHAR(100) NOT NULL, -- �����
	StartYear INT NOT NULL, -- � ����� ���� � ��������

	PRIMARY KEY(CapitalId),
	FOREIGN KEY(CountryId) REFERENCES Country(CountryId)
)


CREATE TABLE Reform -- �������
(
	ReformId INT, -- �� �������
	"Name" NVARCHAR(200) NOT NULL, -- �����
	EventDate DATE NOT NULL, -- ���� ����������

	PRIMARY KEY(ReformId)
)

CREATE TABLE ReformCountry -- ������������
(
	ReformId INT, -- �� �������
	CountryId INT, -- �� �����

	PRIMARY KEY(ReformId, CountryId),
	FOREIGN KEY(ReformId) REFERENCES Reform(ReformId),
	FOREIGN KEY(CountryId) REFERENCES Country(CountryId)
)



CREATE TABLE HistoricalPeriod -- ���������� �����
(
	HistoricalPeriodId INT, -- �� ����������� ������
	"Name" NVARCHAR(200) NOT NULL, -- ��'�
	StartDate DATE NOT NULL, -- ���� ������� 
	EndDate DATE NULL, -- ���� ��������� 

	PRIMARY KEY(HistoricalPeriodId)
)


CREATE TABLE HistoricalPeriodCountry -- ����������������������
(
	HistoricalPeriodId INT, -- �� ����������� ������
	CountryId INT, -- �� �������

	PRIMARY KEY(HistoricalPeriodId, CountryId),
	FOREIGN KEY(HistoricalPeriodId) REFERENCES HistoricalPeriod(HistoricalPeriodId),
	FOREIGN KEY(CountryId) REFERENCES Country(CountryId)
)



CREATE TABLE Nation -- �����
(
	NationId INT, -- �� ������
	"Name" NVARCHAR(100), -- �����
	StartDateExistence DATE NOT NULL, -- ���� ������� ���������
	EndDateExistence DATE NULL, -- ���� ���� ���������

	PRIMARY KEY(NationId)
)



CREATE TABLE NationCountry -- ������������
(
	NationId INT, -- �� ������
	CountryId INT, -- �� �������

	PRIMARY KEY(NationId, CountryId),
	FOREIGN KEY(NationId) REFERENCES Nation(NationId),
	FOREIGN KEY(CountryId) REFERENCES Country(CountryId)
)



CREATE TABLE HistoricalEvent -- ��������� ����
(
	HistoricalEventId INT, -- �� ��������� ��䳿
	"Name" NVARCHAR(200) NOT NULL, -- �����
	StartDate DATE NOT NULL, -- ���� �������
	EndDate DATE NULL, -- ���� ���������

	PRIMARY KEY(HistoricalEventId)
)


CREATE TABLE HistoricalFigure -- ��������� ����������
(
	HistoricalFigureId INT, -- �� ��������� ����������
	"Name" NVARCHAR(200) NOT NULL, -- ��'�
	StartDateActivity DATE NOT NULL, -- ���� ������� ��������
	EndDateActivity DATE NULL, -- ���� ��������� ��������

	PRIMARY KEY (HistoricalFigureId)
)


CREATE TABLE EventFigureCountry -- ���������������������
(
	HistoricalFigureId INT, -- �� ��������� ����������
	HistoricalEventId INT, -- �� ��������� ��䳿
	CountryId INT, -- �� �������
	StartDate DATE NOT NULL, -- ���� ������� �����
	EndDate DATE NULL, -- ���� ���� �����

	PRIMARY KEY (HistoricalFigureId, HistoricalEventId, CountryId), 
	FOREIGN KEY(HistoricalFigureId) REFERENCES HistoricalFigure(HistoricalFigureId),
	FOREIGN KEY(HistoricalEventId) REFERENCES HistoricalEvent(HistoricalEventId),
	FOREIGN KEY(CountryId) REFERENCES Country(CountryId)
)

