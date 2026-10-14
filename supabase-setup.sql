-- Sizik Trans shared ledger + private uploaded documents.
-- Run this in Supabase Dashboard -> SQL Editor.
-- All authenticated team members share one company ledger. Do not use the service_role key in the website.

create table if not exists public.ledger_state (
  id text primary key check (id = 'main'),
  payload jsonb not null default '{}'::jsonb,
  updated_by uuid references auth.users(id),
  updated_at timestamptz not null default now()
);

alter table public.ledger_state enable row level security;

drop policy if exists "Authenticated team can read ledger" on public.ledger_state;
create policy "Authenticated team can read ledger"
  on public.ledger_state for select to authenticated using (true);

drop policy if exists "Authenticated team can create ledger" on public.ledger_state;
create policy "Authenticated team can create ledger"
  on public.ledger_state for insert to authenticated with check (true);

drop policy if exists "Authenticated team can update ledger" on public.ledger_state;
create policy "Authenticated team can update ledger"
  on public.ledger_state for update to authenticated using (true) with check (true);

drop policy if exists "Authenticated team can delete ledger" on public.ledger_state;
create policy "Authenticated team can delete ledger"
  on public.ledger_state for delete to authenticated using (true);

-- Private file bucket for PDFs, Excel files and supporting documents.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('sizik-documents', 'sizik-documents', false, 52428800,
  array['application/pdf','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','application/vnd.ms-excel','text/csv','image/png','image/jpeg','application/octet-stream'])
on conflict (id) do update set public = false, file_size_limit = 52428800;

drop policy if exists "Authenticated team can view Sizik documents" on storage.objects;
create policy "Authenticated team can view Sizik documents"
  on storage.objects for select to authenticated using (bucket_id = 'sizik-documents');

drop policy if exists "Authenticated team can upload Sizik documents" on storage.objects;
create policy "Authenticated team can upload Sizik documents"
  on storage.objects for insert to authenticated with check (bucket_id = 'sizik-documents');

drop policy if exists "Authenticated team can update Sizik documents" on storage.objects;
create policy "Authenticated team can update Sizik documents"
  on storage.objects for update to authenticated using (bucket_id = 'sizik-documents') with check (bucket_id = 'sizik-documents');

drop policy if exists "Authenticated team can delete Sizik documents" on storage.objects;
create policy "Authenticated team can delete Sizik documents"
  on storage.objects for delete to authenticated using (bucket_id = 'sizik-documents');
