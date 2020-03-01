CREATE SEQUENCE persons_id_seq;

CREATE TABLE persons (
                id BIGINT NOT NULL DEFAULT nextval('persons_id_seq'),
                name VARCHAR NOT NULL,
                CONSTRAINT id PRIMARY KEY (id)
);

ALTER SEQUENCE persons_id_seq OWNED BY persons.id;
