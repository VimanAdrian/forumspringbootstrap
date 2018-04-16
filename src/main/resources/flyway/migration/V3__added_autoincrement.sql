CREATE SEQUENCE categories_category_id_seq
  OWNED BY categories.category_id;

ALTER TABLE categories
  alter column category_id SET DEFAULT nextval('categories_category_id_seq');

CREATE SEQUENCE users_user_id_seq
  OWNED BY users.user_id;

ALTER TABLE users
  alter column user_id SET DEFAULT nextval('users_user_id_seq');

CREATE SEQUENCE chapter_chapter_id_seq
  OWNED BY chapter.chapter_id;

ALTER TABLE chapter
  alter column chapter_id SET DEFAULT nextval('chapter_chapter_id_seq');

CREATE SEQUENCE class_class_id_seq
  OWNED BY class.class_id;

ALTER TABLE class
  alter column class_id SET DEFAULT nextval('class_class_id_seq');

CREATE SEQUENCE class_followers_class_follow_id_seq
  OWNED BY class_followers.class_follow_id;

ALTER TABLE class_followers
  alter column class_follow_id SET DEFAULT nextval('class_followers_class_follow_id_seq');

CREATE SEQUENCE class_notifications_class_notification_id_seq
  OWNED BY class_notifications.class_notification_id;

ALTER TABLE class_notifications
  alter column class_notification_id SET DEFAULT nextval('class_notifications_class_notification_id_seq');

CREATE SEQUENCE class_rights_class_edit_id_seq
  OWNED BY class_rights.class_edit_id;

ALTER TABLE class_rights
  alter column class_edit_id SET DEFAULT nextval('class_rights_class_edit_id_seq');

CREATE SEQUENCE lecture_lecture_id_seq
  OWNED BY lecture.lecture_id;

ALTER TABLE lecture
  alter column lecture_id SET DEFAULT nextval('lecture_lecture_id_seq');

CREATE SEQUENCE page_page_id_seq
  OWNED BY page.page_id;

ALTER TABLE page
  alter column page_id SET DEFAULT nextval('page_page_id_seq');

CREATE SEQUENCE question_question_id_seq
  OWNED BY question.question_id;

ALTER TABLE question
  alter column question_id SET DEFAULT nextval('question_question_id_seq');

FINISH THIS