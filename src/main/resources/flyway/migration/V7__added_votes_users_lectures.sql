CREATE TABLE votes_users_lectures (
  vote_user_lectures_id BIGSERIAL NOT NULL PRIMARY KEY,
  user_id               BIGINT    NOT NULL  CONSTRAINT votes_users_lectures_user_id_fk REFERENCES users (user_id),
  lecture_id            BIGINT    NOT NULL CONSTRAINT votes_users_lectures_lecture_id_fk REFERENCES lectures (lecture_id),
  vote_type             BIGINT    NOT NULL
);