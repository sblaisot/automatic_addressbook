-- Updates from version 0.5.1
-- Updates from version 0.5.2
-- Updates from version 0.5.3
-- Updates from version 0.5.4

ALTER TABLE [dbo].[collected_contacts] ADD [words] [text] COLLATE Latin1_General_CI_AI NULL 
GO

-- Updates from version 0.6
-- Updates from version 0.7-beta
-- Updates from version 0.7

ALTER TABLE [dbo].[collected_contacts] DROP CONSTRAINT [DF_collected_contacts_email]
GO
ALTER TABLE [dbo].[collected_contacts] ALTER COLUMN [email] [text] COLLATE Latin1_General_CI_AI NOT NULL
GO
ALTER TABLE [dbo].[collected_contacts] ADD CONSTRAINT [DF_collected_contacts_email] DEFAULT ('') FOR [email]
GO

-- Updates from version 0.8-rc

ALTER TABLE [dbo].[collected_contacts] DROP CONSTRAINT [DF_collected_contacts_email]
GO
ALTER TABLE [dbo].[collected_contacts] ALTER COLUMN [email] [varchar] (8000) COLLATE Latin1_General_CI_AI NOT NULL
GO
ALTER TABLE [dbo].[collected_contacts] ADD CONSTRAINT [DF_collected_contacts_email] DEFAULT ('') FOR [email]
GO


