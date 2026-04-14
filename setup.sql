-- ═══════════════════════════════════════════════════════
--  Run this ONCE in Supabase → SQL Editor → New query
-- ═══════════════════════════════════════════════════════

-- 1. Session state (single row that controls the current question)
CREATE TABLE session_state (
  id int PRIMARY KEY DEFAULT 1,
  current_question int NOT NULL DEFAULT 0,
  show_results boolean NOT NULL DEFAULT false,
  reveal_answer boolean NOT NULL DEFAULT false
);

INSERT INTO session_state (id) VALUES (1);

-- 2. Individual votes (one row per student per question)
CREATE TABLE votes (
  voter_id text NOT NULL,
  question_index int NOT NULL,
  choice int NOT NULL,
  created_at timestamptz DEFAULT now(),
  PRIMARY KEY (voter_id, question_index)
);

-- 3. Open access policies (classroom tool, no login needed)
ALTER TABLE session_state ENABLE ROW LEVEL SECURITY;
ALTER TABLE votes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "open" ON session_state FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "open" ON votes FOR ALL USING (true) WITH CHECK (true);

-- 4. Enable real-time on both tables
ALTER PUBLICATION supabase_realtime ADD TABLE session_state;
ALTER PUBLICATION supabase_realtime ADD TABLE votes;
