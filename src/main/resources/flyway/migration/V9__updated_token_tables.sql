drop table activation_tokens;

CREATE TABLE activation_tokens (
  token        VARCHAR(30) NOT NULL PRIMARY KEY,
  user_id      BIGINT      NOT NULL,
  creationDate BIGINT      NOT NULL
);

drop table password_tokens;

CREATE TABLE password_tokens (
  user_id       BIGINT      NOT NULL CONSTRAINT password_tokens_users_user_id_fk REFERENCES users (user_id),
  token         VARCHAR(30) NOT NULL PRIMARY KEY,
  creation_date BIGINT      NOT NULL
);