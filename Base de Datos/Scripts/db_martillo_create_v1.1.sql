/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     5/9/2011 12:50:35 PM                         */
/*==============================================================*/


drop table if exists SEC_AUTENTICATION;

drop table if exists SEC_PERFIL;

drop table if exists SEC_USUARIOS;

drop table if exists SIS_CATEGORIA;

drop table if exists SIS_PRODUCTO;

drop table if exists SIS_SUBASTA;

/*==============================================================*/
/* Table: SEC_AUTENTICATION                                     */
/*==============================================================*/
create table SEC_AUTENTICATION
(
   ID_AUTENTICACION     int not null auto_increment,
   ID_PERFIL            int,
   ID_USUARIO           int,
   COOKIE               varchar(100) not null,
   primary key (ID_AUTENTICACION)
);

/*==============================================================*/
/* Table: SEC_PERFIL                                            */
/*==============================================================*/
create table SEC_PERFIL
(
   ID_PERFIL            int not null auto_increment,
   DES_PERFIL           varchar(50) not null,
   primary key (ID_PERFIL)
);

/*==============================================================*/
/* Table: SEC_USUARIOS                                          */
/*==============================================================*/
create table SEC_USUARIOS
(
   ID_USUARIO           int not null auto_increment,
   DES_USUARIO          varchar(50) not null,
   PWD                  varchar(50) not null,
   primary key (ID_USUARIO)
);

/*==============================================================*/
/* Table: SIS_CATEGORIA                                         */
/*==============================================================*/
create table SIS_CATEGORIA
(
   ID_CATEGORIA         int not null auto_increment,
   DES_CATEGORIA        varchar(50) not null,
   primary key (ID_CATEGORIA)
);

/*==============================================================*/
/* Table: SIS_PRODUCTO                                          */
/*==============================================================*/
create table SIS_PRODUCTO
(
   ID_PRODUCTO          int not null auto_increment,
   ID_CATEGORIA         int,
   NOM_PRODUCTO         varchar(50) not null,
   DES_PRODUCTO         varchar(100) not null,
   primary key (ID_PRODUCTO)
);

/*==============================================================*/
/* Table: SIS_SUBASTA                                           */
/*==============================================================*/
create table SIS_SUBASTA
(
   ID_SUBASTA           int not null auto_increment,
   ID_USUARIO           int,
   ID_PRODUCTO          int,
   DES_SUBASTA          varchar(100) not null,
   primary key (ID_SUBASTA)
);

alter table SEC_AUTENTICATION add constraint FK_RELATIONSHIP_1 foreign key (ID_USUARIO)
      references SEC_USUARIOS (ID_USUARIO) on delete restrict on update restrict;

alter table SEC_AUTENTICATION add constraint FK_RELATIONSHIP_2 foreign key (ID_PERFIL)
      references SEC_PERFIL (ID_PERFIL) on delete restrict on update restrict;

alter table SIS_PRODUCTO add constraint FK_RELATIONSHIP_3 foreign key (ID_CATEGORIA)
      references SIS_CATEGORIA (ID_CATEGORIA) on delete restrict on update restrict;

alter table SIS_SUBASTA add constraint FK_RELATIONSHIP_4 foreign key (ID_PRODUCTO)
      references SIS_PRODUCTO (ID_PRODUCTO) on delete restrict on update restrict;

alter table SIS_SUBASTA add constraint FK_RELATIONSHIP_5 foreign key (ID_USUARIO)
      references SEC_USUARIOS (ID_USUARIO) on delete restrict on update restrict;

