CREATE DATABASE HistoricalGuideDB

USE HistoricalGuideDB

CREATE TABLE Country -- держава
(
	CountryId INT, -- ІД держави
	"Name" NVARCHAR(200) NOT NULL, -- ім'я
	StartDate DATE NOT NULL, -- дата заснування 
	EndDate DATE NULL, -- дата розпаду 
	TypeGoverning NVARCHAR(100) NULL, -- тип правління

	PRIMARY KEY (CountryId)
)


CREATE TABLE Leading -- Правитель
(
	LeadingId INT, -- ІД правителя
	CountryId INT, -- ідентифікатор держави
	"Name" NVARCHAR(100) NOT NULL, -- ім'я
	StartDateReign DATE NOT NULL, -- дата початку правління
	EndDateReign DATE NULL, -- дата закінчення правління

	PRIMARY KEY(LeadingId),
	FOREIGN KEY(CountryId) REFERENCES Country(CountryId)
)


CREATE TABLE Capital -- Столиця
(
	CapitalId INT, -- ІД столиці
	CountryId INT, -- ІД держави
	"Name" NVARCHAR(100) NOT NULL, -- назва
	StartYear INT NOT NULL, -- з якого року є столицею

	PRIMARY KEY(CapitalId),
	FOREIGN KEY(CountryId) REFERENCES Country(CountryId)
)


CREATE TABLE Reform -- Реформа
(
	ReformId INT, -- ІД реформи
	"Name" NVARCHAR(200) NOT NULL, -- назва
	EventDate DATE NOT NULL, -- дата проведення

	PRIMARY KEY(ReformId)
)

CREATE TABLE ReformCountry -- РеформаКраїна
(
	ReformId INT, -- ІД реформи
	CountryId INT, -- ІД країни

	PRIMARY KEY(ReformId, CountryId),
	FOREIGN KEY(ReformId) REFERENCES Reform(ReformId),
	FOREIGN KEY(CountryId) REFERENCES Country(CountryId)
)



CREATE TABLE HistoricalPeriod -- історичний період
(
	HistoricalPeriodId INT, -- ІД історичного періоду
	"Name" NVARCHAR(200) NOT NULL, -- ім'я
	StartDate DATE NOT NULL, -- дата початку 
	EndDate DATE NULL, -- дата закінчення 

	PRIMARY KEY(HistoricalPeriodId)
)


CREATE TABLE HistoricalPeriodCountry -- ІсторичнийПеріодДержава
(
	HistoricalPeriodId INT, -- ІД історичного періоду
	CountryId INT, -- ІД держави

	PRIMARY KEY(HistoricalPeriodId, CountryId),
	FOREIGN KEY(HistoricalPeriodId) REFERENCES HistoricalPeriod(HistoricalPeriodId),
	FOREIGN KEY(CountryId) REFERENCES Country(CountryId)
)



CREATE TABLE Nation -- Народ
(
	NationId INT, -- ІД народу
	"Name" NVARCHAR(100), -- назва
	StartDateExistence DATE NOT NULL, -- дата початку існування
	EndDateExistence DATE NULL, -- дата кінця існування

	PRIMARY KEY(NationId)
)



CREATE TABLE NationCountry -- НародДержава
(
	NationId INT, -- ІД народу
	CountryId INT, -- ІД держава

	PRIMARY KEY(NationId, CountryId),
	FOREIGN KEY(NationId) REFERENCES Nation(NationId),
	FOREIGN KEY(CountryId) REFERENCES Country(CountryId)
)



CREATE TABLE HistoricalEvent -- історична подія
(
	HistoricalEventId INT, -- ІД історичної події
	"Name" NVARCHAR(200) NOT NULL, -- назва
	StartDate DATE NOT NULL, -- дата початку
	EndDate DATE NULL, -- дата закінчення

	PRIMARY KEY(HistoricalEventId)
)


CREATE TABLE HistoricalFigure -- історична особистість
(
	HistoricalFigureId INT, -- ІД історичної особистості
	"Name" NVARCHAR(200) NOT NULL, -- ім'я
	StartDateActivity DATE NOT NULL, -- дата початку діяльності
	EndDateActivity DATE NULL, -- дата закінчення діяльності

	PRIMARY KEY (HistoricalFigureId)
)


CREATE TABLE EventFigureCountry -- ПодіяОсобистістьДержава
(
	HistoricalFigureId INT, -- ІД історичної особистості
	HistoricalEventId INT, -- ІД історичної події
	CountryId INT, -- ІД держави
	StartDate DATE NOT NULL, -- дата початку участі
	EndDate DATE NULL, -- дата кінця участі

	PRIMARY KEY (HistoricalFigureId, HistoricalEventId, CountryId), 
	FOREIGN KEY(HistoricalFigureId) REFERENCES HistoricalFigure(HistoricalFigureId),
	FOREIGN KEY(HistoricalEventId) REFERENCES HistoricalEvent(HistoricalEventId),
	FOREIGN KEY(CountryId) REFERENCES Country(CountryId)
)

