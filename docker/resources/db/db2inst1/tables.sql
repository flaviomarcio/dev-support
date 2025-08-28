create table if not exists v1_demo_app.v1_demo_app(id uuid not null);
alter table v1_demo_app.v1_demo_app add if not exists created_at timestamp not null;
alter table v1_demo_app.v1_demo_app add if not exists updated_at timestamp not null;
alter table v1_demo_app.v1_demo_app add if not exists name varchar(100) not null;
alter table v1_demo_app.v1_demo_app add if not exists enabled boolean not null default true;