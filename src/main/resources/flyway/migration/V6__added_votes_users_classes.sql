CREATE TABLE votes_users_virtual_classes (
  vote_user_virtual_classes_id BIGSERIAL NOT NULL PRIMARY KEY,
  user_id                      BIGINT    NOT NULL  CONSTRAINT votes_users_virtual_classes_user_id_fk REFERENCES users (user_id),
  virtual_class_id             BIGINT    NOT NULL CONSTRAINT votes_users_virtual_classes_virtual_class_id_fk REFERENCES virtual_classes (virtual_class_id),
  vote_type                    BIGINT    NOT NULL
);