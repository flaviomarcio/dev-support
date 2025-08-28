insert into v1_demo_app.v1_demo_app(id, created_at, updated_at, name, enabled) 
values 
 (md5('1')::uuid, now(), now(), 'Demo App 1', true)
,(md5('2')::uuid, now(), now(), 'Demo App 2', true)
on conflict (id) do nothing;