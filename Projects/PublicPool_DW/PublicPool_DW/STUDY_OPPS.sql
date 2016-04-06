CREATE TABLE [dbo].[STUDY_OPPS](
	[SITE] [varchar](31) NULL,
	[MINORS_INVOLVED] [varchar](1) NULL,
	[TRIAL_TYPE] [varchar](50) NULL,
	[KCI_STUDY_ID] [varchar](50) NULL,
	[STUDY_TITLE] [varchar](max) NULL,
	[PI_LAST_NAME] [varchar](150) NULL,
	[CONTACT] [varchar](max) NULL,
	[PHONE] [char](20) NULL,
	[TRIAL_DESCRIPTION] [varchar](max) NULL,
	[EMAIL_ADDRESS] [char](255) NULL,
	[IRB_STUDY_ID] [varchar](255) NULL,
	[TRIAL_LOCATION] [varchar](60) NULL,
	[NCI_SITE] [varchar](50) NULL,
	[PI_FIRST_NAME] [varchar](150) NULL,
	[PI_DEGREE] [varchar](255) NULL,
	[ADOLESCENTS_AND_YOUNG_ADULTS] [varchar](1) NULL,
	[PI_EMPLOYEE_NUMBER] [varchar](30) NULL,
	[PI_EMAIL_ADDRESS] [varchar](255) NULL,
	[MEDICAL_CONDITION] [varchar](max) NULL,
	[ELIGIBILITY_CRITERIA] [varchar](max) NULL,
	[HEALTHY_VOLUNTEERS] [varchar](1) NULL,
	[PLACEBO_CHANCE] [varchar](max) NULL,
	[DURATION] [varchar](max) NULL,
	[SPONSOR] [varchar](max) NULL,
	[RECRUITMENT_END] [datetime] NULL,
	[COMPENSATION] [varchar](1) NULL,
	[COMPENSATION_AMOUNT] [varchar](max) NULL,
	[STUDY_STATUS] [varchar](255) NULL,
	[KCI_REQUIRED] [varchar](1) NULL,
	[APPROVAL_EFFECTIVE] [datetime] NULL,
	[STATE_ENTRY_DATE] [datetime] NULL,
	[SITE_GROUP] [varchar](24) NULL,
	[SOURCE_SYSTEM] [char](3) NULL,
	[Load_Date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO



