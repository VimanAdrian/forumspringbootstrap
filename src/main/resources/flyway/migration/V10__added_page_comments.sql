drop table replies_comments;

CREATE TABLE pages_comments (
  page_comment_id BIGSERIAL NOT NULL PRIMARY KEY,
  user_id         BIGINT    NOT NULL CONSTRAINT pages_comments_users_user_id_fk REFERENCES users (user_id),
  page_id         BIGINT    NOT NULL CONSTRAINT pages_comments_pages_page_id_fk REFERENCES pages (page_id),
  creation_date   DATE      NOT NULL,
  content         VARCHAR(8192)
);