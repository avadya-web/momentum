create table if not exists public.planner_states (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.planner_states enable row level security;

drop policy if exists "Users can read their own planner state" on public.planner_states;
create policy "Users can read their own planner state"
on public.planner_states
for select
to authenticated
using (auth.uid() is not null and auth.uid() = user_id);

drop policy if exists "Users can create their own planner state" on public.planner_states;
create policy "Users can create their own planner state"
on public.planner_states
for insert
to authenticated
with check (auth.uid() is not null and auth.uid() = user_id);

drop policy if exists "Users can update their own planner state" on public.planner_states;
create policy "Users can update their own planner state"
on public.planner_states
for update
to authenticated
using (auth.uid() is not null and auth.uid() = user_id)
with check (auth.uid() is not null and auth.uid() = user_id);

drop policy if exists "Users can delete their own planner state" on public.planner_states;
create policy "Users can delete their own planner state"
on public.planner_states
for delete
to authenticated
using (auth.uid() is not null and auth.uid() = user_id);
