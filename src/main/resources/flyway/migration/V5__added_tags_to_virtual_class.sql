CREATE TABLE virtual_class_categories (
  virtual_class_categories_id BIGSERIAL NOT NULL PRIMARY KEY,
  virtual_class_id            BIGINT    NOT NULL CONSTRAINT virtual_class_categories_virtual_classes_virtual_class_id_fk REFERENCES virtual_classes (virtual_class_id),
  category_id                 BIGINT    NOT NULL CONSTRAINT virtual_class_categories_category_category_id_fk REFERENCES categories (category_id)
);
