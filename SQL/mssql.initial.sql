CREATE TABLE [dbo].[collected_contacts] (
        [contact_id] [int] IDENTITY (1, 1) NOT NULL ,
        [user_id] [int] NOT NULL , 
        [changed] [datetime] NOT NULL ,
        [del] [char] (1) COLLATE Latin1_General_CI_AI NOT NULL , 
        [name] [varchar] (128) COLLATE Latin1_General_CI_AI NOT NULL ,
        [email] [varchar] (8000) COLLATE Latin1_General_CI_AI NOT NULL ,
        [firstname] [varchar] (128) COLLATE Latin1_General_CI_AI NOT NULL ,
        [surname] [varchar] (128) COLLATE Latin1_General_CI_AI NOT NULL ,
        [vcard] [text] COLLATE Latin1_General_CI_AI NULL ,
        [words] [text] COLLATE Latin1_General_CI_AI NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[collected_contacts] WITH NOCHECK ADD
        CONSTRAINT [PK_collected_contacts_contact_id] PRIMARY KEY  CLUSTERED
        (
                [contact_id]
        )  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[collected_contacts] ADD
        CONSTRAINT [DF_collected_contacts_user_id] DEFAULT (0) FOR [user_id],
        CONSTRAINT [DF_collected_contacts_changed] DEFAULT (getdate()) FOR [changed],
        CONSTRAINT [DF_collected_contacts_del] DEFAULT ('0') FOR [del],
        CONSTRAINT [DF_collected_contacts_name] DEFAULT ('') FOR [name],
        CONSTRAINT [DF_collected_contacts_email] DEFAULT ('') FOR [email],
        CONSTRAINT [DF_collected_contacts_firstname] DEFAULT ('') FOR [firstname],
        CONSTRAINT [DF_collected_contacts_surname] DEFAULT ('') FOR [surname],
        CONSTRAINT [CK_collected_contacts_del] CHECK ([del] = '1' or [del] = '0')
GO

CREATE  INDEX [IX_collected_contacts_user_id] ON [dbo].[collected_contacts]([user_id]) ON [PRIMARY]
GO
