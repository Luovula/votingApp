-- ═══════════════════════════════════════════════════════
--  Run this ONCE in Supabase → SQL Editor → New query
--  Adds session support so Reset starts a fresh session
--  (old votes are kept in the database for review)
-- ═══════════════════════════════════════════════════════

-- 1. Add session_number to session_state
ALTER TABLE session_state
  ADD COLUMN session_number int NOT NULL DEFAULT 1;

-- 2. Add session_number to votes + update primary key
ALTER TABLE votes
  ADD COLUMN session_number int NOT NULL DEFAULT 1;

ALTER TABLE votes DROP CONSTRAINT votes_pkey;
ALTER TABLE votes
  ADD PRIMARY KEY (session_number, voter_id, question_index);
