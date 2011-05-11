/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     3/30/2011 7:57:05 PM                         */
/*==============================================================*/


drop table if exists SEC_PERFIL;

drop table if exists SEC_USUARIOS;

drop table if exists SIS_PRODUCTO;

/*==============================================================*/
/* Table: SEC_PERFIL                                            */
/*==============================================================*/
create table SEC_PERFIL
(
   ID_PERFIL            int not null,
   DES_PERFIL           varchar(50) not null,
   primary key (ID_PERFIL)
);

/*==============================================================*/
/* Table: SEC_USUARIOS                                          */
/*==============================================================*/
create table SEC_USUARIOS
(
   ID_USUARIO           int not null,
   DES_USUARIO          varchar(50) not null,
   primary key (ID_USUARIO)
);

/*==============================================================*/
/* Table: SIS_PRODUCTO                                          */
/*==============================================================*/
create table SIS_PRODUCTO
(
   ID_PRODUCTO          int not null,
   NOM_PRODUCTO         varchar(50) not null,
   DES_PRODUCTO         varchar(100) not null,
   primary key (ID_PRODUCTO)
);

