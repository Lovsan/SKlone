﻿CREATE TABLE [dbo].[Accounts] (
    [kdID]     INT            IDENTITY (1, 1) NOT NULL,
    [Account]  NVARCHAR (16)  NOT NULL,
    [Password] NVARCHAR (16)  NOT NULL,
    [Email]    NVARCHAR (256) NOT NULL,
    CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED ([kdID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Accounts]
    ON [dbo].[Accounts]([kdID] ASC);

