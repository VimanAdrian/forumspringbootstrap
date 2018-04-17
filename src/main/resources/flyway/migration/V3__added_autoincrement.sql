
ALTER TABLE categories
  alter column category_id SET DEFAULT nextval('categories_category_id_seq');

ALTER TABLE users
  alter column user_id SET DEFAULT nextval('users_user_id_seq');

ALTER TABLE chapters
  alter column chapter_id SET DEFAULT nextval('chapters_chapter_id_seq');

ALTER TABLE virtual_classes
  alter column virtual_class_id SET DEFAULT nextval('virtual_classes_virtual_class_id_seq');

ALTER TABLE virtual_class_followers
  alter column virtual_class_follow_id SET DEFAULT nextval('virtual_class_followers_virtual_class_follow_id_seq');

ALTER TABLE virtual_class_notifications
  alter column virtual_class_notification_id SET DEFAULT nextval('virtual_class_notifications_virtual_class_notification_id_seq');

ALTER TABLE virtual_class_rights
  alter column virtual_class_rights_id SET DEFAULT nextval('virtual_class_rights_virtual_class_rights_id_seq');

ALTER TABLE lectures
  alter column lecture_id SET DEFAULT nextval('lectures_lecture_id_seq');

ALTER TABLE pages
  alter column page_id SET DEFAULT nextval('pages_page_id_seq');

ALTER TABLE questions
  alter column question_id SET DEFAULT nextval('questions_question_id_seq');

ALTER TABLE question_categories
  alter column question_categories_id SET DEFAULT nextval('question_categories_question_categories_id_seq');

ALTER TABLE replies_comments
  alter column reply_comment_id SET DEFAULT nextval('replies_comments_reply_comment_id_seq');

ALTER TABLE replies
  alter column reply_id SET DEFAULT nextval('replies_reply_id_seq');

ALTER TABLE user_followers
  alter column user_followers_id SET DEFAULT nextval('user_followers_user_followers_id_seq');

ALTER TABLE user_new_replies
  alter column user_new_reply_id SET DEFAULT nextval('user_new_replies_user_new_reply_id_seq');

ALTER TABLE user_notifications
  alter column user_notification_id SET DEFAULT nextval('user_notifications_user_notification_id_seq');

ALTER TABLE users
  alter column user_id SET DEFAULT nextval('users_user_id_seq');

ALTER TABLE votes_users_questions
  alter column vote_user_question_id SET DEFAULT nextval('votes_users_questions_vote_user_question_id_seq');

ALTER TABLE votes_users_replies
  alter column vote_user_reply_id SET DEFAULT nextval('votes_users_replies_vote_user_reply_id_seq');