USE [master]
GO
/****** Object:  Database [practica]    Script Date: 08/08/2023 18:55:18 ******/
CREATE DATABASE [practica]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'practica', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\practica.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'practica_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\practica_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [practica] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [practica].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [practica] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [practica] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [practica] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [practica] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [practica] SET ARITHABORT OFF 
GO
ALTER DATABASE [practica] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [practica] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [practica] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [practica] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [practica] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [practica] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [practica] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [practica] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [practica] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [practica] SET  DISABLE_BROKER 
GO
ALTER DATABASE [practica] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [practica] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [practica] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [practica] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [practica] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [practica] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [practica] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [practica] SET RECOVERY FULL 
GO
ALTER DATABASE [practica] SET  MULTI_USER 
GO
ALTER DATABASE [practica] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [practica] SET DB_CHAINING OFF 
GO
ALTER DATABASE [practica] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [practica] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [practica] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [practica] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'practica', N'ON'
GO
ALTER DATABASE [practica] SET QUERY_STORE = ON
GO
ALTER DATABASE [practica] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [practica]
GO
/****** Object:  Table [dbo].[clientes$]    Script Date: 08/08/2023 18:55:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clientes$](
	[CODIGO_CLIENTE] [nvarchar](255) NULL,
	[NOMBRE_CLIENTE] [nvarchar](255) NULL,
	[TIPO_PERSONA] [nvarchar](255) NULL,
	[GENERO] [nvarchar](255) NULL,
	[FECHA_NACIMIENTO] [datetime] NULL,
	[LOCALIDAD] [nvarchar](255) NULL,
	[FECHA_ALTA_CLIENTE] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_clientes]    Script Date: 08/08/2023 18:55:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_clientes]
	as
		select *from clientes$;
GO
/****** Object:  View [dbo].[v_Genero_del_cliente]    Script Date: 08/08/2023 18:55:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_Genero_del_cliente]
		as
		select CODIGO_CLIENTE, NOMBRE_CLIENTE, TIPO_PERSONA,  FECHA_NACIMIENTO, LOCALIDAD,FECHA_ALTA_CLIENTE, GENERO  as 'CODIGO GENERO', case
				when GENERO like 'F' then 'Femenino'
				when GENERO like 'M' then 'Masculino'
				else 'Juridico'
		end as 'Genero'
		from clientes$;
GO
/****** Object:  Table [dbo].[moneda$]    Script Date: 08/08/2023 18:55:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[moneda$](
	[COD_MONEDA] [nvarchar](255) NULL,
	[DESCRIPCION] [nvarchar](255) NULL,
	[COTIZACION] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productos$]    Script Date: 08/08/2023 18:55:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productos$](
	[OPERACION] [nvarchar](255) NULL,
	[CODIGO_CLIENTE] [nvarchar](255) NULL,
	[MONEDA] [nvarchar](255) NULL,
	[TIPO_CARTERA] [nvarchar](255) NULL,
	[SALDO_CAPITAL] [float] NULL,
	[SALDO_INTERES] [float] NULL,
	[FECHA_PROCESO] [datetime] NULL,
	[FECHA_VENCIMIENTO] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_productos_cotizacion]    Script Date: 08/08/2023 18:55:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_productos_cotizacion]
as
	select p.*, m.COTIZACION, m.DESCRIPCION 
	from productos$ as p 
	inner join moneda$ as m 
	on p.MONEDA=m.COD_MONEDA
GO
/****** Object:  Table [dbo].[genero$]    Script Date: 08/08/2023 18:55:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[genero$](
	[COD_GENERO] [nvarchar](255) NULL,
	[DESCRIPCION] [nvarchar](255) NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [practica] SET  READ_WRITE 
GO
