CREATE TABLE users (
  user_id            BIGSERIAL   NOT NULL PRIMARY KEY,
  username           VARCHAR(64) NOT NULL,
  password           VARCHAR(64) NOT NULL,
  first_name         VARCHAR(64),
  last_name          VARCHAR(64),
  email              VARCHAR(64) NOT NULL,
  role               VARCHAR(32) NOT NULL,
  creation_date      DATE        NOT NULL,
  enabled            BOOLEAN     NOT NULL,
  profile_image      VARCHAR(64) NOT NULL,
  account_non_locked BOOLEAN     NOT NULL,
  type               VARCHAR(64) NOT NULL
);

CREATE TABLE persistent_logins (
  token     VARCHAR(64)                    NOT NULL PRIMARY KEY,
  username  VARCHAR(64)                    NOT NULL,
  series    VARCHAR(64)                    NOT NULL,
  last_used DATE DEFAULT current_timestamp NOT NULL
);

CREATE TABLE activation_tokens (
  token        VARCHAR(30)                    NOT NULL PRIMARY KEY,
  user_id      BIGINT                         NOT NULL CONSTRAINT activation_tokens_users_user_id_fk REFERENCES users (user_id),
  creationDate DATE DEFAULT current_timestamp NOT NULL
);

CREATE TABLE password_tokens (
  user_id       BIGINT                         NOT NULL CONSTRAINT password_tokens_users_user_id_fk REFERENCES users (user_id),
  token         VARCHAR(30)                    NOT NULL PRIMARY KEY,
  creation_date DATE DEFAULT current_timestamp NOT NULL
);

CREATE TABLE categories (
  category_id BIGSERIAL    NOT NULL PRIMARY KEY,
  title       VARCHAR(128) NOT NULL,
  url         VARCHAR(128) NOT NULL
);

CREATE TABLE virtual_classes (
  virtual_class_id BIGSERIAL     NOT NULL PRIMARY KEY,
  owner            BIGINT        NOT NULL CONSTRAINT virtual_classes_users_user_id_fk REFERENCES users (user_id),
  title            VARCHAR(1024) NOT NULL,
  description      VARCHAR(4096),
  created          DATE          NOT NULL,
  last_active      DATE          NOT NULL,
  visibility       VARCHAR(64)   NOT NULL,
  score            BIGINT  DEFAULT '0',
  views            BIGINT  DEFAULT '0',
  active           BOOLEAN DEFAULT '1'
);

CREATE TABLE virtual_class_followers (
  virtual_class_follow_id BIGSERIAL NOT NULL PRIMARY KEY,
  user_id                 BIGINT    NOT NULL CONSTRAINT virtual_class_followers_users_user_id_fk REFERENCES users (user_id),
  virtual_class_id        BIGINT    NOT NULL    NOT NULL CONSTRAINT virtual_class_followers_virtual_classes_virtual_class_id_fk REFERENCES virtual_classes (virtual_class_id)
);

CREATE TABLE virtual_class_notifications (
  virtual_class_notification_id BIGSERIAL NOT NULL PRIMARY KEY,
  user_id                       BIGINT    NOT NULL CONSTRAINT virtual_class_notifications_users_user_id_fk REFERENCES users (user_id),
  virtual_class_id              BIGINT    NOT NULL CONSTRAINT virtual_class_notifications_virtual_classes_virtual_class_id_fk REFERENCES virtual_classes (virtual_class_id),
  notification_text             VARCHAR(256)
);

CREATE TABLE virtual_class_rights (
  virtual_class_rights_id BIGSERIAL NOT NULL PRIMARY KEY,
  user_id                 BIGINT    NOT NULL CONSTRAINT virtual_class_rights_users_user_id_fk REFERENCES users (user_id),
  virtual_class_id        BIGINT    NOT NULL CONSTRAINT virtual_class_rights_virtual_classes_virtual_class_id_fk REFERENCES virtual_classes (virtual_class_id),
  can_view                BOOLEAN,
  can_edit                BOOLEAN,
  can_post                BOOLEAN
);

CREATE TABLE lectures (
  lecture_id       BIGSERIAL     NOT NULL PRIMARY KEY,
  virtual_class_id BIGINT        NOT NULL CONSTRAINT lectures__virtual_classes_virtual_class_id_fk REFERENCES virtual_classes (virtual_class_id),
  title            VARCHAR(1024) NOT NULL,
  description      VARCHAR(4096),
  created          DATE          NOT NULL,
  last_active      DATE          NOT NULL,
  visibility       VARCHAR(64)   NOT NULL,
  score            BIGINT  DEFAULT '0',
  views            BIGINT  DEFAULT '0',
  active           BOOLEAN DEFAULT '1'
);

CREATE TABLE chapters (
  chapter_id  BIGSERIAL     NOT NULL PRIMARY KEY,
  lecture_id  BIGINT        NOT NULL CONSTRAINT chapters_lectures_lecture_id_fk REFERENCES lectures (lecture_id),
  title       VARCHAR(1024) NOT NULL,
  description VARCHAR(4096),
  created     DATE          NOT NULL,
  last_active DATE          NOT NULL,
  visibility  VARCHAR(64)   NOT NULL,
  score       BIGINT  DEFAULT '0',
  views       BIGINT  DEFAULT '0',
  active      BOOLEAN DEFAULT '1'
);

CREATE TABLE pages (
  page_id     BIGSERIAL     NOT NULL PRIMARY KEY,
  chapter_id  BIGINT        NOT NULL CONSTRAINT pages_chapters_lecture_id_fk REFERENCES chapters (chapter_id),
  title       VARCHAR(1024) NOT NULL,
  content     VARCHAR(8192),
  created     DATE          NOT NULL,
  last_active DATE          NOT NULL,
  visibility  VARCHAR(64)   NOT NULL,
  score       BIGINT  DEFAULT '0',
  views       BIGINT  DEFAULT '0',
  active      BOOLEAN DEFAULT '1'
);

CREATE TABLE questions (
  question_id BIGSERIAL     NOT NULL PRIMARY KEY,
  user_id     BIGINT        NOT NULL CONSTRAINT questions_users_user_id_fk REFERENCES users (user_id),
  lecture_id  BIGINT        NOT NULL CONSTRAINT questions_lectures_lecture_id_fk REFERENCES lectures (lecture_id),
  title       VARCHAR(1024) NOT NULL,
  content     VARCHAR(8192) NOT NULL,
  created     DATE          NOT NULL,
  last_active DATE          NOT NULL,
  views       BIGINT  DEFAULT '0',
  score       BIGINT  DEFAULT '0',
  active      BOOLEAN DEFAULT '1'
);

CREATE TABLE question_categories (
  question_categories_id BIGSERIAL NOT NULL PRIMARY KEY,
  question_id            BIGINT    NOT NULL CONSTRAINT question_categories_questions_question_id_fk REFERENCES questions (question_id),
  category_id            BIGINT    NOT NULL CONSTRAINT question_categories_categories_categoryId_fk REFERENCES categories (category_id)
);

CREATE TABLE question_comments (
  question_comment_id BIGSERIAL NOT NULL PRIMARY KEY,
  user_id             BIGINT    NOT NULL CONSTRAINT questions_comments_users_user_id_fk REFERENCES users (user_id),
  question_id         BIGINT    NOT NULL CONSTRAINT questions_comments_questions_question_id_fk REFERENCES questions (question_id),
  creation_date       DATE      NOT NULL,
  content             VARCHAR(8192)
);

CREATE TABLE replies (
  reply_id      BIGSERIAL     NOT NULL PRIMARY KEY,
  question_id   BIGINT        NOT NULL CONSTRAINT replies_questions_question_id_fk REFERENCES questions (question_id),
  user_id       BIGINT        NOT NULL CONSTRAINT replies_users_user_id_fk REFERENCES users (user_id),
  content       VARCHAR(8192) NOT NULL,
  creation_date DATE          NOT NULL,
  score         BIGINT  DEFAULT '0',
  bestAnswer    BOOLEAN DEFAULT '0',
  enabled       BOOLEAN DEFAULT TRUE
);

CREATE TABLE replies_comments (
  reply_comment_id BIGSERIAL NOT NULL PRIMARY KEY,
  user_id          BIGINT    NOT NULL CONSTRAINT replies_comments_users_user_id_fk REFERENCES users (user_id),
  reply_id         BIGINT    NOT NULL CONSTRAINT replies_comments_questions_question_id_fk REFERENCES replies (reply_id),
  creation_date    DATE      NOT NULL,
  content          VARCHAR(8192)
);

CREATE TABLE user_followers (
  user_followers_id BIGSERIAL NOT NULL PRIMARY KEY,
  follower_user_id  BIGINT    NOT NULL CONSTRAINT user_follow_users_user_id_follower_fk REFERENCES users (user_id),
  followed_user_id  BIGINT    NOT NULL CONSTRAINT user_follow_users_user_id_followed_fk REFERENCES users (user_id)
);

CREATE TABLE user_notifications (
  user_notification_id BIGSERIAL NOT NULL PRIMARY KEY,
  follower_user_id     BIGINT    NOT NULL CONSTRAINT user_notifications_users_user_id_follower_fk REFERENCES users (user_id),
  followed_user_id     BIGINT    NOT NULL CONSTRAINT user_notifications_users_user_id_followed_fk REFERENCES users (user_id),
  notification_text    VARCHAR(256)
);

CREATE TABLE user_new_replies (
  user_new_reply_id BIGSERIAL NOT NULL PRIMARY KEY,
  user_id           BIGINT    NOT NULL CONSTRAINT user_new_replies_users_user_id_fk REFERENCES users (user_id),
  question_id       BIGINT    NOT NULL CONSTRAINT user_new_replies_questions_question_id_fk REFERENCES questions (question_id)
);

CREATE TABLE votes_users_questions (
  vote_user_question_id BIGSERIAL NOT NULL PRIMARY KEY,
  user_id               BIGINT    NOT NULL  CONSTRAINT votes_users_questions_users_user_id_fk REFERENCES users (user_id),
  question_id           BIGINT    NOT NULL CONSTRAINT votes_users_questions_questions_question_id_fk REFERENCES questions (question_id),
  vote_type             BIGINT    NOT NULL
);

CREATE TABLE votes_users_replies (
  vote_user_reply_id BIGSERIAL NOT NULL PRIMARY KEY,
  user_id            BIGINT    NOT NULL CONSTRAINT votes_users_replies_users_user_id_fk REFERENCES users (user_id),
  reply_id           BIGINT    NOT NULL CONSTRAINT votes_users_replies_replies_reply_id_fk REFERENCES replies (reply_id),
  vote_type          BIGINT    NOT NULL
);

