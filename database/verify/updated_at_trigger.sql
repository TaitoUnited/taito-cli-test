-- Verify taito-cli-test:updated_at_trigger on pg

BEGIN;

SELECT 'trigger_set_updated_at()'::regprocedure;

ROLLBACK;
