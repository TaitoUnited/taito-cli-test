-- Revert taito-cli-test:posts from pg

BEGIN;

DROP TABLE posts;

COMMIT;
