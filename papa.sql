CREATE TABLE articles (
    id              SERIAL PRIMARY KEY,
    ip              inet,
    body            text,
    created_at      timestamp,
    is_delete       boolean DEFAULT false
);
