ALTER TABLE users ADD CONSTRAINT unique_index_users_username UNIQUE (username);

ALTER TABLE users ADD CONSTRAINT unique_index_users_email UNIQUE (email);

ALTER TABLE activation_tokens ADD CONSTRAINT unique_index_activation_tokens_token UNIQUE (token);

ALTER TABLE activation_tokens ADD CONSTRAINT unique_index_activation_tokens_user_id UNIQUE (user_id);

ALTER TABLE password_tokens ADD CONSTRAINT unique_index_password_tokens_token UNIQUE (token);

ALTER TABLE password_tokens ADD CONSTRAINT unique_index_password_tokens_user_id UNIQUE (user_id);

ALTER TABLE categories ADD CONSTRAINT unique_index_categories_title UNIQUE (title);

ALTER TABLE categories ADD CONSTRAINT unique_index_categories_url UNIQUE (url);

ALTER TABLE virtual_class_rights ADD CONSTRAINT unique_index_class_rights_user_id UNIQUE (user_id);

