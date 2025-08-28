--[constraints-fk.sql]


--[constraints-pk.sql]


--[drops.sql]

drop schema if exists v1_demo_app cascade;

--[fakedata.sql]


--[indexes.sql]

create index un_demo_table on v1_demo_app.demo_table using(id);
--[initdata.sql]

insert into v1_demo_app.v1_demo_app(id, created_at, updated_at, name, enabled) 
values 
 (md5('1')::uuid, now(), now(), 'Demo App 1', true)
,(md5('2')::uuid, now(), now(), 'Demo App 2', true)
on conflict (id) do nothing;
--[schemas.sql]

create extension if not exists "uuid-ossp";
create schema if not exists v1_demo_app;
--[tables.sql]

create table if not exists v1_demo_app.v1_demo_app(id uuid not null);
alter table v1_demo_app.v1_demo_app add if not exists created_at timestamp not null;
alter table v1_demo_app.v1_demo_app add if not exists updated_at timestamp not null;
alter table v1_demo_app.v1_demo_app add if not exists name varchar(100) not null;
alter table v1_demo_app.v1_demo_app add if not exists enabled boolean not null default true;
