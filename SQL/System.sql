USE [Max_System]
GO
/****** Object:  Table [dbo].[SYS_Role]    Script Date: 2018/10/21 23:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_Role](
	[SystemRoleId] [varchar](50) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
	[Status] [int] NOT NULL,
	[Permissions] [varchar](max) NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_ROLE] PRIMARY KEY CLUSTERED 
(
	[SystemRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_User]    Script Date: 2018/10/21 23:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_User](
	[SystemUserId] [varchar](50) NOT NULL,
	[UserName] [varchar](30) NOT NULL,
	[Password] [varchar](250) NOT NULL,
	[RealName] [nvarchar](20) NULL,
	[Email] [varchar](50) NULL,
	[UserType] [int] NOT NULL,
	[Mobile] [varchar](20) NULL,
	[Status] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[SystemId] [int] NOT NULL,
 CONSTRAINT [PK_SYS_USER] PRIMARY KEY CLUSTERED 
(
	[SystemUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_UserRoles]    Script Date: 2018/10/21 23:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_UserRoles](
	[SystemUserId] [varchar](50) NOT NULL,
	[SystemRoleId] [varchar](50) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_USERROLES] PRIMARY KEY CLUSTERED 
(
	[SystemUserId] ASC,
	[SystemRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_UserRoles]    Script Date: 2018/10/21 23:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*==============================================================*/
/* View: V_UserRoles                                            */
/*==============================================================*/
create view [dbo].[V_UserRoles] as
select
   u.[SystemUserId],
   u.[UserName],
   u.[RealName],
   u.[Email],
   u.[UserType],
   u.[Mobile],
   u.[Status] as UserStatus,
   u.[CreateTime],
   u.[SystemId],
   r.SystemRoleId,
   r.RoleName,
   r.[Status] as RoleStatus,
   r.[Permissions]
from
   SYS_User u
   inner join SYS_UserRoles ur on  ur.SystemUserId = u.SystemUserId
   inner join SYS_Role r on  r.SystemRoleId = ur.SystemRoleId;
GO
/****** Object:  Table [dbo].[SYS_Action]    Script Date: 2018/10/21 23:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_Action](
	[ActionId] [varchar](50) NOT NULL,
	[ParentId] [varchar](50) NULL,
	[ActionName] [nvarchar](50) NOT NULL,
	[Url] [varchar](250) NOT NULL,
	[IconClass] [varchar](50) NULL,
	[Sort] [int] NOT NULL,
	[LevelSort] [varchar](500) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
	[SystemId] [int] NOT NULL,
 CONSTRAINT [PK_SYS_ACTION] PRIMARY KEY CLUSTERED 
(
	[ActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_ActionPerms]    Script Date: 2018/10/21 23:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_ActionPerms](
	[ActionId] [varchar](50) NOT NULL,
	[PermCode] [varchar](1024) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_ACTIONPERMS] PRIMARY KEY CLUSTERED 
(
	[ActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_Log]    Script Date: 2018/10/21 23:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_Log](
	[LogId] [varchar](36) NOT NULL,
	[LogType] [int] NOT NULL,
	[Remark] [nvarchar](1000) NOT NULL,
	[KeyWord] [nvarchar](200) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_LOG] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_Permission]    Script Date: 2018/10/21 23:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_Permission](
	[PermId] [nvarchar](50) NOT NULL,
	[PermName] [nvarchar](50) NOT NULL,
	[PermCode] [int] NOT NULL,
	[Controller] [varchar](50) NULL,
	[SystemId] [int] NOT NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_PERMISSION] PRIMARY KEY CLUSTERED 
(
	[PermId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_PermissionGroup]    Script Date: 2018/10/21 23:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_PermissionGroup](
	[GroupId] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](50) NOT NULL,
	[Permissions] [nvarchar](max) NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_PERMISSIONGROUP] PRIMARY KEY CLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYS_RoleMenus]    Script Date: 2018/10/21 23:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYS_RoleMenus](
	[RoleId] [varchar](50) NOT NULL,
	[ActionId] [varchar](50) NOT NULL,
	[CreateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SYS_ROLEMENUS] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[ActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[SYS_Action] ([ActionId], [ParentId], [ActionName], [Url], [IconClass], [Sort], [LevelSort], [CreateTime], [SystemId]) VALUES (N'0409fe87-0c6f-4cd8-b6d7-b23d3d7fc321', N'dd4d4422-c22a-4fa9-b89f-a9fec6ec273b', N'菜单管理', N'/menu/list', NULL, 4, N'0-20181013193119-4-20181013193544', CAST(N'2018-10-13T19:35:44.777' AS DateTime), 1)
GO
INSERT [dbo].[SYS_Action] ([ActionId], [ParentId], [ActionName], [Url], [IconClass], [Sort], [LevelSort], [CreateTime], [SystemId]) VALUES (N'1b0fcd40-8dd2-4530-b596-1fd9c158b903', N'53430cdd-2380-4424-9f7e-0f7c019ef703', N'支付渠道管理', N'/paychannel/list', NULL, 4, N'2-20181014142133-4-20181021011130', CAST(N'2018-10-21T01:11:30.360' AS DateTime), 1)
GO
INSERT [dbo].[SYS_Action] ([ActionId], [ParentId], [ActionName], [Url], [IconClass], [Sort], [LevelSort], [CreateTime], [SystemId]) VALUES (N'53430cdd-2380-4424-9f7e-0f7c019ef703', NULL, N'支付管理', N'#', NULL, 2, N'2-20181014142133', CAST(N'2018-10-14T14:21:33.000' AS DateTime), 1)
GO
INSERT [dbo].[SYS_Action] ([ActionId], [ParentId], [ActionName], [Url], [IconClass], [Sort], [LevelSort], [CreateTime], [SystemId]) VALUES (N'9735da31-296d-4ceb-83b7-ec1bec3aa99c', N'53430cdd-2380-4424-9f7e-0f7c019ef703', N'支付产品管理', N'/payproduct/list', NULL, 3, N'2-20181014142133-3-20181020184314', CAST(N'2018-10-20T18:43:14.423' AS DateTime), 1)
GO
INSERT [dbo].[SYS_Action] ([ActionId], [ParentId], [ActionName], [Url], [IconClass], [Sort], [LevelSort], [CreateTime], [SystemId]) VALUES (N'a2212ea9-d3a9-4051-801f-6da7b1ddd8fa', N'dd4d4422-c22a-4fa9-b89f-a9fec6ec273b', N'角色管理', N'/roles/list', NULL, 2, N'0-20181013193119-2-20181013193341', CAST(N'2018-10-13T19:33:41.250' AS DateTime), 1)
GO
INSERT [dbo].[SYS_Action] ([ActionId], [ParentId], [ActionName], [Url], [IconClass], [Sort], [LevelSort], [CreateTime], [SystemId]) VALUES (N'a38adbc7-73d6-4635-a1c5-d7a31aee1172', N'53430cdd-2380-4424-9f7e-0f7c019ef703', N'商户管理', N'/merchant/list', NULL, 2, N'2-20181014142133-2-20181020175800', CAST(N'2018-10-20T17:58:00.763' AS DateTime), 1)
GO
INSERT [dbo].[SYS_Action] ([ActionId], [ParentId], [ActionName], [Url], [IconClass], [Sort], [LevelSort], [CreateTime], [SystemId]) VALUES (N'acd90471-8e25-44f1-a4d5-ba889be59925', N'53430cdd-2380-4424-9f7e-0f7c019ef703', N'银行管理', N'/bank/list', NULL, 1, N'2-20181014142133-1-20181014142152', CAST(N'2018-10-14T14:21:52.000' AS DateTime), 1)
GO
INSERT [dbo].[SYS_Action] ([ActionId], [ParentId], [ActionName], [Url], [IconClass], [Sort], [LevelSort], [CreateTime], [SystemId]) VALUES (N'b2cb76cf-be96-4618-a4d6-425ecfb34815', N'dd4d4422-c22a-4fa9-b89f-a9fec6ec273b', N'权限组管理', N'/permission/list', NULL, 5, N'0-20181013193119-5-20181013193652', CAST(N'2018-10-13T19:36:52.313' AS DateTime), 1)
GO
INSERT [dbo].[SYS_Action] ([ActionId], [ParentId], [ActionName], [Url], [IconClass], [Sort], [LevelSort], [CreateTime], [SystemId]) VALUES (N'cc436bac-c552-4802-8097-b25eff2f276f', N'dd4d4422-c22a-4fa9-b89f-a9fec6ec273b', N'用户管理', N'/account/list', NULL, 1, N'0-20181013193119-1-20181013193255', CAST(N'2018-10-13T19:32:55.193' AS DateTime), 1)
GO
INSERT [dbo].[SYS_Action] ([ActionId], [ParentId], [ActionName], [Url], [IconClass], [Sort], [LevelSort], [CreateTime], [SystemId]) VALUES (N'd8b6cf32-e81c-4cf4-878b-52fd7f473142', N'dd4d4422-c22a-4fa9-b89f-a9fec6ec273b', N'系统图标', N'/system/icon', NULL, 8, N'0-20181013193119-8-20181013193208', CAST(N'2018-10-13T19:32:08.483' AS DateTime), 1)
GO
INSERT [dbo].[SYS_Action] ([ActionId], [ParentId], [ActionName], [Url], [IconClass], [Sort], [LevelSort], [CreateTime], [SystemId]) VALUES (N'dd4d4422-c22a-4fa9-b89f-a9fec6ec273b', NULL, N'系统管理', N'#', NULL, 0, N'0-20181013193119', CAST(N'2018-10-13T19:31:19.637' AS DateTime), 1)
GO
INSERT [dbo].[SYS_ActionPerms] ([ActionId], [PermCode], [CreateTime]) VALUES (N'0409fe87-0c6f-4cd8-b6d7-b23d3d7fc321', N'1007,1008,1006,1017', CAST(N'2018-10-13T19:44:59.730' AS DateTime))
GO
INSERT [dbo].[SYS_ActionPerms] ([ActionId], [PermCode], [CreateTime]) VALUES (N'1b0fcd40-8dd2-4530-b596-1fd9c158b903', N'20032,20030,20034,20033,20031', CAST(N'2018-10-21T21:57:11.730' AS DateTime))
GO
INSERT [dbo].[SYS_ActionPerms] ([ActionId], [PermCode], [CreateTime]) VALUES (N'9735da31-296d-4ceb-83b7-ec1bec3aa99c', N'20015,20017,20016,20019,20018', CAST(N'2018-10-21T22:04:04.463' AS DateTime))
GO
INSERT [dbo].[SYS_ActionPerms] ([ActionId], [PermCode], [CreateTime]) VALUES (N'a2212ea9-d3a9-4051-801f-6da7b1ddd8fa', N'10026,10022,10027,10025,10021,10023', CAST(N'2018-10-13T19:44:55.580' AS DateTime))
GO
INSERT [dbo].[SYS_ActionPerms] ([ActionId], [PermCode], [CreateTime]) VALUES (N'a38adbc7-73d6-4635-a1c5-d7a31aee1172', N'20013,20011,2009,2008,20012,20038,20010,20014,2007,2006,20036,20037,20035', CAST(N'2018-10-21T22:04:41.103' AS DateTime))
GO
INSERT [dbo].[SYS_ActionPerms] ([ActionId], [PermCode], [CreateTime]) VALUES (N'acd90471-8e25-44f1-a4d5-ba889be59925', N'2000,2002,2003,2001', CAST(N'2018-10-14T16:36:20.060' AS DateTime))
GO
INSERT [dbo].[SYS_ActionPerms] ([ActionId], [PermCode], [CreateTime]) VALUES (N'b2cb76cf-be96-4618-a4d6-425ecfb34815', N'10013,10012,1009,10011,10010', CAST(N'2018-10-13T19:45:07.490' AS DateTime))
GO
INSERT [dbo].[SYS_ActionPerms] ([ActionId], [PermCode], [CreateTime]) VALUES (N'cc436bac-c552-4802-8097-b25eff2f276f', N'1004,1005,1002,10024,1003', CAST(N'2018-10-13T19:44:49.077' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'03351499-cd3f-4534-a706-5e2a5d2dc6ff', N'编辑商户支付产品', 20036, N'merchantpay', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'070f98e6-21ad-49d4-bc32-8f88bdcd57db', N'编辑菜单', 1007, N'menu', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'078a96d1-bf04-4e79-be23-ac4cf0b2bcfb', N'删除支付渠道', 20033, N'paychannel', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'0a206670-798c-4a5c-b16c-133bbfe9636f', N'删除商户支付产品', 20037, N'merchantpay', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'14bc0958-f852-4004-87c6-016c7ec74734', N'支付产品列表', 20015, N'payproduct', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'1f77d2b3-9f46-4f13-b45b-00910be2a589', N'编辑支付产品', 20017, N'payproduct', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'241d9041-5ff5-4b88-8684-f67ba6f45cd6', N'删除商户银行卡', 20013, N'merchant', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'24ca7d53-4878-41bb-bfcf-05a757ca4f0e', N'新增菜单', 1006, N'menu', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'31835d80-4796-47e2-bf36-e125eb4b6050', N'编辑管理员', 1004, N'account', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'3776cbe9-6b2b-4ac4-948a-71110f2c41db', N'新增商户银行卡', 20011, N'merchant', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'3891e49b-2424-436c-aab4-8915a12fdf43', N'开通商户支付产品', 20035, N'merchantpay', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'45f91f70-d2d0-4fa3-a80d-97a2ef4de128', N'删除商户', 2009, N'merchant', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'56a33d3e-765e-479e-b81d-7567638d9dfc', N'银行列表', 2001, N'bank', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'5c947db4-750b-4533-b179-32c93e8bd623', N'Mongo缓存清除', 1994, N'mongo', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'5e009800-6040-4024-9ee3-911f6036eaf2', N'编辑支付渠道', 20032, N'paychannel', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'5e8743db-825a-4a0b-9fb6-578d43521e2e', N'编辑商户', 2008, N'merchant', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'6454201d-2497-4d44-ac30-60e54de62fea', N'导出银行列表', 2005, N'bank', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'655d79ae-62ac-4fbf-83d3-cae35ebd573a', N'支付渠道列表', 20030, N'paychannel', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'663395e1-8be2-4c2d-9d7b-95c01f454729', N'添加权限到权限组', 10012, N'permission', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'6f2c759e-aa38-42f2-9dd7-83b72c56540e', N'新增支付产品', 20016, N'payproduct', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'708091d9-551a-43c8-8efb-60929ad913c6', N'编辑角色用户', 10027, N'roles', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'77dd73e5-bde3-48b0-9287-63bdb5eb3734', N'导出支付产品列表', 20019, N'payproduct', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'802e9a79-a9f9-402f-b568-34ea5b711bcb', N'编辑角色', 10022, N'roles', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'85d6f9d5-3db4-4e3d-9b6b-fe2da1c81575', N'编辑商户银行卡', 20012, N'merchant', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'87ea2920-4a41-40f3-9c17-3a8407667655', N'删除菜单', 1008, N'menu', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'8c9977dc-9ccf-4194-a5a9-06246e15d876', N'删除管理员', 1005, N'account', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'8d6358f3-a08c-45c8-af90-7ff98d266aef', N'删除支付产品', 20018, N'payproduct', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'9175b362-05d5-408c-ad39-afc13e413de3', N'浏览管理员列表', 1002, N'account', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'95c8594f-e8cf-45de-8ab7-40dbd6a65772', N'Mongo缓存查询', 1993, N'mongo', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'95ce47e9-3675-49ca-b8dd-4b3dc3e95f24', N'新增支付渠道', 20031, N'paychannel', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'9f4f7230-a8b9-4cdf-99ee-2cd0c1534b0a', N'添加角色', 10021, N'roles', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'a6dd08ad-5bbb-4165-a6c6-f980a072c9e2', N'编辑管理员所属角色', 10024, N'account', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'a8bf4288-e8a9-4354-a509-2bba38fe8a8b', N'删除权限组', 10011, N'permission', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'b552ce74-325d-4ad9-baf2-af1dbbbafd22', N'导出支付渠道列表', 20034, N'paychannel', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'c0238c5b-1781-4fa5-9653-e85568d99cfc', N'删除角色', 10023, N'roles', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'c0b264a1-24c3-4aa8-8768-3f9b6f0d0b80', N'菜单权限', 1017, N'menu', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'c8b0d9fe-21fe-4fd7-9733-2813bc379461', N'新增银行', 2002, N'bank', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'cbb5675a-08f6-4cde-84e2-8e2276953838', N'编辑权限组', 10010, N'permission', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'd257eeab-3193-4202-97f3-da77f9f071e8', N'添加管理员', 1003, N'account', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'd2932cb5-7187-4991-9582-c9187f24a300', N'编辑银行', 2003, N'bank', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'd386b067-6002-4c0b-b20e-f5cf2cfb94cf', N'商户详情', 20038, N'merchant', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'da8629ad-3b1c-4ed0-85dd-ad48db5a4ed7', N'删除银行', 2004, N'bank', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'dacbe6b6-d228-49f6-b70d-01250ffc1505', N'编辑角色权限', 10026, N'roles', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'dc369c9d-0d55-4c3a-96e8-b34dadc1411f', N'导出商户列表', 20010, N'merchant', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'e9fb27ac-c8c5-4c87-886c-be2c518da410', N'设置商户银行卡', 20014, N'merchant', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'ec16435d-0057-4557-87c0-a7f8051a7457', N'添加权限组', 1009, N'permission', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'ec7636be-938b-4559-8177-6b32351d98e8', N'新增商户', 2007, N'merchant', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'f335dab2-217a-4f53-9167-9f8661c9b939', N'商户列表', 2006, N'merchant', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'f8cb696b-8fd9-412b-9dc8-19146bfe8f37', N'编辑角色菜单', 10025, N'roles', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_Permission] ([PermId], [PermName], [PermCode], [Controller], [SystemId], [CreateTime]) VALUES (N'fad6c922-8788-4f96-a69f-ffbdf6748fda', N'从权限组中删除权限', 10013, N'permission', 1, CAST(N'2018-10-21T22:03:51.143' AS DateTime))
GO
INSERT [dbo].[SYS_PermissionGroup] ([GroupId], [GroupName], [Permissions], [CreateTime]) VALUES (N'1a6ddb4b-eb48-4464-9e4c-480b86874668', N'系统管理', N'1002,1003,1004,10024,1005,1017,1006,1007,1008,1009,10010,10011,10012,10013,10026,10021,10022,10023,10027,10025', CAST(N'2018-10-13T19:38:10.690' AS DateTime))
GO
INSERT [dbo].[SYS_PermissionGroup] ([GroupId], [GroupName], [Permissions], [CreateTime]) VALUES (N'8e4cf206-df1e-4d4f-98fc-82f61c7591eb', N'运维管理', N'1993,1994', CAST(N'2018-10-19T21:09:24.197' AS DateTime))
GO
INSERT [dbo].[SYS_User] ([SystemUserId], [UserName], [Password], [RealName], [Email], [UserType], [Mobile], [Status], [CreateTime], [SystemId]) VALUES (N'1', N'admin', N'e10adc3949ba59abbe56e057f20f883e', N'admin', N'admin@qq.com', 1, N'13312345678', 0, CAST(N'2018-10-19T00:00:00.000' AS DateTime), 0)
GO
ALTER TABLE [dbo].[SYS_Action] ADD  DEFAULT ((0)) FOR [Sort]
GO
ALTER TABLE [dbo].[SYS_Action] ADD  DEFAULT ((0)) FOR [SystemId]
GO
ALTER TABLE [dbo].[SYS_Role] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[SYS_User] ADD  DEFAULT ((0)) FOR [UserType]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Action', @level2type=N'COLUMN',@level2name=N'ActionId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父菜单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Action', @level2type=N'COLUMN',@level2name=N'ParentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Action', @level2type=N'COLUMN',@level2name=N'ActionName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页面地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Action', @level2type=N'COLUMN',@level2name=N'Url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单图标' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Action', @level2type=N'COLUMN',@level2name=N'IconClass'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Action', @level2type=N'COLUMN',@level2name=N'Sort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分级排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Action', @level2type=N'COLUMN',@level2name=N'LevelSort'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Action', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统菜单表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Action'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_ActionPerms', @level2type=N'COLUMN',@level2name=N'ActionId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_ActionPerms', @level2type=N'COLUMN',@level2name=N'PermCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_ActionPerms', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单权限表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_ActionPerms'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Log', @level2type=N'COLUMN',@level2name=N'LogId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Log', @level2type=N'COLUMN',@level2name=N'LogType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日志备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Log', @level2type=N'COLUMN',@level2name=N'Remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关键字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Log', @level2type=N'COLUMN',@level2name=N'KeyWord'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Log', @level2type=N'COLUMN',@level2name=N'CreatedBy'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Log', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统操作日志表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Log'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Permission', @level2type=N'COLUMN',@level2name=N'PermId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Permission', @level2type=N'COLUMN',@level2name=N'PermName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Permission', @level2type=N'COLUMN',@level2name=N'PermCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'控制器' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Permission', @level2type=N'COLUMN',@level2name=N'Controller'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Permission', @level2type=N'COLUMN',@level2name=N'SystemId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Permission', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限值表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Permission'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限组编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_PermissionGroup', @level2type=N'COLUMN',@level2name=N'GroupId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限组名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_PermissionGroup', @level2type=N'COLUMN',@level2name=N'GroupName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_PermissionGroup', @level2type=N'COLUMN',@level2name=N'Permissions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_PermissionGroup', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限组' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_PermissionGroup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Role', @level2type=N'COLUMN',@level2name=N'SystemRoleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Role', @level2type=N'COLUMN',@level2name=N'RoleName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态(0 正常 1 禁用)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Role', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Role', @level2type=N'COLUMN',@level2name=N'Permissions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Role', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统角色' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_Role'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_RoleMenus', @level2type=N'COLUMN',@level2name=N'RoleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜单编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_RoleMenus', @level2type=N'COLUMN',@level2name=N'ActionId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_RoleMenus', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色菜单表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_RoleMenus'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_User', @level2type=N'COLUMN',@level2name=N'SystemUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'帐号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_User', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_User', @level2type=N'COLUMN',@level2name=N'Password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_User', @level2type=N'COLUMN',@level2name=N'RealName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_User', @level2type=N'COLUMN',@level2name=N'Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否超级管理员(0 普通管理员 1 超级管理员)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_User', @level2type=N'COLUMN',@level2name=N'UserType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_User', @level2type=N'COLUMN',@level2name=N'Mobile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户状态(0 正常 1 锁定)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_User', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_User', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_User', @level2type=N'COLUMN',@level2name=N'SystemId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统用户' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_User'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_UserRoles', @level2type=N'COLUMN',@level2name=N'SystemUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_UserRoles', @level2type=N'COLUMN',@level2name=N'SystemRoleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_UserRoles', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户角色表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SYS_UserRoles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'V_UserRoles' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_UserRoles'
GO
