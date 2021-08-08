USE [master]
GO
/****** Object:  Database [BookStores]    Script Date: 7/10/2021 11:45:28 PM ******/
CREATE DATABASE [BookStores]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookStores', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\BookStores.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BookStores_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\BookStores_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [BookStores] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookStores].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookStores] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookStores] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookStores] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookStores] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookStores] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookStores] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BookStores] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookStores] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookStores] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookStores] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookStores] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookStores] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookStores] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookStores] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookStores] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BookStores] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookStores] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookStores] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookStores] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookStores] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookStores] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookStores] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookStores] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BookStores] SET  MULTI_USER 
GO
ALTER DATABASE [BookStores] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookStores] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookStores] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookStores] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BookStores] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BookStores] SET QUERY_STORE = OFF
GO
USE [BookStores]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [BookStores]
GO
/****** Object:  Table [dbo].[tblBook]    Script Date: 7/10/2021 11:45:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBook](
	[BookID] [int] IDENTITY(1,1) NOT NULL,
	[BookName] [varchar](50) NULL,
	[image] [varchar](200) NULL,
	[Price] [float] NULL,
	[quantity] [int] NULL,
	[Author] [varchar](50) NULL,
	[CurrentDate] [date] NULL,
	[Status] [bit] NULL,
	[CategoryID] [int] NULL,
 CONSTRAINT [PK__tblBook__3DE0C22743564EC0] PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 7/10/2021 11:45:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDetail]    Script Date: 7/10/2021 11:45:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDetail](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[Price] [float] NULL,
	[quantity] [int] NULL,
	[OrderID] [int] NULL,
	[BookID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDiscount]    Script Date: 7/10/2021 11:45:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDiscount](
	[DiscountID] [int] IDENTITY(1,1) NOT NULL,
	[DiscountName] [varchar](20) NULL,
	[Percents] [int] NULL,
	[CodeName] [varchar](20) NULL,
	[Begindate] [date] NULL,
	[Enddate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrder]    Script Date: 7/10/2021 11:45:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrder](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[DateOrder] [date] NULL,
	[total] [float] NULL,
	[UserID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRoles]    Script Date: 7/10/2021 11:45:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRoles](
	[RoleID] [varchar](50) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
 CONSTRAINT [PK__tblRoles__8AFACE3A96114718] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 7/10/2021 11:45:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[PassWord] [varchar](50) NOT NULL,
	[RoleID] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblBook] ON 
GO
INSERT [dbo].[tblBook] ([BookID], [BookName], [image], [Price], [quantity], [Author], [CurrentDate], [Status], [CategoryID]) VALUES (1, N'The Trials of Apollo 1: The Hidden Oracle', N'9780141363929.jpg', 120, 5, N'Rick Riordan', CAST(N'2021-06-28' AS Date), 1, 1)
GO
INSERT [dbo].[tblBook] ([BookID], [BookName], [image], [Price], [quantity], [Author], [CurrentDate], [Status], [CategoryID]) VALUES (2, N'The Philosophy Book', N'image_180164_1_43_1_57_1_4_1_2_1_210_1_29_1_98_1_25_1_21_1_5_1_3_1_18_1_18_1_45_1_26_1_32_1_14_1_2778.jpg', 150, 5, N'DK', CAST(N'2021-06-28' AS Date), 1, 2)
GO
INSERT [dbo].[tblBook] ([BookID], [BookName], [image], [Price], [quantity], [Author], [CurrentDate], [Status], [CategoryID]) VALUES (5, N'The 28-Day Fast Start', N'image_234983.jpg', 280, 5, N'Gin Stephens', CAST(N'2021-06-28' AS Date), 1, 3)
GO
INSERT [dbo].[tblBook] ([BookID], [BookName], [image], [Price], [quantity], [Author], [CurrentDate], [Status], [CategoryID]) VALUES (6, N'6 Most Important Decisions You''Ll Ever Make', N'9781501157134.jpg', 240, 5, N'Sean Covey', CAST(N'2021-06-28' AS Date), 1, 3)
GO
INSERT [dbo].[tblBook] ([BookID], [BookName], [image], [Price], [quantity], [Author], [CurrentDate], [Status], [CategoryID]) VALUES (7, N'Shoe Dog', N'image_193997.jpg', 180, 5, N'Phil Knight', CAST(N'2021-06-28' AS Date), 1, 2)
GO
INSERT [dbo].[tblBook] ([BookID], [BookName], [image], [Price], [quantity], [Author], [CurrentDate], [Status], [CategoryID]) VALUES (8, N'A Crankenstein Valentine', N'A Crankenstein Valentine book study & companion activities with craftivity K-1.png', 300, 5, N'Samantha Berger', CAST(N'2021-06-28' AS Date), 1, 1)
GO
SET IDENTITY_INSERT [dbo].[tblBook] OFF
GO
SET IDENTITY_INSERT [dbo].[tblCategory] ON 
GO
INSERT [dbo].[tblCategory] ([CategoryID], [CategoryName]) VALUES (1, N'Fantasy')
GO
INSERT [dbo].[tblCategory] ([CategoryID], [CategoryName]) VALUES (2, N'Biograpgy')
GO
INSERT [dbo].[tblCategory] ([CategoryID], [CategoryName]) VALUES (3, N'Health')
GO
SET IDENTITY_INSERT [dbo].[tblCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[tblDiscount] ON 
GO
INSERT [dbo].[tblDiscount] ([DiscountID], [DiscountName], [Percents], [CodeName], [Begindate], [Enddate]) VALUES (1, N'FREESHIP80T7', 50, N'FREESHIP80T7', CAST(N'2021-06-28' AS Date), CAST(N'2021-07-18' AS Date))
GO
INSERT [dbo].[tblDiscount] ([DiscountID], [DiscountName], [Percents], [CodeName], [Begindate], [Enddate]) VALUES (2, N'FREESHIP90T4', 30, N'FREESHIP90T4', CAST(N'2021-06-28' AS Date), CAST(N'2021-07-18' AS Date))
GO
SET IDENTITY_INSERT [dbo].[tblDiscount] OFF
GO
INSERT [dbo].[tblRoles] ([RoleID], [RoleName]) VALUES (N'1', N'Admin')
GO
INSERT [dbo].[tblRoles] ([RoleID], [RoleName]) VALUES (N'2', N'Member')
GO
SET IDENTITY_INSERT [dbo].[tblUsers] ON 
GO
INSERT [dbo].[tblUsers] ([UserID], [UserName], [PassWord], [RoleID]) VALUES (1, N'quynh', N'123456', N'1')
GO
INSERT [dbo].[tblUsers] ([UserID], [UserName], [PassWord], [RoleID]) VALUES (2, N'huong', N'123456', N'2')
GO
SET IDENTITY_INSERT [dbo].[tblUsers] OFF
GO
ALTER TABLE [dbo].[tblBook]  WITH CHECK ADD  CONSTRAINT [FK__tblBook__Categor__2F10007B] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[tblCategory] ([CategoryID])
GO
ALTER TABLE [dbo].[tblBook] CHECK CONSTRAINT [FK__tblBook__Categor__2F10007B]
GO
ALTER TABLE [dbo].[tblDetail]  WITH CHECK ADD  CONSTRAINT [FK__tblDetail__BookI__300424B4] FOREIGN KEY([BookID])
REFERENCES [dbo].[tblBook] ([BookID])
GO
ALTER TABLE [dbo].[tblDetail] CHECK CONSTRAINT [FK__tblDetail__BookI__300424B4]
GO
ALTER TABLE [dbo].[tblDetail]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[tblOrder] ([OrderID])
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[tblUsers] ([UserID])
GO
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD  CONSTRAINT [FK__tblUsers__RoleID__32E0915F] FOREIGN KEY([RoleID])
REFERENCES [dbo].[tblRoles] ([RoleID])
GO
ALTER TABLE [dbo].[tblUsers] CHECK CONSTRAINT [FK__tblUsers__RoleID__32E0915F]
GO
USE [master]
GO
ALTER DATABASE [BookStores] SET  READ_WRITE 
GO
